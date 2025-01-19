extends ProgressBar



func _process(_float) -> void:
	var time = $"../Timer".time_left + 0.0
	value = time
