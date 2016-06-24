$("body").on "click", ".info-on-banner ul li", ()->
    $button = $(this)
    $(this).parent().children().removeClass('active')
    $(this).addClass('active')
    index = $button.index()
    change_slide(index)

change_slide = (index)->
    $(".info-container").children().removeClass("visible")
    setTimeout(
        ()->
            $(".info-container .text#{index + 1}").addClass("visible")
        300
    )

$(document).ready ->
  slider1 = $('.bxslider-main-banner').bxSlider
    pagerCustom: '#bx-pager'
    controls: false
    hideControlOnEnd: true
    speed: 1000
    pause: 90000
    auto: true
    easing: 'swing'
    infiniteLoop: true
    onSlideBefore: (element, oldIndex, newIndex)->
      change_slide(newIndex)
  $('.slider-prev').click ->
    current = slider1.getCurrentSlide()
    slider1.goToPrevSlide(current)
  $('.slider-next').click ->
    current = slider1.getCurrentSlide()
    slider1.goToNextSlide(current)

$(document).ready ->
  slider2 = $('.bxslider-2').bxSlider
      pagerCustom: '#bx-pager-2'
      controls: false
      infiniteLoop: true
      hideControlOnEnd: true
      speed: 1000
      pause: 8000
      auto: true
      easing: 'swing'
  $('.slider-prev').click ->
    current = slider2.getCurrentSlide()
    slider2.goToPrevSlide(current) - 1
  $('.slider-next').click ->
    current = slider2.getCurrentSlide()
    slider2.goToNextSlide(current) + 1

$(document).ready ->
  slider3 = $('.bxslider-3').bxSlider
      pagerCustom: '#bx-pager-3'
      controls: false
      infiniteLoop: true
      hideControlOnEnd: true
      speed: 1000
      pause: 9000
      auto: true
      easing: 'swing'
  $('.slider-prev').click ->
    current = slider3.getCurrentSlide()
    slider3.goToPrevSlide(current) - 1
  $('.slider-next').click ->
    current = slider3.getCurrentSlide()
    slider3.goToNextSlide(current) + 1

$(document).ready ->
  slider4 = $('.bxslider-4').bxSlider
      pagerCustom: '#bx-pager-4'
      controls: false
      infiniteLoop: true
      hideControlOnEnd: true
      speed: 1000
      pause: 10000
      auto: true
      easing: 'swing'
  $('.slider-prev').click ->
    current = slider4.getCurrentSlide()
    slider4.goToPrevSlide(current) - 1
  $('.slider-next').click ->
    current = slider4.getCurrentSlide()
    slider4.goToNextSlide(current) + 1

$(document).ready ->
  slider5 = $('.carousel').bxSlider
    pager: false
    controls: false
    minSlides: 2
    maxSlides: 6
    slideWidth: 200
    slideMargin: 2
  $('.slider-prev').click ->
    current = slider5.getCurrentSlide()
    slider5.goToPrevSlide(current) - 1
  $('.slider-next').click ->
    current = slider5.getCurrentSlide()
    slider5.goToNextSlide(current) + 1