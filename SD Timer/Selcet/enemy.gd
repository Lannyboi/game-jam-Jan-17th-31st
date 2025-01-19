extends RigidBody2D

@export var hackTime = 5
@export var isHackable = false
@export var inRobot = false
@export var isPicked = false


func _on_area_2d_area_entered(_area: Area2D) -> void:
	$"../Player".enemysSelected += 1
	if $"../Player".inEnemy == false:
		isHackable = true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	$"../Player".enemysSelected -= 1
	isHackable = false


func _mouse_enter() -> void:
	isPicked = true
	print("Picked: ", isPicked)


func _mouse_exit() -> void:
	isPicked = false
	print("Picked: ", isPicked)


func _process(delta: float) -> void:
	# Sets frame to add a white outline
	if isPicked == false or inRobot == true:
		$Sprite2D.frame = 0
	elif isPicked == true:
		$Sprite2D.frame = 1

	if (
		Input.is_action_just_pressed("Hack")
		and (
			(isHackable == true and isPicked == true)
			or (isHackable == true and $"../Player".enemysSelected == 1)
		)
	):
		inRobot = true
		$"../Player".inEnemy = true
		print("Space bar pressed and robot has been hacked!")
		$"../Player".position = position
		$"../Player/Area2D/CollisionShape2D".disabled = true
		$"ProgressBar".visible = true
		$"ProgressBar".max_value = (hackTime - 1)
		$Timer.start(hackTime - 1)
	elif Input.is_action_just_pressed("Hack") and isHackable == false:
		print("Space bar pressed and robot cannot be hacked!")

	if inRobot == true:
		$"../Player".visible = false
		position = Vector2($"../Player".position)


func _on_timer_timeout() -> void:
	$"../Player".inEnemy = false
	$"../Player".visible = true
	$"../Player/Area2D/CollisionShape2D".disabled = false
	queue_free()
