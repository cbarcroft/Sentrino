$(document).ready ->

	# Initialize bootstrap tooltips
	initTooltips()

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

##
# Initialize bootstrap tooltips
##
initTooltips = ->
	$element = $("[rel='tooltip']")
	$element.tooltip
		placement: "bottom",
		trigger: "hover",
		delay: { show: 350, hide: 100 }



