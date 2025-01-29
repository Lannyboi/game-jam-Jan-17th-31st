extends Control




func _ready() -> void:
	GlobalSign.MainMenu.connect(Callable(self, "_on_MainMenu"))
	

func resume():
	visible = false
	$CanvasLayer.visible = false
	get_tree().paused = false

func pause():
	visible = true
	$CanvasLayer.visible = true
	get_tree().paused = true

func testEsc():
	if Input.is_action_just_pressed("Esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Esc") and !get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	GlobalSign.MainMenu.emit()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_settings_pressed():
	GlobalSign.MainMenu.emit()
	get_tree().change_scene_to_file("res://Menu/main_menu_settings.tscn")

func _on_main_menu_pressed():
	GlobalSign.MainMenu.emit()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _process(delta: float):
	testEsc()


func _on_MainMenu():
	Globalvars.enemys = 0
	Globalvars.virus = 0
	Globalvars.enemycap = 1
	Globalvars.viruscap = 2
	Globalvars.virusleft = 100
