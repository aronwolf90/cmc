#= require jquery2
#= require rails-ujs
#= require popper
#= require bootstrap
#= require turbolinks
#= require datetimepicker
#= require select2

#= require cable

document.addEventListener 'turbolinks:load', =>
  setTimeout ( =>
    $('.datetimepicker').datetimepicker()
    $('[data-toggle="tooltip"]').tooltip()
    $('select[multiple]').select2({ theme: "bootstrap" })
    $('body, [data-dismiss="modal"]').click => 
      $('.modal').modal('hide')
    $('.modal-content').click (event) => event.stopPropagation()
  ), 100
