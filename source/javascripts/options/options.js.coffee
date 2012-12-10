cause_disabled = (redirect_type) ->
  redirect_type != 'frame' && redirect_type != 'timer'

update_causes = (value) ->
  if cause_disabled value
    $('#causes').hide()
  else
    $('#causes').show()

$(document).ready ->
  update_causes()
  $.get 'http://giv.rs/causes', (data) ->
    $.each data, (_, cause) ->
      $('#cause_list').append("<a class='cause' href='#cause_#{cause._id}' id='cause_#{cause._id}'><label style='background-image: url(#{cause.logo.frame.url})' title='#{cause.name}'>#{cause.name}</label><input name='cause_id' type='radio' value='#{cause._id}'></a>")
    $('#settings').values(localStorage)
    update_causes $('.redirect_type input[checked]').val()
    $('.cause input[checked]').parent().click()
    $(document).on 'change', 'input[type=radio]', ->
      $(@).parents('form').submit()

$(document).on 'submit', '#settings', (e) ->
  e.preventDefault()
  unless cause_disabled($('.redirect_type input[checked]').val()) && $('.cause input[checked]').length == 0
    $.extend localStorage, $(@).values()
    localStorage.removeItem 'cause_id' if cause_disabled localStorage['redirect_type']

$(document).on 'change', '.redirect_type input', ->
  update_causes $(@).val()

