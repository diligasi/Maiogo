// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/autocomplete
//= require turbolinks
//= require_tree .

(function($) {
    // Remove a tela de loadding após o carregamento da página.
    $(window).load(function(){
        $('#loader-wrapper').fadeOut('slow', function(){
            $(this).remove();
            $('body').css('overflow-y', 'auto');
        });
    });

    // Autocomplete da área de confirmação de presença.
    $("#confirmation-name").autocomplete({
        source: '/static_page/autocomplete.json',
    });

    // Assinatura com o Facebook, verifica se o formulário do depoimento esta preenchido, em caso posítivo inícia
    // os procedimentos de autenticação com o Facebook e a gravação do depoimento, quando o formulário não estiver
    // preenchido exibe uma mensagem alertando o usuário.
    window.signWithFacebook = function(e) {
        if (e.preventDefault) e.preventDefault();
        $('.error-message').hide();
        if ($('#contact-message').val().length > 0) {
            FB.login(function(response) {
                if (response.authResponse) {
                    //return window.location = '/auth/facebook/callback';
                    var postdata = $('.contact-form form').serialize();
                    $.ajax({
                        type: 'POST',
                        url: '/auth/facebook/callback',
                        data: postdata,
                        dataType: 'json',
                        success: function(json) {
                            addTestimonialToQueue(json.data);
                        }
                    });
                }
            });
        } else {
            $('.error-message').html("Para assinar é preciso que tenha um texto.");
            $('.error-message').fadeIn();
        }
    };

    window.goToSingAlone = function(e) {
        if (e) e.preventDefault();
        $('.error-message').hide();
        $('#add-testimonial-facebook').hide();
        $('.singAloneOption').hide();
        $('#author').fadeIn();
        $('#add-testimonial').fadeIn();
        $('.singFacebookOption').fadeIn();
    };


    window.goToSingFacebook = function(e) {
        if (e) e.preventDefault();
        $('#author').hide();
        $('.error-message').hide();
        $('#add-testimonial').hide();
        $('.singFacebookOption').hide();
        $('#add-testimonial-facebook').fadeIn();
        $('.singAloneOption').fadeIn();
    };

    // Assinatura SEM o Facebook, verifica se o formulário do depoimento esta preenchido, em caso posítivo habilita
    // o campo para inserir o nome que assinará o depoimento, quando o formulário não estiver preenchido exibe uma
    // mensagem alertando o usuário.
    window.signAlone = function(e) {
        if (e.preventDefault) e.preventDefault();
        $('.error-message').hide();
        if ($('#author').css('display') != 'none' && ($('#contact-message').val().length > 0 && $('#contact-name').val().length > 0)) {
            var postdata = $('.contact-form form').serialize();
            $.ajax({
                type: 'POST',
                url: 'create_testimonial/',
                data: postdata,
                dataType: 'json',
                success: function(json) {
                    addTestimonialToQueue(json.data);
                }
            });
        } else {
            $('.error-message').html("Verifique se todos os campos estão preenchidos.");
            $('.error-message').fadeIn();
        }
    };

    // Adiciona o recem criado depoimento aos já existentes na tela de exibição.
    window.addTestimonialToQueue = function(data) {
        $('.col-sm-12.testimonials').append('<div class="testimonial-single">' +
                                                '<p>' +
                                                    data.testimonial +
                                                    '<br />' +
                                                    '<a href="' + data.profile + '">' + data.name + '</a>' +
                                                '</p>' +
                                                '<div class="testimonial-single-image">' +
                                                    '<img id="testimonial' + data.id + '" src="' + data.picture + '" alt="" onclick="javascript:showSelectedTestimonial(event, this)">' +
                                                '</div>' +
                                            '</div>');
        $('#testimonial' + data.id).trigger('click');
        $('html, body').animate({ scrollTop: $(".testimonials").offset().top - $('nav').height() - 60 }, 1000);
        $('#lightbox_link_close').trigger('click');
    };
}(jQuery));

