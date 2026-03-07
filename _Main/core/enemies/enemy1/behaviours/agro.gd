extends Behaviour

func task_finished(success: bool) -> void:
	var old_task = current_task
	print("AGRO TASK FINISHED: ", old_task.name)
	match old_task.name.to_lower():
		"attack":
			if success:
				print("success")
				emit_switch_task("attack2")
			else:
				print("failure")
				emit_switch_behaviour("patrol")
			return
		"attack2":
			if success:
				print("success")
				emit_switch_behaviour("agro")
			else:
				print("failure")
				emit_switch_behaviour("patrol")
			return
		_:
			print("ERROR: NO HANDLED RESULT: ", old_task, success)
