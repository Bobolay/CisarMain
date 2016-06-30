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