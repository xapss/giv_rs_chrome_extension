giv_rs_host = 'giv.rs'
giv_rs = "http://#{giv_rs_host}/"
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

$(document).on 'click', '#close', (e) ->
  e.preventDefault()
  window.close()

$(document).on 'click', '#settings', (e) ->
  e.preventDefault()
  chrome.tabs.create
    url: chrome.extension.getURL 'options.html'

$(document).on 'click', 'a[href=#]', (e) ->
  e.preventDefault()

$(document).ready ->
  short_url = $('#short_url')

  twitter = $('#twitter')
  facebook = $('#facebook')
  google = $('#google')
  linkedin = $('#linkedin')
  hootsuite = $('#hootsuite')

  #edit = $('#edit')
  statistics = $('#statistics')
  qr_code = $('#qr_code')

  qr_code_wrapper = $('#qr_code_wrapper')

  chrome.tabs.getSelected null, (tab) ->
    find_original_url tab.url, (original_url) ->
      $.post giv_rs,
        link:
          $.extend localStorage, {url: original_url}
      , (data) ->
        url = "#{giv_rs}#{data._id}"
        url_without_protocol = "#{giv_rs_host}/#{data._id}"
        statistics_url = "#{url}+"
        twitter_url = "https://twitter.com/intent/tweet?url=#{url}&text=@giv_rs"
        facebook_url = "https://www.facebook.com/dialog/feed?app_id=#{fb_app_id}&redirect_uri=#{statistics_url}&link=#{url}"
        google_url = "https://plus.google.com/share&url=#{url}"
        linkedin_url = "https://www.linkedin.com/shareArticle?mini=true&url=#{url}"
        qr_code_url = "https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=#{url}"
        hootsuite_url = "http://hootsuite.com/hootlet/load?address=#{url}"

        short_url.attr 'href', url
        short_url.text url_without_protocol
        statistics.attr 'href', statistics_url
        twitter.attr 'href', twitter_url
        facebook.attr 'href', facebook_url
        google.attr 'href', google_url
        linkedin.attr 'href', linkedin_url
        hootsuite.attr 'href', hootsuite_url
        qr_code_image = $('<img>').attr('id', 'qr_code_image').attr('src', qr_code_url)
        qr_code_wrapper.append(qr_code_image)

        short_url.click (e) ->
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
        qr_code.click (e) ->
          e.preventDefault()
          qr_code_wrapper.slideDown()
