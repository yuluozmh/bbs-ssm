var swiper = new Swiper('.swiper-container', {
    zoom: true,
    width: window.innerWidth,
    on: {
        click: function () {
            $('#origin-img').fadeOut('fast');
            this.virtual.slides.length = 0;
            this.virtual.cache = [];
            swiperStatus = false;
        },
    },
});

//切换图状态禁止页面缩放
document.addEventListener('touchstart', function (event) {
    if (event.touches.length > 1 && swiperStatus) {
        event.preventDefault();
    }
});

var lastTouchEnd = 0;
document.addEventListener('touchend', function (event) {
    var now = (new Date()).getTime();
    if (now - lastTouchEnd <= 300) {
        event.preventDefault();
    }
    lastTouchEnd = now;
}, false);

document.addEventListener('touchmove', function (e) {
    if (swiperStatus) {
        e.preventDefault();
    }
});

function magnify(img) {
    clickIndex = $(this).index();
    swiper.virtual.appendSlide('<div class="swiper-zoom-container"><img src="' + img + '" /></div>');
    swiper.slideTo(clickIndex);
    $('#origin-img').fadeIn('fast');
    swiperStatus = true;

}