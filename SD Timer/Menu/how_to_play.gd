extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_next_pressed():
	$HowToPlay1.visible = false
	$HowToPlay2.visible = true


func _on_previous_pressed():
	$HowToPlay1.visible = true
	$HowToPlay2.visible = false
