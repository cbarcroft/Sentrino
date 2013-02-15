$(document).ready ->
	console.log "ready."

	getViewFromId = (id) ->
		id = id.split("-").slice(1).join("-")

	$.each $('.device-list-options a'), (key, value) ->
		$(value).click (event) ->
			$.session.set "device-layout", getViewFromId($(value).attr("id"))
			$.each $(".device-list-item"), (key2, value2) ->
				$(value2).removeClass "list-view tiled-view block-view"
				$(value2).addClass $.session.get "device-layout"

	# Default view = block view
	$.each $(".device-list-item"), (key, value) ->
		if $.session.get("device-layout") != undefined
			$(value).addClass $.session.get("device-layout")
		else
			$(value).addClass("block-view")

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
