$(document).ready ->
  $('.redirect_type input[checked]').parents('.redirect_type').addClass('selected')
  $('.cause input[checked]').parents('.cause').addClass('selected')

$(document).on 'click', '.redirect_type', ->
  $(@).children('input').attr('checked', 'checked').change()
  $('.redirect_type').removeClass('selected')
  $(@).addClass('selected')

$(document).on 'click', '.cause', ->
  $(@).children('input').attr('checked', 'checked').change()
  $('.cause').removeClass('selected')
  $(@).addClass('selected')