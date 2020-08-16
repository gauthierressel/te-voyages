var $win = $(window),
    $doc = $(document),
    $html = $('html'),
    $body = $('body');

// svg4everybody();

$doc.ready(function() {
  $body.addClass('is-ready');
});

$win.on('load', function() {
  $body.addClass('is-loaded');

  // AOS.init({
  //   duration: 800,
  //   offset: 200
  // });
});

$win.on('scroll', function(event) {
  
  if($win.scrollTop() > 0) {
    $body.addClass('is-scrolled');
  }
  else {
    $body.removeClass('is-scrolled');
  }
});


// $('.js-slider').slick({
//   infinite: true,
//   slidesToShow: 3,
//   slidesToScroll: 1,
//   prevArrow: $('.js-slider-prev'),
//   nextArrow: $('.js-slider-next')
// });
