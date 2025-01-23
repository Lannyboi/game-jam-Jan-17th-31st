extends RigidBody2D

@export var rotateSpeed = 1.0
@export var heath = 20

@export var hackTime = 5
@export var isHackable = false
@export var inRobot = false
@export var isPicked = false

@export var bullet : PackedScene
@export var bulletRotation : float

func _ready() -> void:
	rotateSpeed = randf_range(-0.2, 0.2)
	$HeathBar.max_value = heath
	$HeathBar.visible = true


func _on_bullet_timeout() -> void:
		var b = bullet.instantiate()
		owner.add_child(b)
		b.transform = $Shot.global_transform


func _on_area_2d_area_entered(_area: Area2D) -> void:
	if $"../Player".inEnemy == false:
		inRobot = true
		$"../Player".inEnemy = true
		$"../Player".position = position
		$"ProgressBar".visible = true
		$"ProgressBar".max_value = (hackTime - 1)
		$Timer.start(hackTime - 1)


@warning_ignore("unused_parameter")
func _on_hurt_box_area_entered(area: Area2D) -> void:
	heath -= 1


func _process(_delta: float) -> void:
	# Sets frame to add a white outline
	if isPicked == false or inRobot == true:
		$Sprite2D.frame = 0
	elif isPicked == true:
		$Sprite2D.frame = 1

	if inRobot == true:
		$HurtBox.set_collision_layer_value(5, false)
		$HurtBox.set_collision_mask_value(5, false)
		rotation = 0
		$"../Player".visible = false
		position = $"../Player".position
		$Area2D/CollisionShape2D.disabled = true

	#if inRobot == false:
		#rotation += rotateSpeed

	if heath == 0:
		queue_free()

	if heath == 0 and inRobot == true:
		$"../Player".inEnemy = false
		$"../Player".visible = true
		$"../Player/Area2D/CollisionShape2D".disabled = false
		queue_free()


	$HeathBar.value = heath
	$HeathBar.position = (position + Vector2(-16, -26))

func _on_timer_timeout() -> void:
	$"../Player".inEnemy = false
	$"../Player".visible = true
	$"../Player/Area2D/CollisionShape2D".disabled = false
	queue_free()
