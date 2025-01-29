extends Node2D



func _on_wave_timeout() -> void:
	if Globalvars.enemycap < 15:
		Globalvars.enemycap += 1

	if Globalvars.viruscap < 20:
		Globalvars.viruscap += 2
