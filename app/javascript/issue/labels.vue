<template lang='pug'>
  .labels
    .pull-right.b-button(v-b-modal.modal-label-new="")
      .fa.fa-plus
    a.title.pointer(@click="$bvModal.show('modal-label-index')")
      | Labels
    v-select(
      id="labels",
      multiple="",
      v-model="selected",
      :options="options",
      :getOptionLabel="getLabel"
    )
      <template #selected-option-container="{ option, deselect, multiple, disabled }">
        .vs__selected.text-white(
          v-bind:style="{ 'background-color': getColor(option) }"
        )
          .font-weight-bold {{ getLabel(option) }}&nbsp;
          button.vs__deselect
            .fa.fa-times.text-white(@click="deselect(option)")
      </template>
    label-modal(
      id="modal-label-new",
      title="New label"
    )
    label-modal-index
</template>

<script>
import { Utils } from 'vuex-jsonapi-client'
import LabelModal from './label-modal'
import LabelModalIndex from './label-modal-index'

export default {
  props: ['issueRef'],
  components: {
    LabelModal,
    LabelModalIndex
  },
  data () {
    return {
      searchText: ''
    }
  },
  computed: {
    options () {
      return Utils.entryArrayToRef(
        this.$store.getters.collection('labels') || [])
    },
    issue () {
      return this.$store.getters.entry(this.issueRef)
    },
    selected: {
      set (labelRefs) {
        this.$store.dispatch('update', {
          entry: this.issue,
          payload: {
            relationships: {
              labels: {
                data: labelRefs
              }
            }
          }
        })
      },
      get () {
        return Utils.relationship(this.issue, 'labels')
      }
    }
  },
  methods: {
    getLabel (labelRef) {
      return Utils.attribute(
        this.$store.getters.entry(labelRef),
        'name'
      )
    },
    getColor (labelRef) {
      return Utils.attribute(
        this.$store.getters.entry(labelRef),
        'color'
      )
    }
  }
}
</script>

<style lang='sass' scoped>
  .labels
    margin-left: 7px
    margin-right: 3px
  a.title
    margin-top: 8px
    margin-left: 14px
    margin-bottom: 4px
    color: grey !important
  .fa.fa-plus
    color: grey !important
  .pointer
    cursor: pointer
</style>
