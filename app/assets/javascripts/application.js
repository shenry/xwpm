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
//= require bootstrap-editable.min
//= require bootstrap-editable-rails
	
//= require jquery.ui.widget
//= require jquery.iframe-transport
//= require jquery.fileupload
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
