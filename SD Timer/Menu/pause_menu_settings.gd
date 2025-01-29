extends Control

func _on_back_pressed():
	$"../../CanvasLayer".visible = true
	$"..".visible = false

func _ready():
	if DisplayServer.window_get_mode() == 3:
		$VBoxContainer/HSplitContainer/VBoxContainer/HBoxContainer/Fullscreen.button_pressed = true
	
	if DisplayServer.window_get_vsync_mode() == 1:
		$VBoxContainer/HSplitContainer/VBoxContainer/MarginContainer2/Vsync.button_pressed = true

func _on_vsync_toggled(toggled_on: bool):
	if toggled_on == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	elif toggled_on == false:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_fullscreen_toggled(toggled_on: bool):
	if toggled_on == true:
		@warning_ignore("int_as_enum_without_cast")
		DisplayServer.window_set_mode(3)
	elif toggled_on == false:
		@warning_ignore("int_as_enum_without_cast")
		DisplayServer.window_set_mode(0)
