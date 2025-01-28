extends Control

@export var Game : PackedScene


func _on_play_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(Game)

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Menu/main_menu_settings.tscn")

func _on_quit_pressed():
		get_tree().quit()
