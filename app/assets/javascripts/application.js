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
//= require jquery.turbolinks
//= require twitter/bootstrap
//= require turbolinks
//= require bootstrap 
//= require jquery.autocomplete.min
//= require autocomplete.js
//= require best_in_place
//= require jquery.animate-shadow-min

//= require cloudinary
//= require cloudinary/jquery.cloudinary
//= require cloudinary_upload
	
//= require moment
//= require bootstrap-datetimepicker



// $(document).on('change', '.btn-file :file', function() {
//   var input = $(this),
//       numFiles = input.get(0).files ? input.get(0).files.length : 1,
//       label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
//   input.trigger('fileselect', [numFiles, label]);
// });

$(document).ready( function() {
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
	});
$(function() {
	$("#specs-form-control").change(function(){
		var text = $("#specs-form-control option:selected").text();
		$("#mirror-units").val(text);
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
	$(".receive_line_item").change(function(){
		var line_item_id = $(this).attr("data-line-item");
		$("#receive-" + line_item_id).submit();
	});
	$("a[data-component]").click(function(e){
		e.preventDefault();
		var model = $(this).data("component");
		var target= $(this).data("target");
		$(this).parent().hide();
		$("#" + target + "-" + model + "-select-wrapper").removeClass('hidden');
	});
});
	
$.fn.capitalize = function () {
    $.each(this, function () {
        var caps = this.value;
        caps = caps.charAt(0).toUpperCase() + caps.slice(1);
        this.value = caps;
    });
    return this;
};

$.fn.digits = function(){ 
    return this.each(function(){ 
        $(this).text( $(this).text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") ); 
    })
}

function updateAttributeTotalFor(key, candy, decimals) {
	var selected_cells	= $("." + key + "-update");
	var volume_cells		= $(".volume-update");
	var volumes_hash		= createVolumeCollection(volume_cells);
	var total						= volumes_hash[volumes_hash.length - 1]['total'];
	var sum_product			= sumProduct(selected_cells, volumes_hash, candy);
	return (sum_product / total).toFixed(decimals)
}

function updatePercentageTotalFor(key) {
	var new_value = updateAttributeTotalFor(key, "%", 1);
	var new_html	= new_value + "%";
	$("#" + key + "-total").html(new_html);
}

function updateDollarTotalFor(key) {
	var new_value = updateAttributeTotalFor(key, "$", 2)
	$("#" + key + "-total").html("$" + new_value)
}

// used to update weighted avg values for table of wine components on wines#show
function sumProduct(attributes, volumes, remove_str) {
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

function createVolumeCollection(volumes) {
	output 	= [];
	total		= 0;
	$.each(volumes, function(index){
		var gals 	= parseInt($(this).html().replace(",", ""), 10)
		total 		+= gals
		var id 		= $(this).parent().attr("data-id");
		output.push({ 'volume': gals, 'id': id });
	});
	output.push({'total': total})
	return output
}

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
});
