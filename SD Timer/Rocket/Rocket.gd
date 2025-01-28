extends Area2D

@export var speed = 250
@export var pierce = 0

func _ready() -> void:
	GlobarSign.MainMenu.connect(Callable(self, "_on_MainMenu"))

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Rocket"):
		queue_free()
	else:
		if pierce == 0:
			queue_free()
		elif pierce > 0:
			pierce -= 1

func _on_MainMenu():
	queue_free()
