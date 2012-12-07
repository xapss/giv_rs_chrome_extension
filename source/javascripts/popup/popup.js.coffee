giv_rs = 'http://giv.rs/'
fb_app_id = 180590545411323
caption = 'giv.rs link'
description = 'This url was shortened using giv.rs, the charity url shortener.'
picture_url = "#{giv_rs}assets/logo.png"

$(document).ready ->
  short_url = $('#short_url')
  statistics = $('#statistics')
  facebook = $('#facebook')
  twitter = $('#twitter')
  chrome.tabs.getSelected null, (tab) ->
    $.post giv_rs,
      link:
        url: tab.url
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
      $('#copy').click (e) ->
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
      $('#qr_code').click (e) ->
        e.preventDefault()
        $('#short_url_qr_code').qrcode
          text: url
          width: 128
          height: 128



