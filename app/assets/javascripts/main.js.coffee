$(document).ready ->
	console.log "ready."

	# Note: smelly
	$("#devices-tiled-view").click ->
		$.each $(".device-list-item"), (key, value) ->
			$(value).removeClass("list-view").addClass("tiled")

	$("#devices-list-view").click ->
		$.each $(".device-list-item"), (key, value) ->
			$(value).removeClass("tiled").addClass("list-view")