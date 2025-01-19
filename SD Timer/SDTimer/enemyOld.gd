extends RigidBody2D

@export var hackTime = 5
@export var isHackable = false
@export var inRobot = false


func _on_area_2d_area_entered(_area: Area2D) -> void:
	if $"../Player".inEnemy == false:
		isHackable = true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	isHackable = false


func _process(delta: float) -> void:
	# Sets frame to add a white outline

	if (
		Input.is_action_just_pressed("Hack") and isHackable == true):
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
