// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require bootstrap 
//= require common

$(function() {
	if($("#has_artwork_false").attr("checked", "checked")) {
		$("#has-artwork-upload").hide();	
	}
})

$(function() {
	$("#has_artwork_true").click(function() {
		$("#has-artwork-upload").toggle();
	});
})

$(function() {
	$("#specs-form-control").change(function(){
		var text = $("#specs-form-control option:selected").text();
		$("#label-position-units").html(text);
	});
})

