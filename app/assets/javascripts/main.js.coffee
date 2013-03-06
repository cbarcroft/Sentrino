$(document).ready ->
	console.log "ready."

	# Initialize bootstrap tooltips
	initTooltips()

	##
	# E.g device-list-view -> list-view
	##
	getViewFromId = (id) ->
		id = id.split("-").slice(1).join("-")

	##
	# Switch the device list view when list style button is clicked on
	##
	$.each $('.device-list-options a'), (key, value) ->
		$(value).click (event) ->
			$.session.set "device-layout", getViewFromId($(value).attr("id"))
			$.each $(".device-list-item"), (key2, value2) ->
				$(value2).removeClass "list-view tiled-view block-view"
				$(value2).addClass $.session.get "device-layout"
			initTooltips()

	# Default view = block view
	$.each $(".device-list-item"), (key, value) ->
		if $.session.get("device-layout") != undefined
			$(value).addClass $.session.get("device-layout")
		else
			$(value).addClass("block-view")

	##
	# Open settings menu when the button if it is not open,
	# close it if it is
	##
	$settingsButton = $("#settings-button")
	$settingsButton.click (event) ->
		$settingsDropdown = $("#settings-dropdown")
		if $settingsDropdown.length == 0
			$.get '/settings', (settingsMenu) ->
				$("body").append settingsMenu
				$("#settings-dropdown").offset
					top: $("#top-nav").height()
					left: $(window).width() - $("#settings-dropdown").width() - 20

				$("#settings-close i").click (event) ->
					$("#settings-dropdown").remove()
		else
			$settingsDropdown.remove()
		return false

	##
	# Remove dropdown menu if the user clicks anywhere on the document
	##
	$(window).click (event) ->
		# Prevent dropdown from closing if the user clicks on something
		# within the dropdown itself
		return if $(event.target).closest("#settings-dropdown").length > 0
		$("#settings-dropdown").remove()

initTooltips = ($element) ->
	if $.session.get("device-layout") == "list-view"
		$.each $('.device-buttons a'), (key, value) ->
			$(value).tooltip('destroy')
	else
		$element = $("[rel='tooltip']") if $element is undefined
		$element.tooltip
			placement: "bottom",
			trigger: "hover",
			delay: { show: 350, hide: 100 }



