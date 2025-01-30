extends RigidBody2D

@warning_ignore("unused_signal")
signal dead
@warning_ignore("unused_signal")
signal enterR

@export var heath = 10

var moveX : int
var moveY : int

func _ready() -> void:
	$Move.start(0.01)
	$HeathBar.position = (position + Vector2(-24, -48))
	$HeathBar.max_value = heath
	$HeathBar.visible = true


func _on_move_timeout() -> void:
	var time : float
	moveX = randi_range(-200, 200)
	moveY = randi_range(-200, 200)
	time = randf_range(1, 2)
	$Move.start(time)


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Plasma"):
		heath -= Globalvars.PlasmaDmg
	elif area.is_in_group("Rocket"):
		heath -= Globalvars.RocketDmg
	elif area.is_in_group("Explode"):
		heath -= Globalvars.ExploadeDmg

func _process(delta: float) -> void:
	$HeathBar.value = heath
	$HeathBar.position = (position + Vector2(-24, -48))


	move_and_collide(Vector2(moveX * delta, moveY * delta))


	if heath <= 0:
		die()

func die():
	emit_signal("dead")
	queue_free()
