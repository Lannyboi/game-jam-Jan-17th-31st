extends RigidBody2D

@export var rotateSpeed = 1.0

@export var hackTime = 5
@export var isHackable = false
@export var inRobot = false
@export var isPicked = false


func _ready() -> void:
	rotateSpeed = randf_range(-0.3, 0.3)

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
		rotation = 0
		$"../Player".visible = false
		position = $"../Player".position

	if inRobot == false:
		rotation += rotateSpeed

func _on_timer_timeout() -> void:
	$"../Player".inEnemy = false
	$"../Player".visible = true
	$"../Player/Area2D/CollisionShape2D".disabled = false
	queue_free()
