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

	# Open settings menu when the button if it is not open,
	# close it if it is
	$settingsButton = $("#settings-button")
	$settingsButton.click (event) ->
		$settingsDropdown = $("#settings-dropdown")
		if $settingsDropdown.length == 0
			$.get '/settings', (data) ->
				$("body").append data
				$("#settings-dropdown").offset
					top: $("#top-nav").height()
					left: $(window).width() - $("#settings-dropdown").width() - 20
					
				$("#settings-close i").click (event) ->
					$("#settings-dropdown").remove()
		else
			$settingsDropdown.remove()
		return false

	# Remove dropdown menu if the user clicks anywhere on the document
	$(window).click (event) ->
		# Prevent dropdown from closing if the user clicks on something
		# within the dropdown itself
		return if $(event.target).closest("#settings-dropdown").length > 0
		$("#settings-dropdown").remove()
