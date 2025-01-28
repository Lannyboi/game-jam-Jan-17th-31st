extends Control

func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")

func _ready():
	if DisplayServer.window_get_mode() == 3:
		$MarginContainer3/Fullscreen.button_pressed = true
	
	if DisplayServer.window_get_vsync_mode() == 1:
		$MarginContainer2/Vsync.button_pressed = true

func _on_vsync_toggled(toggled_on: bool):
	if toggled_on == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	elif toggled_on == false:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_fullscreen_toggled(toggled_on: bool):
	if toggled_on == true:
		DisplayServer.window_set_mode(3)
	elif toggled_on == false:
		DisplayServer.window_set_mode(0)
