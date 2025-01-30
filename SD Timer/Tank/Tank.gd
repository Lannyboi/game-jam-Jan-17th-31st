extends RigidBody2D

@warning_ignore("unused_signal")
signal dead

@export var rotateSpeed = 1.0
@export var heath = 20
@export var heathPer : float

@export var hackTime = 10
@export var isHackable = false
@export var inRobot = false
@export var isPicked = false



func _ready() -> void:
	$HeathBar.position = (position + Vector2(-48, -71))
	rotateSpeed = randf_range(-0.1, 0.1)
	$HeathBar.max_value = heath
	$HeathBar.visible = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if $"../Player".inEnemy == false and area.is_in_group("Player"):
		inRobot = true
		$RobotStartup.play()
		$"../Player".inEnemy = true
		$"../Player".position = position
		$"ProgressBar".visible = true
		$"ProgressBar".max_value = (hackTime - 1)
		$Timer.start(heathPer * hackTime)


@warning_ignore("unused_parameter")
func _on_hurt_box_area_entered(area: Area2D) -> void:
	if inRobot == true:
		if area.is_in_group("Plasma"):
			if $Timer.time_left > 0.6:
				$Timer.start($Timer.time_left - 0.5)
			elif $Timer.time_left <= 0.6:
				$Timer.start(0.1)
		elif area.is_in_group("Rocket"):
			if $Timer.time_left > 1.0:
				$Timer.start($Timer.time_left - 0.5)
			elif $Timer.time_left <= 0.6:
				$Timer.start(0.1)
	elif inRobot == false:
		if area.is_in_group("Plasma"):
			heath -= Globalvars.PlasmaDmg
		elif area.is_in_group("Rocket"):
			heath -= Globalvars.RocketDmg
		elif area.is_in_group("Expload"):
			heath -= Globalvars.ExploadeDmg


func _process(_delta: float) -> void:

	if inRobot == true:
		$Explode/Sprite2D.visible = true
		$HeathBar.visible = false
		look_at(get_global_mouse_position())
		$HurtBox.set_collision_layer_value(5, false)
		$HurtBox.set_collision_mask_value(5, false)
		$"../Player".visible = false
		position = $"../Player".position
		$Area2D/CollisionShape2D.disabled = true

	if inRobot == false:
		# this is what we want when enemy virus hacks robot "look_at($"../Player".position)"
		look_at($"../Player".position)

	if heath <= 0:
		queue_free()

	if heath <= 0 and inRobot == true:
		die()


	$HeathBar.value = heath
	$HeathBar.position = (position + Vector2(-48, -71))
	heathPer = ($HeathBar.value / $HeathBar.max_value)

func _on_timer_timeout() -> void:
	die()

func die():
	$"../Player/RobotDeath".play()
	$Explode/CollisionShape2D.disabled = false
	$Die.start(0.1)


func _on_die_timeout() -> void:
	$"../Player/RobotDeath".play()
	$"../Player".inEnemy = false
	$"../Player".visible = true
	$"../Player/Area2D/CollisionShape2D".disabled = false
	emit_signal("dead")
	call_deferred("queue_free")
