$("a[href^='#']").on "click", (e)->
  e.preventDefault()
  $link = $(this)
  href = $link.attr("href")
  target_top = $(href).offset().top
  $("body").animate({scrollTop: target_top})

$("body").on "click", ".info-wrapper .navigation-container .block", ()->
  $button = $(this)
  $(this).parent().children().removeClass('active')
  $(this).addClass('active')

$("body").on "click", ".expand-it", ()->
  $('.expand-it span').toggleClass('rotate')
  $('.expand-field').toggleClass('expand')
  $('.expand-field .regular').toggleClass('show-it')

  
$document.on "click", "[open-popup]", ()->
  popup_key = $(this).attr("open-popup")
  $(".#{popup_key}-popup").addClass("visible")
  $("body").addClass("has-opened-popup")

$document.on "click", ".overlay", ()->
  $overlay = $(this)
  $popup = $overlay.next()
  $popup.removeClass("visible")
  $("body").removeClass("has-opened-popup")


$document.on "ready", ()->
  $('.input.select select').niceSelect()
