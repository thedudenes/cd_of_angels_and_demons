extends Task

func enter() -> void:
	#print("ENTER ATTACK")
	connect_signals()
	animations.play("universal_anim_library/Sword_Attack")

func animation_finished(s: String) -> void:
	if s == "universal_anim_library/Sword_Attack":
		emit_task_finished(true)
