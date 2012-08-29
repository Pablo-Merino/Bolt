
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

function countChar(val){
	var maxLen = 256;
    var len = val.value.length;
    var goodLen = maxLen - len;
    $('.actions div.counter').text(goodLen)
    if(len > maxLen) {
  		$('.actions input').attr('disabled', '');  	
    } else {
    	$('.actions input').removeAttr('disabled');
    }

    if(goodLen < 0) {
    	$('.actions div.counter').css('color','red');
    } else if(goodLen < 50) {
  		$('.actions div.counter').css('color','orange');  	
    } else {
    	$('.actions div.counter').css('color','black');  	
    }
}

$(document).ready(function() {
	countChar(document.getElementById('status_text'));



	$('.follower_button').on('click', function() {
		$('.followers_tab_menu').addClass('active');
		$('.nav_link').removeClass('active');
	});
	$('.following_button').on('click', function() {
		$('.following_tab_menu').addClass('active');
		$('.nav_link').removeClass('active');
	});
});