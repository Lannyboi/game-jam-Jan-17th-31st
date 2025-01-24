extends Area2D

@export var speed = 450

func _ready() -> void:
	$AnimatedSprite2D.play("Main")


func _physics_process(delta):
	position += transform.x * speed * delta



func _on_area_entered(_area: Area2D) -> void:
	queue_free()
