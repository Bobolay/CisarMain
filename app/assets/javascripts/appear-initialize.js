is_touch_screen = 'ontouchstart' in document.documentElement;
$document.on("page:load", function () {
    var width = window.innerWidth
    if(is_touch_screen && width < 640) {
        console.log("it works")
    } else {
        $(function() {
            var $appeared = $('');
            $appeared.appear();
            $(document.body).on('appear', function(e, $affected) {
                $affected.addClass('appeared')
            });
        });
    }
})
