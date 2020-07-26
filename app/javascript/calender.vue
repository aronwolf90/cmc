<template lang='pug'>
.calender
  .header.row
    .col-sm-3
      .btn-group
        slot(name='today', v-bind='{setToday, todayDate, calendar}')
          a.btn.btn-outline-secondary(@click='setToday') Today
        slot(name='view', v-bind='{currentType, types}')
          a.btn.btn-outline-secondary.dropdown-toggle(
            data-toggle='dropdown',
            aria-haspopup='true',
            aria-expanded='false'
          )
            | {{ currentType.label }}
          .dropdown-menu
            a.dropdown-item(
              @click='currentType = type',
              v-for='type in types'
            ) {{ type.label }}
    .col-sm-6.text-center
      slot(name='prev', v-bind='{prev, prevLabel, calendar}')
        button.btn.btn-link(@click='prev')
          .fa.fa-angle-left.fa-lg
      slot(name='summary', v-bind='{summary, calendar}') {{ summary}} 
      slot(name='next', v-bind='{next, nextLabel, calendar}')
        button.btn.btn-link(@click='next')
          .fa.fa-angle-right.fa-lg
    .col-sm-3
      .pull-right
        b-button(
          v-b-modal.create-event-dialog="",
          variant="outline-secondary"
        ) Add event

  .content.vuetify
    ds-gestures(@swipeleft='next', @swiperight='prev')
      .ds-expand(v-if='currentType.schedule')
        slot(
          name='calendarAppAgenda',
          v-bind='{$scopedSlots, $listeners, calendar, add, edit, viewDay}'
        )
          ds-agenda(
            v-bind='{$scopedSlots}',
            v-on='$listeners',
            :read-only='readOnly',
            :calendar='calendar',
            @add='add',
            @edit='edit',
            @view-day='viewDay'
          )
      .ds-expand(v-else='')
        slot(
          name='calendarAppCalendar',
          v-bind='{$scopedSlots,$listeners,calendar,add,addAt,edit,viewDay, handleAdd,handleMove}'
        )
          ds-calendar(
            ref='calendar',
            v-bind='{$scopedSlots}',
            v-on='$listeners',
            :calendar='calendar',
            :read-only='readOnly',
            @add='add',
            @add-at='addAt',
            @edit='edit',
            @view-day='viewDay',
            @added='handleAdd',
            @moved='handleMove'
          )
  create-event-dialog
  update-event-dialog(:event-id='editEdventId')
</template>

<script>
import {
  Constants,
  Sorts,
  Calendar,
  Day,
  Units,
  Weekday,
  Month,
  DaySpan,
  PatternMap,
  Time,
  Op
} from 'dayspan';
import 'dayspan-vuetify/dist/lib/dayspan-vuetify.min.css'
import { Utils } from 'vuex-jsonapi-client'
import CreateEventDialog from 'calender/create_event_dialog'
import UpdateEventDialog from 'calender/update_event_dialog'

