/* UItoTop jQuery Plugin 1.2 | Matt Varone | http://www.mattvarone.com/web-design/uitotop-jquery-plugin */
$(document).on("page:change", function(){
    $('#etalage').etalage({
      thumb_image_width: 300,
      thumb_image_height: 400,
      source_image_width: 900,
      source_image_height: 1200,
      show_hint: true,
      click_callback: function(image_anchor, instance_id){
        alert('Callback example:\nYou clicked on an image with the anchor: "'+image_anchor+'"\n(in Etalage instance: "'+instance_id+'")');
      }
    });
    $('.scroll-pane').jScrollPane();
    $.fn.UItoTop = function(options) {
        var defaults = {
                text: 'To Top',
                min: 200,
                inDelay: 600,
                outDelay: 400,
                containerID: 'toTop',
                containerHoverID: 'toTopHover',
                scrollSpeed: 1200,
                easingType: 'linear'
            },
            settings = $.extend(defaults, options),
            containerIDhash = '#' + settings.containerID,
            containerHoverIDHash = '#' + settings.containerHoverID;
        $('body').append('<a href="#" id="' + settings.containerID + '">' + settings.text + '</a>');
        $(containerIDhash).hide().on('click.UItoTop', function() {
            $('html, body').animate({
                scrollTop: 0
            }, settings.scrollSpeed, settings.easingType);
            $('#' + settings.containerHoverID, this).stop().animate({
                'opacity': 0
            }, settings.inDelay, settings.easingType);
            return false;
        }).prepend('<span id="' + settings.containerHoverID + '"></span>').hover(function() {
            $(containerHoverIDHash, this).stop().animate({
                'opacity': 1
            }, 600, 'linear');
        }, function() {
            $(containerHoverIDHash, this).stop().animate({
                'opacity': 0
            }, 700, 'linear');
        });
        $(window).scroll(function() {
            var sd = $(window).scrollTop();
            if (typeof document.body.style.maxHeight === "undefined") {
                $(containerIDhash).css({
                    'position': 'absolute',
                    'top': sd + $(window).height() - 50
                });
            }
            if (sd > settings.min)
                $(containerIDhash).fadeIn(settings.inDelay);
            else
                $(containerIDhash).fadeOut(settings.Outdelay);
        });
    };

  $(".scroll").click(function(event){
    event.preventDefault();
    $('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
  });
  $('.alert-close').on('click', function(c){
		$('.message').fadeOut('slow', function(c){
	  		$('.message').remove();
		});
	});
  $('.alert-close1').on('click', function(c){
		$('.message1').fadeOut('slow', function(c){
	  		$('.message1').remove();
		});
	});
  $().UItoTop({ easingType: 'easeOutQuart' });
  $("span.menu").click(function(){
    $(".top-nav ul").slideToggle(500, function(){
    });
  });
  $("#flexiselDemo1").flexisel({
    visibleItems: 3,
    animationSpeed: 1000,
    autoPlay: true,
    autoPlaySpeed: 3000,
    pauseOnHover: true,
    enableResponsiveBreakpoints: true,
      responsiveBreakpoints: {
        portrait: {
          changePoint:480,
          visibleItems: 1
        },
        landscape: {
          changePoint:640,
          visibleItems: 2
        },
        tablet: {
          changePoint:768,
          visibleItems: 2
        }
      }
    });
    $("#flexiselDemo2").flexisel({
        visibleItems: 3,
        animationSpeed: 1000,
        autoPlay: true,
        autoPlaySpeed: 3000,
        pauseOnHover: true,
        enableResponsiveBreakpoints: true,
        responsiveBreakpoints: {
            portrait: {
                changePoint: 480,
                visibleItems: 1
            },
            landscape: {
                changePoint: 640,
                visibleItems: 2
            },
            tablet: {
                changePoint: 768,
                visibleItems: 2
            }
        }
    });


});
