extends Task

func enter() -> void:
	print("ATTACK")
	await get_tree().create_timer(1).timeout
	if randf() < 0.5:
		emit_task_finished(true)
	else:
		emit_task_finished(false)
