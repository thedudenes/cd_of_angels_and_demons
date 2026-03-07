extends Task

var player_found: bool = false

func enter() -> void:
	print("ENTER STILL")
	player_found = false

func physics_update(_delta: float) -> void:
	if !player_found:
		print(enemy.raycast.is_colliding())
		if enemy.raycast.is_colliding():
			var body = enemy.raycast.get_collider()
			if body is Player:
				emit_task_finished(true)
				player_found = true
