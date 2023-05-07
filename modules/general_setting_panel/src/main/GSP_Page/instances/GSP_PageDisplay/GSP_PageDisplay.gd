extends GSP_Page

@onready var _GSP_PageElementOptionsSwitchScreen : GSP_PageElementOptions = %GSP_PageElementOptionsSwitchScreen

func update_ui():
	super.update_ui()
	_GSP_PageElementOptionsSwitchScreen.options.clear()
	for i in DisplayServer.get_screen_count():
		_GSP_PageElementOptionsSwitchScreen.options.append(str(i))
	_GSP_PageElementOptionsSwitchScreen.update_ui()
	pass

func _on_page_element_updated(page_element : GSP_PageElement, new_value : Variant):
	if page_element.id == "full_screen":
		if new_value[1] == "@s_Windowed":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		if new_value[1] == "@s_FullScreen":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	if page_element.id == "resolution":
		var temp : Array = new_value[1].split("x")
		if temp.size() == 2:
			var resolution := Vector2i(
				int(temp[0]), int(temp[1])
			)
			DisplayServer.window_set_size(resolution)
	if page_element.id == "switch_screen":
		DisplayServer.window_set_current_screen(new_value[0])
	if page_element.id == "ui_scale":
		if new_value != ProjectSettings.get_setting("display/window/stretch/scale"):
			ProjectSettings.set_setting("display/window/stretch/scale", new_value)
			ProjectSettings.save()
