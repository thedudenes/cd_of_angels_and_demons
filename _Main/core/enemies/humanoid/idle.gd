extends Task

func enter() -> void:
	#print("ENTER IDLE")
	connect_signals()
	animations.play("animation_library_one/Sword_Idle")

func update(_delta: float) -> void:
	enemy.look_at(enemy.player.position, Vector3.UP)

func animation_finished(s: String) -> void:
	if s == "animation_library_one/Sword_Idle":
		#print("ANIM FINISHED: ",s)
		emit_task_finished(true)
	pass
