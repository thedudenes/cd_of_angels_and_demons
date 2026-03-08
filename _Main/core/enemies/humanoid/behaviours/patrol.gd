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
				if randf() > 0.1:
					emit_switch_task("walk to")
				else:
					emit_switch_task("tie shoelaces")
			return
		"walk to":
			if success:
				if randf() > 0.1:
					emit_switch_task("still")
				else:
					emit_switch_task("tie shoelaces")
			else:
				emit_switch_behaviour("agro")
			return
		"tie shoelaces":
			if success:
				if randf() < 0.5:
					emit_switch_task("still")
				else:
					emit_switch_task("walk to")
			else:
				emit_switch_behaviour("agro")
			return
		_:
			print("ERROR: NO HANDLED RESULT: ", old_task, success)
