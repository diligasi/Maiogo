$('#confirm-name').hide()
$('.warn-message').hide()
$('.error-message').hide()
$('.success-message').hide()

$('.confirmation form#check-name').submit (e) ->
  e.preventDefault()
  if $('#confirmation-name').val().length > 0
    postdata = $('.confirmation form#check-name').serialize()
    $.ajax
      type: 'POST'
      url: 'find_guest/'
      data: postdata
      dataType: 'json'
      success: (json) ->
        if json.status and !json.data.is_confirmed
          hideAll()
          $('#guest_id').val json.data.id
          $('#confirmation_name').val json.data.name
          $('#accompanying_number').attr
            'min': 0
            'max': json.data.accompanying_number
            'value': json.data.accompanying_number
          $('#confirm-name').fadeIn()
          $('.warn-message').html "Se o nome acima não for o seu <a id='confirm-back' style='cursor: pointer;'>clique aqui</a> e preencha novamente conforme o nome escrito no convite."
          $('.warn-message').fadeIn()
        else if json.status and json.data.is_confirmed
          $('.success-message').html json.data.name + " sua presença já foi confirmada."
          $('.success-message').fadeIn()
        else
          hideAll()
          $('.error-message').html "Oops, algo não funcionou como esperado, entra em contato com o Diogo e passa esse erro pra ele: " + JSON.stringify(json.error)
          $('.error-message').fadeIn()
        return
  else
    $('.error-message').html "Insira um nome para fazer a busca."
    $('.error-message').fadeIn()
  return

$('.confirmation form#confirm-name').submit (e) ->
  e.preventDefault()
  postdata = $('.confirmation form#confirm-name').serialize()
  $.ajax
    type: 'POST'
    url: 'confirm_guest/'
    data: postdata
    dataType: 'json'
    success: (json) ->
      if json.status
        hideAll()
        $('.success-message').html json.data.confirmation_name.split(' ')[0] + " você e seus " + json.data.accompanying_number + " acompanhantes foram confirmados com sucesso, obrigado!"
        $('.success-message').fadeIn()
      else
        hideAll()
        $('.error-message').html "Oops, algo não funcionou como esperado, entra em contato com o Diogo e passa esse erro pra ele: " + JSON.stringify(json.error)
        $('.error-message').fadeIn()
      return
  return

hideAll = ->
  $('#check-name').hide()
  $('#confirm-name').hide()
  $('.warn-message').hide()
  $('.error-message').hide()
  $('.success-message').hide()
  return

$('.warn-message').on 'click', ->
  confirmInitialState()
  return

confirmInitialState = ->
  hideAll()
  $('#confirmation-name').val ''
  $('#check-name').fadeIn()
  return
