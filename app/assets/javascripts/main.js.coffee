$(document).ready ->
	console.log "ready."

	# Note: smelly
	$("#devices-block-view").click ->
		$.each $(".device-list-item"), (key, value) ->
			$(value).removeClass("list-view tiled-view").addClass("block-view")

	$("#devices-tiled-view").click ->
		$.each $(".device-list-item"), (key, value) ->
			$(value).removeClass("list-view block-view").addClass("tiled-view")

	$("#devices-list-view").click ->
		$.each $(".device-list-item"), (key, value) ->
			$(value).removeClass("tiled-view block-view").addClass("list-view")