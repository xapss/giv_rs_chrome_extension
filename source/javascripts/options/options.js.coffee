cause_disabled = (redirect_type) ->
  redirect_type != 'frame' && redirect_type != 'timer'

update_causes = (redirect_type) ->
  if cause_disabled redirect_type
    $('.cause').removeClass('selected').children('input').prop 'checked', false

update_redirect_types = ->
  redirect_type = $('.redirect_type input:checked').val()
  if !redirect_type || cause_disabled redirect_type
    $('#redirect_frame input').prop('checked', true).click()

$(document).ready ->
  $.getJSON 'http://giv.rs/causes', ->
    $.each data, (_, cause) ->
      cause_input_id = "cause_#{cause._id}"
      cause_input = $('<input>')
        .attr('id', cause_input_id)
        .attr('name', 'cause_id')
        .attr('type', 'radio')
        .attr 'value', cause._id
      cause_label = $('<label></label>')
        .attr('for', cause_input_id)
        .text cause.name
      cause_article = $('<article></article>')
        .addClass('cause')
        .attr('title', cause.name)
        .css('background-image', "url(#{cause.button.url})")
        .append(cause_input)
        .append cause_label
      $('#causes').append(cause_article)

    $('#settings').values(localStorage)
    $('input:checked').click()

    $(document).on 'change', '.redirect_type input', ->
      update_causes $(@).val()
    $(document).on 'change', '.cause input', ->
      update_redirect_types()
    $(document).on 'change', 'input[type=radio]', ->
      $(@).parents('form').submit()

$(document).on 'submit', '#settings', (e) ->
  e.preventDefault()
  if cause_disabled($('.redirect_type input:checked').val()) != ($('.cause input:checked').length == 1)
    $.extend localStorage, $(@).values()
    localStorage.removeItem 'cause_id' if cause_disabled localStorage['redirect_type']

