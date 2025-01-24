extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://All Combined/All_Combined.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://main_menu_settings.tscn")

func _on_quit_pressed():
		get_tree().quit()
