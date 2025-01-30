extends Control



func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://All Combined/All_Combined.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
