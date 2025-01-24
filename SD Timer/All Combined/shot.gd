extends Marker2D


func _process(_delta: float) -> void:
	if $"..".inRobot == true:
		look_at(get_global_mouse_position())
