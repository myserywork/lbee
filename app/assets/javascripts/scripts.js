// Twitch Plugin
$(function () {
    window.onPlayerEvent = function (data) {
        data.forEach(function(event) {
            if (event.event == "playerInit") {
                var player = $("#twitch_embed_player")[0];
                player.playVideo();
                player.mute();
            }
        });
    }

    swfobject.embedSWF("//www-cdn.jtvnw.net/swflibs/TwitchPlayer.swf", "twitch_embed_player", "450", "305", "11", null,
        { "eventsCallback":"onPlayerEvent",
            "embed":1,
            "channel":"LigaLBEE",
            "auto_play":"true"},
        { "allowScriptAccess":"always",
            "allowFullScreen":"true"});
});

// Modals
$(document).ready(function () {
    $("#closeNotify").click(function (){
        $(".notification-modal").fadeToggle(200);
    });
});

// Contato Modal
$(document).ready(function (){
    $("#openContatoModal").click(function (){
        $("#contatoModal, .overlay").css('display', 'block');
    });
    $("#closeContato").click(function () {
        $("#contatoModal, .overlay").hide();
    });
    $(".overlay").click(function () {
        $("#contatoModal, .overlay").hide();
    });
    $(document).keyup(function(ev){
        if(ev.keyCode == 27)
            $("#contatoModal, .overlay").hide();
    });
});


// Table popUps
$(document).ready(function(){
    $("#popUpBar").click(function () {
       $("#table").toggle();
    });
    $("#popUpBar2").click(function () {
        $("#table2").toggle(function(){
            $(".table-description").toggle();
            $(".liga-thead").toggle();
        });
    });
    $("#popUpCog").click(function () {
        $(".cogs-popup").toggle();
    });
});

// Carousel
$(document).ready(function ($) {

    var slideCount = $('#slider ul li').length;
    var slideWidth = $('#slider ul li').width();
    var slideHeight = $('#slider ul li').height();
    var sliderUlWidth = slideCount * slideWidth;

    $('#slider').css({ width: slideWidth, height: slideHeight });

    $('#slider ul').css({ width: sliderUlWidth, marginLeft: - slideWidth });

    $('#slider ul li:last-child').prependTo('#slider ul');

    function moveLeft() {
        $('#slider ul').animate({
            left: + slideWidth
        }, 200, function () {
            $('#slider ul li:last-child').prependTo('#slider ul');
            $('#slider ul').css('left', '');
        });
    };

    function moveRight() {
        $('#slider ul').animate({
            left: - slideWidth
        }, 200, function () {
            $('#slider ul li:first-child').appendTo('#slider ul');
            $('#slider ul').css('left', '');
        });
    };

    $('i.control_prev').click(function () {
        moveLeft();
    });

    $('i.control_next').click(function () {
        moveRight();
    });
});

$(document).ready(function ($) {

    var slideCount = $('#slider2 ul li').length;
    var slideWidth = $('#slider2 ul li').width();
    var slideHeight = $('#slider2 ul li').height();
    var sliderUlWidth = slideCount * slideWidth;

    $('#slider').css({ width: slideWidth, height: slideHeight });

    $('#slider2 ul').css({ width: sliderUlWidth, marginLeft: - slideWidth });

    $('#slider2 ul li:last-child').prependTo('#slider2 ul');

    function moveLeft() {
        $('#slider2 ul').animate({
            left: + slideWidth
        }, 200, function () {
            $('#slider2 ul li:last-child').prependTo('#slider2 ul');
            $('#slider2 ul').css('left', '');
        });
    };

    function moveRight() {
        $('#slider2 ul').animate({
            left: - slideWidth
        }, 200, function () {
            $('#slider2 ul li:first-child').appendTo('#slider2 ul');
            $('#slider2 ul').css('left', '');
        });
    };

    $('i.control_prev').click(function () {
        moveLeft();
    });

    $('i.control_next').click(function () {
        moveRight();
    });
});

// Page Expander
function toggleFullScreen() {
    if ((document.fullScreenElement && document.fullScreenElement !== null) ||
        (!document.mozFullScreen && !document.webkitIsFullScreen)) {
        if (document.documentElement.requestFullScreen) {
            document.documentElement.requestFullScreen();
        } else if (document.documentElement.mozRequestFullScreen) {
            document.documentElement.mozRequestFullScreen();
        } else if (document.documentElement.webkitRequestFullScreen) {
            document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
        };
    } else {
        if (document.cancelFullScreen) {
            document.cancelFullScreen();
        } else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
        } else if (document.webkitCancelFullScreen) {
            document.webkitCancelFullScreen();
        };
    };
};