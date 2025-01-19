extends CharacterBody2D

@export var inRobotSpeed = 300.0

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
		$"ProgressBar".visible = true
		$"ProgressBar".max_value = (hackTime - 1)
		$Timer.start(hackTime - 1)
	elif Input.is_action_just_pressed("Hack") and isHackable == false:
		print("Space bar pressed and robot cannot be hacked!")

	if inRobot == true:
		$"../Player/CollisionShape2D".disabled = true
		$"../Player/Sprite2D".visible = false
		$"../Player".position = position


func _on_timer_timeout() -> void:
	$"../Player".inEnemy = false
	$"../Player/CollisionShape2D".disabled = false
	$"../Player/Sprite2D".visible = true
	queue_free()


func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if inRobot == true:
		var directionx := Input.get_axis("ui_left", "ui_right")
		var directiony := Input.get_axis("ui_up", "ui_down")
		if directionx:
			velocity.x = directionx * inRobotSpeed
		else:
			velocity.x = move_toward(velocity.x, 0, inRobotSpeed)
		
		if directiony:
			velocity.y = directiony * inRobotSpeed
		else:
			velocity.y = move_toward(velocity.y, 0, inRobotSpeed)

		move_and_slide()
