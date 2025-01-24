extends Control

func _on_vsync_toggled(toggled_on: bool):
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)

func _on_fullscreen_toggled(toggled_on: bool):
	DisplayServer.window_set_mode(3)
