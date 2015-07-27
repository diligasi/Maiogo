jQuery ->
  $('body').prepend('<div id="fb-root"></div>')
#
#  $.ajax
#    url: "#{window.location.protocol}//connect.facebook.net/pt_BR/all.js"
#    dataType: 'script'
#    cache: true


window.fbAsyncInit = ->
  FB.init
    appId: '678816145563684'
    cookie: true
    xfbml: true
    version: 'v2.4'

((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  if d.getElementById(id)
    return
  js = d.createElement(s)
  js.id = id
  js.src = '//connect.facebook.net/pt_BR/sdk.js'
  fjs.parentNode.insertBefore js, fjs
  return
) document, 'script', 'facebook-jssdk'

#  $('#sign_in').click (e) ->
#    e.preventDefault()
#    FB.login (response) ->
#      window.location = '/auth/facebook/callback' if response.authResponse
#
#  $('#sign_out').click (e) ->
#    FB.getLoginStatus (response) ->
#      FB.logout() if response.authResponse
#    true