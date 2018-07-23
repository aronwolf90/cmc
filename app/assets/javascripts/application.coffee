#= require jquery2
#= require rails-ujs
#= require popper
#= require bootstrap
#= require turbolinks
#= require datetimepicker

#= require cable

document.addEventListener 'turbolinks:load', =>
  setTimeout ( =>
    $('.datetimepicker').datetimepicker()
    $('[data-toggle="tooltip"]').tooltip()
  ), 100
