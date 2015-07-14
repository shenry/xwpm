var options = "<%= escape_javascript options_for_select(@components[:options], disabled: @components[:disabled]) %>";
options			= "<option value=''>Select Component</option>" + options;
var select	= $("#packaging_component_order_component_requirement_id");
select.prop("disabled", "");
select.empty().append(options);