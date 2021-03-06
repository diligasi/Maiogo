jQuery(document).ready ->
  # Caso não haja depoimento retorna uma mensagem humanizada.
  getFirstTestimonial = ->
    result = $('.testimonial-single:first p').html()
    if result == undefined
      result = 'Parece que ainda não temos nenhum depoimento, quer ser o primeiro?!'
    result

  $('.testimonial-active').html '<p>' + getFirstTestimonial() + '</p>'
  $('.testimonial-single:first .testimonial-single-image img').css 'opacity', '1'

  window.showSelectedTestimonial = (e, element) ->
    e.preventDefault()
    $('.testimonial-single-image img').css 'opacity', '0.5'
    $(element).css 'opacity', '1'
    new_testimonial_text = $(element).parent('.testimonial-single-image').siblings('p').html()

    $('.testimonial-active p').fadeOut 300, ->
      $(this).html new_testimonial_text
      $(this).fadeIn 400
      return

    like_href = $('#t-like').data('href')
    new_link = like_href.substring(0, like_href.length - 1) + $(element).data('id')
    like_element = $('#t-like')[0]
    like_element.innerHTML = ''
    like_element.innerHTML = '<div id="t-like" class="fb-like bottom20"><fb:like href="' + new_link + '" layout="button_count" show_faces="true" share="false"></fb:like></div>'
    FB.XFBML.parse like_element
    return
  return

######* Testimonnial actions, comandos e métodos para a adição, criação e etc. ######

# Instancia um novo depoimento, traz o formulário de criação de depoimento,
# alimenta o corpo da lightbox e a torna visível.
$('.testimonial_add_button').click (event) ->
  $.ajax
    url: 'new_testimonial'
    type: 'GET'
    dataType: 'HTML'
    success: (data) ->
      $('.lightbox_content').append data
      showLightbox event
    error: (erro) ->
      alert JSON.stringify(erro)
  return

#  Exibe a lightbox para o usuário
showLightbox = (e) ->
  e.preventDefault()
  $('#lightbox').css
    'opacity': 1
    'outine': 'none'
    'top': 0
  return

#  Fecha a lightbox e limpa o seu conteúdo.
$('#lightbox_link_close').on 'click', (e) ->
  e.preventDefault()
  $('#lightbox').removeAttr 'style'
  $('.lightbox_content').empty()
  return
