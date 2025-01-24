extends Marker2D


@export var robot : PackedScene

var link
var robotAlive = false


func _process(delta: float) -> void:
	if Globalvars.enemys <= Globalvars.maxEnemys:
		var r = robot.instantiate()
		owner.add_child(r)
		robotAlive = true
	elif robotAlive == true:
		pass



func _on_area_2d_area_entered(area: Area2D) -> void:
	link = area
