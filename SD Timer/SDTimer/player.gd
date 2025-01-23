extends CharacterBody2D

@export var speed = 300.0
@export var inEnemy = false
@export var enemysSelected = 0



func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
	
	if inEnemy == true:
		$HurtBox.monitorable = false
		$Area2D/CollisionShape2D.disabled = true
	elif inEnemy == false:
		$HurtBox.monitorable = true
		$Area2D/CollisionShape2D.disabled = false