export default {
  name: 'dsCalendarApp',
  components: {
    CreateEventDialog,
    UpdateEventDialog
  },
  props:
  {
    calendar:
    {
      type: Calendar,
      default() {
        return Calendar.months();
      }
    },
    readOnly:
    {
      type: Boolean,
      default: false
    },
    types:
    {
      type: Array,
      default() {
        return this.$dsDefaults().types;
      }
    },
    allowsAddToday:
    {
      type: Boolean,
      default() {
        return this.$dsDefaults().allowsAddToday;
      }
    },
    formats:
    {
      validate(x) {
        return this.$dsValidate(x, 'formats');
      },
      default() {
        return this.$dsDefaults().formats;
      }
    },
    labels:
    {
      validate(x) {
        return this.$dsValidate(x, 'labels');
      },
      default() {
        return this.$dsDefaults().labels;
      }
    },
    styles:
    {
      validate(x) {
        return this.$dsValidate(x, 'styles');
      },
      default() {
        return this.$dsDefaults().styles;
      }
    },
    optionsDialog:
    {
      validate(x) {
        return this.$dsValidate(x, 'optionsDialog');
      },
      default() {
        return this.$dsDefaults().optionsDialog;
      }
    },
    promptDialog:
    {
      validate(x) {
        return this.$dsValidate(x, 'promptDialog');
      },
      default() {
        return this.$dsDefaults().promptDialog;
      }
    }
  },
  data: vm => ({
    drawer: null,
    optionsVisible: false,
    options: [],
    promptVisible: false,
    promptQuestion: '',
    promptCallback: null,
    editEdventId: null
  }),
  created () {
    this.$store.dispatch('initEvents')
  },
  watch:
  {
    'events': 'applyEvents',
    'calendar': 'applyEvents'
  },
  computed:
  {
    events () {
      return (this.$store.getters.collection('events') || []).map(event => {
        let startTime = Utils.attribute(event, 'start-time')
        let endTime = Utils.attribute(event, 'end-time')
        let allDay = Utils.attribute(event, 'all-day') 

        return {
          data: {
            title: Utils.attribute(event, 'title'),
            color: '#b3b3ff', 
            id: event.id
          },
          schedule: {
            year: parseInt(startTime.substring(0, 4)),
            month: [parseInt(startTime.substring(5, 7)) - 1],
            dayOfMonth: [parseInt(startTime.substring(8, 10))],
            times: allDay ? null : [startTime.substring(11, 19)],
            duration: allDay ? null : (new Date(endTime) - new Date(startTime))/3600000
          }
        }
      })
    },
    currentType:
    {
      get()
      {
        return this.types.find((type) =>
          type.type === this.calendar.type &&
          type.size === this.calendar.size
        ) || this.types[0];
      },
      set(type)
      {
        this.rebuild(undefined, true, type);
      }
    },
    summary()
    {
      let small = this.$vuetify.breakpoint.xs;
      if (small)
      {
        return this.calendar.start.format( this.formats.xs );
      }
      let large = this.$vuetify.breakpoint.mdAndUp;
      return this.calendar.summary(false, !large, false, !large);
    },
    todayDate()
    {
      return this.$dayspan.today.format( this.formats.today );
    },
    nextLabel()
    {
      return this.labels.next( this.currentType );
    },
    prevLabel()
    {
      return this.labels.prev( this.currentType );
    },
    hasCreatePopover()
    {
      return !!this.$scopedSlots.eventCreatePopover;
    },
    canAddDay()
    {
      return false//this.$dayspan.features.addDay && !this.readOnly && !this.$dayspan.readOnly;
    },
    canAddTime()
    {
      return false//this.$dayspan.features.addTime && !this.readOnly && !this.$dayspan.readOnly;
    }
  },
  mounted()
  {
    if (!this.$dayspan.promptOpen)
    {
      this.$dayspan.promptOpen = (question, callback) => {
        this.promptVisible = false;
        this.promptQuestion = question;
        this.promptCallback = callback;
        this.promptVisible = true;
      };
    }
    this.applyEvents()
  },
  methods:
  {
    setState(state)
    {
      state.eventSorter = state.listTimes
        ? Sorts.List([Sorts.FullDay, Sorts.Start])
        : Sorts.Start;
      this.calendar.set( state );
      this.triggerChange();
    },
    applyEvents()
    {
      if (this.events)
      {
        this.calendar.removeEvents();
        this.calendar.addEvents(this.events);
      }
    },
    isType(type, aroundDay)
    {
      let cal = this.calendar;
      return (cal.type === type.type && cal.size === type.size &&
          (!aroundDay || cal.span.matchesDay(aroundDay)));
    },
    rebuild (aroundDay, force, forceType)
    {
      let type = forceType || this.currentType || this.types[ 2 ];
      if (this.isType( type, aroundDay ) && !force)
      {
        return;
      }
      let input = {
        type: type.type,
        size: type.size,
        around: aroundDay,
        eventsOutside: true,
        preferToday: false,
        listTimes: type.listTimes,
        updateRows: type.updateRows,
        updateColumns: type.listTimes,
        fill: !type.listTimes,
        otherwiseFocus: type.focus,
        repeatCovers: type.repeat
      };
      this.setState( input );
    },
    next()
    {
      this.calendar.unselect().next();
      this.triggerChange();
    },
    prev()
    {
      this.calendar.unselect().prev();
      this.triggerChange();
    },
    setToday()
    {
      this.rebuild( this.$dayspan.today );
    },
    viewDay(day)
    {
      this.rebuild( day, false, this.types[ 0 ] );
    },
    edit(calendarEvent) {
      this.editEdventId = calendarEvent.data.id
      this.$root.$emit('bv::show::modal', 'update-event-dialog')
    },
    editPlaceholder(createEdit) {},
    add(day) {},
    addAt(dayHour) {},
    addToday() {},
    handleAdd(addEvent) {},
    handleMove(moveEvent) {},
    chooseOption(option) {},
    choosePrompt(yes) {},
    eventFinish(ev) {},
    eventsRefresh() {},
    triggerChange() {}
  }
}
</script>

<style lang="sass" scoped>
.calender
  height: 100%
  .header
    z-index: 1000;
    height: 60px
  .content
    height: calc(100% - 60px)
</style>
