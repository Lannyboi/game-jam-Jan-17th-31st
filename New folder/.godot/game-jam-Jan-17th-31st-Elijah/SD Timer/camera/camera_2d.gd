extends Camera2D

func _ready() -> void:
	limit_left = $"../StaticBody2D/Left_Wall".position.x
	limit_right = $"../StaticBody2D/Right_Wall".position.x
	limit_top = $"../StaticBody2D/Top_Wall".position.y
	limit_bottom = $"../StaticBody2D/Bottom_Wall".position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var player_pos = Vector2($"../Player".position)
	position = Vector2(player_pos)
