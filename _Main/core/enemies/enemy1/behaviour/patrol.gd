extends Node
class_name Behavour

signal swicht_task(s: String)

@export var injectables: Array[Dictionary]

var tasks: Dictionary[String, Node]

var current_task = null

signal task_changed(previous, current)

func _ready() -> void:
	initialize_tasks()
	if "Still" in tasks:
		switch_task("Still")

func initialize_tasks() -> void:
	var children = get_children().filter(func(child): return child is Task)
	for task: Task in children:
		tasks[task.name.to_lower()] = task
		for injectable in injectables:
			for name_key in injectable:
				var path = injectable[name_key]
				task[name_key] = get_node(path)
		if not task.task_finished.is_connected(switch_task):
			task.task_finished.connect(switch_task)

func switch_task(new_state_name: String) -> void:
	#si la tarea fue exisotosa, pasar a X beaviour
	#si no, pasar a Y behaviour
	if tasks.has(new_state_name):
		var previous_task = current_task
		if current_task:
			current_task.exit()
		current_task = tasks[new_state_name]
		current_task.enter()
		task_changed.emit(previous_task, current_task)
	else:
		push_error("ERROR: State '" + new_state_name + "' not found!")

func _on_switch_task(new_task_name: String) -> void:
	switch_task(new_task_name)

func emit_swicht_task() -> void:
	swicht_task.emit()
