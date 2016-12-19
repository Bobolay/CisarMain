change_slide = (index)->
  $(".info-container").children().removeClass("visible")
  setTimeout(
    ()->
      $(".info-container .text#{index + 1}").addClass("visible")
    300
  )

$document.on "click", ".info-on-banner ul li", ()->
    $button = $(this)
    $(this).parent().children().removeClass('active')
    $(this).addClass('active')
    index = $button.index()
    change_slide(index)




init_bx_sliders = ()->
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
  $('.main-slider-prev').click ->
    current = slider1.getCurrentSlide()
    slider1.goToPrevSlide(current)
  $('.main-slider-next').click ->
    current = slider1.getCurrentSlide()
    slider1.goToNextSlide(current)


  slider2 = $('.bxslider-2').bxSlider
      pagerCustom: '#bx-pager-2'
      controls: false
      infiniteLoop: true
      hideControlOnEnd: true
      speed: 1000
      pause: 8000
      auto: true
      easing: 'swing'
  $('.slider-prev-2').click ->
    current = slider2.getCurrentSlide()
    slider2.goToPrevSlide(current) - 1
  $('.slider-next-2').click ->
    current = slider2.getCurrentSlide()
    slider2.goToNextSlide(current) + 1


  slider3 = $('.bxslider-3').bxSlider
      pagerCustom: '#bx-pager-3'
      controls: false
      infiniteLoop: true
      hideControlOnEnd: true
      speed: 1000
      pause: 9000
      auto: true
      easing: 'swing'
  $('.slider-prev-3').click ->
    current = slider3.getCurrentSlide()
    slider3.goToPrevSlide(current) - 1
  $('.slider-next-3').click ->
    current = slider3.getCurrentSlide()
    slider3.goToNextSlide(current) + 1


  slider4 = $('.bxslider-4').bxSlider
      pagerCustom: '#bx-pager-4'
      controls: false
      infiniteLoop: true
      hideControlOnEnd: true
      speed: 1000
      pause: 10000
      auto: true
      easing: 'swing'
  $('.slider-prev-4').click ->
    current = slider4.getCurrentSlide()
    slider4.goToPrevSlide(current) - 1
  $('.slider-next-4').click ->
    current = slider4.getCurrentSlide()
    slider4.goToNextSlide(current) + 1


  slider5 = $('.carousel').bxSlider
    pager: false
    controls: false
    minSlides: 2
    maxSlides: 6
    slideWidth: 200
    slideMargin: 2
  $('.carousel-slider-prev').click ->
    current = slider5.getCurrentSlide()
    slider5.goToPrevSlide(current) - 1
  $('.carousel-slider-next').click ->
    current = slider5.getCurrentSlide()
    slider5.goToNextSlide(current) + 1

init_bx_sliders()
$document.on("page:load", init_bx_sliders)