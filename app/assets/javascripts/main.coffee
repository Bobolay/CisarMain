$document.on "click", "a[href^='#']", (e)->
  e.preventDefault()
  $link = $(this)
  href = $link.attr("href")
  target_top = $(href).offset().top
  $("body").animate({scrollTop: target_top})

$document.on "click", ".info-wrapper .navigation-container .block", (e)->
  $button = $(this)
  $(this).parent().children().removeClass('active')
  $(this).addClass('active')

$document.on "click", ".expand-it", ()->
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


$document.on "ready page:load", ()->
  $('.input.select select').niceSelect()



submit_form = (e)->
  e.preventDefault()
  $form = $(this)
  data = $form.serializeArray()
  url = $form.attr("action")
  method = $form.attr("method")
  $.ajax(
    type: method
    url: url
    data: data
    dataType: "json"
  )

  $form.addClass("sending")



$document.on "submit", "form.request-form", submit_form

window.WEATHER_INITIALIZED = false

$document.on "ready page:load", ()->
  if !WEATHER_INITIALIZED
    $.ajax(
      url: "/weather_and_exchange_rates"
      success: (res)->
        window.WEATHER_INITIALIZED = true
        $(".header-container .right-part").prepend(res)
    )