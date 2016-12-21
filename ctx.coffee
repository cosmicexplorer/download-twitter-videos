twitter_video_base = 'https://video.twimg.com/'

processVideo = (str) ->
  completed_playlist = str.replace(/^\//gm, twitter_video_base)
  console.log completed_playlist

processHtml = (str) ->
  doc = new DOMParser().parseFromString(str, 'text/html')
  player = doc.querySelectorAll('div.player-container')[0]
  m3u8_url = JSON.parse(player.getAttribute('data-config')).video_url
  xhr = new XMLHttpRequest
  xhr.open('GET', m3u8_url)
  xhr.onload = -> processVideo(xhr.response)
  xhr.onerror = -> notifyError(xhr.response)
  xhr.send()

notifyError = (str) -> alert(str)

genericOnClick = (info, tab) ->
  console.log info
  url = info.frameUrl
  xhr = new XMLHttpRequest
  xhr.open('GET', url)
  xhr.onload = -> processHtml(xhr.response)
  xhr.onerror = -> notifyError(xhr.response)
  xhr.send()

chrome.contextMenus.create
  type: 'normal'
  title: 'a'
  contexts: ['all']
  onclick: genericOnClick
