giv_rs = 'http://giv.rs/'
fb_app_id = 180590545411323
caption = 'giv.rs link'
description = 'This url was shortened using giv.rs, the charity url shortener.'
picture_url = "#{giv_rs}assets/logo.png"

find_original_url = (url, success) ->
  if /http:\/\/giv.rs\/[A-Za-z0-9]+$/.test url
    $.getJSON "#{url}.json", (data) ->
      find_original_url data.url, success
  else
    success? url

$(document).ready ->
  short_url = $('#short_url')
  statistics = $('#statistics')
  facebook = $('#facebook')
  twitter = $('#twitter')
  settings = $('#settings')
  $(settings).click (e) ->
    e.preventDefault()
    chrome.tabs.create
      url: chrome.extension.getURL 'options.html'
  chrome.tabs.getSelected null, (tab) ->
    find_original_url tab.url, (original_url) ->
      $.post giv_rs,
        link:
          $.extend localStorage, {url: original_url}
      , (data) ->
        url = "#{giv_rs}#{data._id}"
        statistics_url = "#{url}+"
        facebook_url = "https://www.facebook.com/dialog/feed?app_id=#{encodeURIComponent fb_app_id}&link=#{encodeURIComponent url}&picture=#{encodeURIComponent picture_url}&name=#{encodeURIComponent url}&caption=#{encodeURIComponent caption}&description=#{encodeURIComponent description}&redirect_uri=#{encodeURIComponent url}"
        tweet_text = "#{url} @giv_rs"
        twitter_url = "https://twitter.com/home?status=#{encodeURIComponent tweet_text}"
        short_url.attr 'href', url
        short_url.text url
        statistics.attr 'href', statistics_url
        facebook.attr 'href', facebook_url
        twitter.attr 'href', twitter_url
        $('#copy, #short_url').click (e) ->
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
          short_url.fadeOut ->
            short_url.fadeIn()
        $('#qr_code').click (e) ->
          e.preventDefault()
          $('#short_url_qr_code').qrcode
            text: url
            width: 128
            height: 128
