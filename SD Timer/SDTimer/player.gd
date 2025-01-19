extends CharacterBody2D


@export var speed = 300.0
@export var inEnemy = false
@export var enemysSelected = 0

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if inEnemy == false:
		var directionx := Input.get_axis("ui_left", "ui_right")
		var directiony := Input.get_axis("ui_up", "ui_down")
		if directionx:
			velocity.x = directionx * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
		
		if directiony:
			velocity.y = directiony * speed
		else:
			velocity.y = move_toward(velocity.y, 0, speed)

		move_and_slide()
