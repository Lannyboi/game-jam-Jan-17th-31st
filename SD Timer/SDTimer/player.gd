extends CharacterBody2D

@export var speed = 300.0
@export var inEnemy = false
@export var enemysSelected = 0


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
