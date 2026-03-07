extends Behaviour

func task_finished(success: bool) -> void:
	var old_task = current_task
	print("TASK FINISHED")
	print("OLD TASK: ",old_task)
	match old_task.name.to_lower():
		"still":
			if success:
				emit_switch_behaviour("agro")
			else:
				emit_switch_task("walk_to")
			return
		"walk_to":
			if success:
				emit_switch_task("still")
			else:
				emit_switch_behaviour("agro")
			return
		_:
			print("ERROR: NO HANDLED RESULT: ", old_task, success)
