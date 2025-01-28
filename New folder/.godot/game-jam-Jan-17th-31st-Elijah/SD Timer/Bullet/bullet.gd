extends Area2D

@export var speed = 550


func _physics_process(delta):
	position += transform.x * speed * delta


func _on_area_entered(_area: Area2D) -> void:
	queue_free()
