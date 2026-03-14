extends Task

func enter() -> void:
	#print("ENTER ATTACK")
	connect_signals()
	animations.play("animation_library_one/Sword_Attack")

func animation_finished(s: String) -> void:
	if s == "animation_library_one/Sword_Attack":
		emit_task_finished(true)
