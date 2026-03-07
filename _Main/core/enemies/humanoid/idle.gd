extends Task

func enter() -> void:
	print("ENTER IDLE")
	connect_signals()
	animations.play("universal_anim_library/Sword_Idle")

func update(_delta: float) -> void:
	enemy.look_at(enemy.player.position, Vector3.UP)

func animation_finished(s: String) -> void:
	if s == "universal_anim_library/Sword_Idle":
		print("ANIM FINISHED: ",s)
		emit_task_finished(true)
	pass
