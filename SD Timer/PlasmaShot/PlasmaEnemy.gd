extends RigidBody2D

@warning_ignore("unused_signal")
signal dead

@export var rotateSpeed = 1.0
@export var heath = 20
@export var heathPer : float

@export var hackTime = 5
@export var isHackable = false
@export var inRobot = false
@export var isPicked = false
@export var cooldown = 0.5

@export var bullet : PackedScene
@export var bulletRotation : float

func _ready() -> void:
	$HeathBar.position = (position + Vector2(-48, -71))
	rotateSpeed = randf_range(-0.1, 0.1)
	$HeathBar.max_value = heath
	$HeathBar.visible = true


func _on_plasma_shot_timeout() -> void:
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = $Shot.global_transform


	#$Sprite2D.frame = 1
	#var b2 = bullet.instantiate()
	#owner.add_child(b2)
	#b2.transform = $Shot2.global_transform
	#$RocketSprite.start(cooldown / 2)

	#$Sprite2D.frame = 1
	#var b3 = bullet.instantiate()
	#owner.add_child(b3)
	#b3.transform = $Shot3.global_transform
	#$RocketSprite.start(cooldown / 2)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if $"../Player".inEnemy == false and area.is_in_group("Player"):
		inRobot = true
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
				$Timer.start($Timer.time_left - 1)
			elif $Timer.time_left <= 1:
				$Timer.start(0.1)
	elif inRobot == false:
		if area.is_in_group("Plasma"):
			heath -= Globalvars.PlasmaDmg
		elif area.is_in_group("Rocket"):
			heath -= Globalvars.RocketDmg
		elif area.is_in_group("Explode"):
			heath -= Globalvars.ExploadeDmg


func _process(_delta: float) -> void:

	if inRobot == true:
		$HeathBar.visible = false
		look_at(get_global_mouse_position())
		$HurtBox.set_collision_layer_value(5, false)
		$HurtBox.set_collision_mask_value(5, false)
		$"../Player".visible = false
		position = $"../Player".position
		$Area2D/CollisionShape2D.disabled = true

	if inRobot == false:
		# this is what we want when enemy virus hacks robot "look_at($"../Player".position)"
		rotation += rotateSpeed

	if heath <= 0:
		queue_free()

	if heath <= 0 and inRobot == true:
		$"../Player".inEnemy = false
		$"../Player".visible = true
		$"../Player/Area2D/CollisionShape2D".disabled = false
		die()


	$HeathBar.value = heath
	$HeathBar.position = (position + Vector2(-48, -71))
	heathPer = ($HeathBar.value / $HeathBar.max_value)


func _on_timer_timeout() -> void:
	$"../Player".inEnemy = false
	$"../Player".visible = true
	$"../Player/Area2D/CollisionShape2D".disabled = false
	die()


func die():
	emit_signal("dead")
	queue_free()
