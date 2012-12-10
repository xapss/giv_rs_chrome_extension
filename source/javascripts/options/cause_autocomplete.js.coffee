$(document).on 'keyup', '#cause_autocomplete', (e) ->
  if(e.keyCode == 13)
    e.preventDefault()
  else
    value = $(@).val()
    re = new RegExp RegExp.escape(value), 'i'
    show = false
    $('.cause').each ->
      if re.test $(@).children('label').text()
        $(@).show()
        show = true
      else
        $(@).hide()
    if show
      $('#cause_list').show()
    else
      $('#cause_list').hide()
