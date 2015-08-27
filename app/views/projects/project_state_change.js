var badge = $("#project-state-badge");
var old_state = badge.attr("data-state");
var new_state = "<%= @project.aasm_state %>"
badge.switchClass(old_state, new_state);
badge.attr("data-state", new_state);
badge.prop("data-state", new_state);
var state_options = "<%= j states_for_select(@project) %>"
$("#project-state-control").empty().append(state_options);
// $("#project-state-select").html("<%= j render partial: 'projects/state_select', formats: :html, locals: { project: @project } %>");