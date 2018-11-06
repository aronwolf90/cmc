#= require jquery2
#= require rails-ujs
#= require popper
#= require bootstrap
#= require turbolinks
#= require select2
#= require moment
#= require bootstrap-datetimepicker

#= require cable

@jqueryFuncs = () =>
    $('.datetimepicker').datetimepicker(
      sideBySide: true,
      format: 'YYYY-MM-DD HH:mm',
    )
    $('.datepicker').datetimepicker(
      format: 'YYYY-MM-DD',
    )
    $('.timepicker').datetimepicker(
      format: 'HH:mm',
    )
    $('[data-toggle="tooltip"]').tooltip()
    $('select[multiple]').select2({ theme: "bootstrap" })
    $('body, [data-dismiss="modal"]').click => 
      $('.modal').modal('hide')
    $('.modal-content').click (event) => event.stopPropagation()


  jQuery.extend(true, jQuery.fn.datetimepicker.defaults, {
    icons: {
      time:     'fa fa-clock',
      date:     'fa fa-calendar',
      up:       'fa fa-arrow-up',
      down:     'fa fa-arrow-down',
      previous: 'fa fa-chevron-left',
      next:     'fa fa-chevron-right',
      today:    'fa fa-calendar-check',
      clear:    'fa fa-trash-alt',
      close:    'fa fa-times-circle'
    }
  });

document.addEventListener 'turbolinks:load', =>
  setTimeout ( =>
    jqueryFuncs()
  ), 100
