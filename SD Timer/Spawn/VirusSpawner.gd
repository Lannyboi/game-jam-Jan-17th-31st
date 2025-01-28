extends Node2D

@export var spawn : PackedScene
@export var Cooldown = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	$Cooldown.start(randf_range(0.1, 1.0))

func spawner():
	if Globalvars.virus < Globalvars.viruscap:
		var b = spawn.instantiate()
		b.position = self.position
		get_parent().call_deferred("add_child", b)
		b.connect("dead", Callable(self, "_on_enemy_dead"))
		Globalvars.virus += 1
		$Cooldown.start(1)
	else:
		$Cooldown.start(Cooldown)


func _on_enemy_dead():
	Globalvars.virusleft -= 1
	Globalvars.virus -= 1
	$Cooldown.start(Cooldown)


func _on_cooldown_timeout() -> void:
	spawner()
