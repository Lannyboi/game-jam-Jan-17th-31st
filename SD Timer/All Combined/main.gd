extends Node2D


func _process(_float):
	if Globalvars.virusleft <= 15:
		Globalvars.enemycap = Globalvars.virusleft


func _on_wave_timeout() -> void:
	if Globalvars.enemycap < 15:
		Globalvars.enemycap += 1

	if Globalvars.viruscap < 20:
		Globalvars.viruscap += 2

func _ready():
	Globalvars.virusleft = Globalvars.virusesAtStart
