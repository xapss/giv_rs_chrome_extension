$(document).on 'click', '.redirect_type', ->
  $(@).children('input').prop('checked', true).change()
  $('.redirect_type').removeClass('selected')
  $(@).addClass('selected')

$(document).on 'click', '.cause', ->
  $(@).children('input').prop('checked', true).change()
  $('.cause').removeClass('selected')
  $(@).addClass('selected')