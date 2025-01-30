extends Node2D

var nextWave = 100

#Virus, VirusLeft, RobotsLeft

#100, 2, 3
#95, 3, 4
#90, 4, 5
#85, 6, 7
#80, 8, 9
#70, 10, 10
#60, 12, 11
#50, 14, 12
#40, 16, 13
#30, 18, 14
#20, 20, 15
#15, 15, 17
#10, 10, 12

func _process(_float):
	if Globalvars.virusleft <= 15:
		Globalvars.enemycap = (Globalvars.virusleft + 2)
	
	if Globalvars.virusleft == nextWave and nextWave >= 90:
		Globalvars.viruscap += 1
		Globalvars.enemycap += 1
		nextWave -= 5
	elif Globalvars.virusleft == nextWave and nextWave > 80:
		Globalvars.viruscap += 2
		Globalvars.enemycap += 2
		nextWave -= 5
	elif Globalvars.virusleft == nextWave and nextWave >= 20:
		Globalvars.viruscap += 2
		Globalvars.enemycap += 1
		nextWave -= 10
	elif nextWave <= 20:
		Globalvars.viruscap = Globalvars.virusleft
		#Globalvars.enemycap = (Globalvars.virusleft + 1)


#func _on_wave_timeout() -> void:
#	if Globalvars.enemycap < 15:
#		Globalvars.enemycap += 1

#	if Globalvars.viruscap < 20:
#		Globalvars.viruscap += 2

func _ready():
	if Globalvars.virusesAtStart > 80:
		nextWave = (Globalvars.virusesAtStart - 5)
	elif Globalvars.virusesAtStart <= 80:
		nextWave = (Globalvars.virusesAtStart - 10)
	
	Globalvars.virusleft = Globalvars.virusesAtStart
