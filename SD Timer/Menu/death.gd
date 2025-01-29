extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer2/VBoxContainer/Left.text = "Viruses Left: %d" % Globalvars.virusleft
	Globalvars.enemys = 0
	Globalvars.virus = 0
	Globalvars.enemycap = 1
	Globalvars.viruscap = 2
	Globalvars.virusleft = 100


func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://All Combined/All_Combined.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
