var row = "<%= j render partial: 'line_item_row', formats: :html, locals: { line_item: @line_item } %>"
$("#line-items-table tbody").append(row);
$("#packaging_component_order_component_requirement_id").prop("disabled", "true");
$("#add-line-item").prop("disabled", "true");
$("#new_packaging_component_order")[0].reset();