extends Control

func resume():
	get_tree().paused = false

func pause():
	get_tree().paused = true

func testEsc():
	if Input.is_action_just_pressed("Esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Esc") and !get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://main_menu_settings.tscn")

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _process(delta: float):
	testEsc()
