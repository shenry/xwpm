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
//= require jquery.autocomplete.min
//= require autocomplete.js
//= require best_in_place
	

//= require cloudinary
//= require cloudinary/jquery.cloudinary
	
//= require moment
//= require bootstrap-datetimepicker



$(document).on('change', '.btn-file :file', function() {
  var input = $(this),
      numFiles = input.get(0).files ? input.get(0).files.length : 1,
      label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
  input.trigger('fileselect', [numFiles, label]);
});

$(document).ready( function() {
    $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
        
        var input = $(this).parents('.input-group').find(':text'),
            log = numFiles > 1 ? numFiles + ' files selected' : label;
        
        if( input.length ) {
            input.val(log);
        } else {
            if( log ) alert(log);
        }
        
    });
		$("#create-wine-link").click(function(){
			$("#create-wine-form").show();
			$("#wine-select")[0].selectedIndex = 0
		});
		$("#wine-select").change(function(){
			if ($(this).val() == null) {
				
			} else {
				$("#create-wine-form").hide();
			}
		});
		$("#project_no_capsule").change(function(){
			$("#project_capsule_id").prop("disabled", function(i, v) { return !v });
		});
		// $("input#comment_actionable").change(function(){
		// 	$("span#new-comment-actionable").toggleClass("hidden");
		// });
	});
$(function() {
	$("#specs-form-control").change(function(){
		var text = $("#specs-form-control option:selected").text();
		$("#mirror-units").val(text);
	});
});

$(function() {
	$(".thumb-delete").change(function(){
		var id 		= $(this).attr('id');
		var span	= $("span#" + id)
		span.toggleClass("thumb-delete-warning");
		if (span.text() == "Delete?") {
			span.text("Delete!")
		} else {
			span.text("Delete?")
		}
	});
});

$(document).ready(function(){
	$("#create-form input").blur(function(){
		if ( $(this).val() == '') {
			$(this).removeClass("has-value");
		} else {
			$(this).addClass("has-value");
		}
	});
});

$(document).ready(function(){
	$('.progress_bar').hide();
	$("#replace-image-link").click(function(){
		$("#image-replace").prepend($.cloudinary.unsigned_upload_tag("frzj7e4j", {cloud_name: "hcq3xdudm"}));
	});
	// $('#upload-cell').prepend($.cloudinary.unsigned_upload_tag("frzj7e4j", {cloud_name: "hcq3xdudm"}));
	$('.cloudinary-fileupload').unsigned_cloudinary_upload("frzj7e4j", 
		{ cloud_name: 'hcq3xdudm'}, 
	  { multiple: true }
	).bind('fileuploadsend', function(e, data) {
		var id = $(this).attr('id');
		$("#submit-button").prop("disabled", true);
		$('#' + id + "-progress").show();
	}).bind('cloudinarydone', function(e, data) {
		var id = $(this).attr('id');
		$("#submit-button").prop("disabled", "");
		$('#' + id + "-progress").hide();
	  $('#' + id + "-thumbnail").html($.cloudinary.image(data.result.public_id, 
	    { format: 'png', width: 350, height: 350, 
	      crop: 'fit', gravity: 'face'} ))}

	).bind('cloudinaryprogress', function(e, data) { 
	  $('.progress_bar').css('width', 
	    Math.round((data.loaded * 100.0) / data.total) - 1 + '%'); 		
	});
	$(".receive_line_item").change(function(){
		var line_item_id = $(this).attr("data-line-item");
		$("#receive-" + line_item_id).submit();
	});
	$("a[data-replace-component]").click(function(e){
		e.preventDefault();
		var model = $(this).data("replace-component");
		$(this).hide();
		$("#" + model + "-select-wrapper").removeClass('hidden');
	});
});

$.fn.digits = function(){ 
    return this.each(function(){ 
        $(this).text( $(this).text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") ); 
    })
}

function weightedAvg(attributes, volumes, remove_str) {
	var accumulator = 0;
	$.each(attributes, function(index){
		var percent = parseFloat($(this).html().replace(remove_str, ""));
		var vint_id	= $(this).parent().attr("data-id");
		$.each(volumes, function(index, value){
			if (value["id"] == vint_id) {
				accumulator += percent * value["volume"];
				return false
			}
		});
	});
	return accumulator
}


$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
});
