extends Control

func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_vsync_toggled(toggled_on: bool):
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)

func _on_fullscreen_toggled(toggled_on: bool):
	DisplayServer.window_set_mode(3)
