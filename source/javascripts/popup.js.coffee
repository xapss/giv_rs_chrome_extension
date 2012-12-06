giv_rs = 'http://giv.rs/'

$(document).ready ->
  short_url = $('#short_url')
  details = $('#details')
  chrome.tabs.getSelected null, (tab) ->
    $.post giv_rs,
      link:
        url: tab.url
    , (data) ->
      url = "#{giv_rs}#{data._id}"
      details_url = "#{url}+"
      short_url.attr 'href', url
      short_url.text url
      details.attr 'href', details_url
      $("#copy").click (e) ->
        e.preventDefault()
        elem = short_url.get(0)
        elem.contentEditable = true
        elem.unselectable = "off"
        short_url.focus()
        document.execCommand "SelectAll"
        document.execCommand "Copy", false, null
        elem.contentEditable = false
        elem.unselectable = "on"
        document.execCommand "UnSelect"
        short_url.blur()



