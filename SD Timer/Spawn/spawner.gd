extends Node2D

@export var spawn : PackedScene
@export var Cooldown = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	$Cooldown.start(randf_range(0.1, 1.0))

func spawner():
	if Globalvars.enemys < Globalvars.enemycap:
		var b = spawn.instantiate()
		b.position = self.position
		get_parent().call_deferred("add_child", b)
		b.connect("dead", Callable(self, "_on_enemy_dead"))
		Globalvars.enemys += 1
	else:
		$Cooldown.start(Cooldown)


func _on_enemy_dead():
	Globalvars.enemys -= 1
	$Cooldown.start(Cooldown)


func _on_cooldown_timeout() -> void:
	spawner()
