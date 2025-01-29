extends Area2D

@export var speed = 250
@export var pierce = 0

func _ready() -> void:
	GlobalSign.MainMenu.connect(Callable(self, "_on_MainMenu"))
	GlobalSign.death.connect(Callable(self, "_on_Death"))

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


func _on_Death():
	queue_free()
