$(function() {
	
		var progress = $('#status span').html();
		var progress = progress+"%";
		$('#status .arrow').animate({"left":progress}, 1000);
		$('#status p').animate({"left":progress}, 1000);
		
		
		$('ul.social li').css({"opacity":"0.4"});
		$('ul.social li').hover(function() {
			$(this).animate({"opacity":"1"});
		}, function() {
			$(this).animate({"opacity":"0.4"});
		});
		
		$('#emailform input:last').addClass('submit');
		
		var emailformtext = $('#emailform input:first').val();
		$('#emailform input:first').focus(function() {
			if($(this).attr("value") == emailformtext) { $(this).attr("value",""); }
		});
		$('#emailform input:first').blur(function() {
			if($(this).attr("value") == "") { $(this).attr("value",emailformtext); }
		});
		
		
		$('.scroller').jScrollPane({reinitialiseOnImageLoad:true});
		
		
		
		$('.jScrollPaneTrack').css({"display":"none"});
		$('#page').hover(function() {
			$('.jScrollPaneTrack').fadeIn();
		}, function() {
			$('.jScrollPaneTrack').fadeOut();		
		});




});

$(window).load(function(){

		$('.twitter img').fadeOut();
		
});