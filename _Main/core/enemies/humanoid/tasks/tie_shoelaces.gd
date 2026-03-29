extends Task

var player_found: bool = false

func enter() -> void:
	connect_signals()
	#enemy.velocity = Vector3.ZERO
	animations.play("animation_library_one/Fixing_Kneeling")
	player_found = false

func physics_update(_delta: float) -> void:
	if !player_found:
		# 1. Get a list of all physics bodies currently inside the Area3D
		var overlapping_bodies = enemy.detection_area.get_overlapping_bodies()
		# 2. Loop through them to find the Player
		for body in overlapping_bodies:
			if body is Player:
				# Optional: Add a Line-of-Sight check here if you don't 
				# want the enemy to see the player through walls!
				enemy.player = body
				player_found = true
				emit_task_finished(false)
				break # Stop looking once the player is found

func animation_finished(s: String) -> void:
	if s == "animation_library_one/Fixing_Kneeling":
		emit_task_finished(true)
