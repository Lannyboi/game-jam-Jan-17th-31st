extends CharacterBody2D

@export var speed = 450.0
@export var inEnemy = false
@export var enemysSelected = 0
@export var PlayerHeath = 10

func _ready() -> void:
	$"UI/HeathBar".max_value = PlayerHeath

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func _physics_process(_delta):
	get_input()
	move_and_slide()

	if inEnemy == true:
		$"HurtBox/CollisionShape2D".disabled = true
		$Area2D/CollisionShape2D.disabled = true
	elif inEnemy == false:
		$"HurtBox/CollisionShape2D".disabled = false
		$Area2D/CollisionShape2D.disabled = false

	$"UI/HeathBar".value = PlayerHeath


func hit():
	if PlayerHeath <= 0:
		get_tree().quit()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if inEnemy == false:
		if area.is_in_group("Plasma"):
			PlayerHeath -= Globalvars.PlasmaDmg
			hit()
		elif area.is_in_group("Rocket"):
			PlayerHeath -= Globalvars.RocketDmg
			hit()
