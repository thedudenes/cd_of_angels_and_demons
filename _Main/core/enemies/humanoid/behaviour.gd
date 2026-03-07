extends Node
class_name Behaviour

signal switch_behaviour(s: String)
signal switch_task(s: String)

@export var initial_task: String
@export var injectables: Dictionary[String, Node]

var enemy: Enemy
var animations: AnimationPlayer

var tasks: Dictionary[String, Node]

var current_task: Task = null

func _ready() -> void:
	initialize_tasks()
	current_task = tasks[initial_task]

func enter() -> void:
	pass

func initialize_tasks() -> void:
	var children = get_children().filter(func(child): return child is Task)
	for task: Task in children:
		tasks[task.name.to_lower()] = task
		for name_key in injectables:
			print("NAME KEY: ",name_key)
			var path = injectables[name_key].get_path()
			task[name_key] = get_node(path)
		if not task.task_finished.is_connected(task_finished):
			task.task_finished.connect(task_finished)

func task_finished(_success: bool) -> void:
	pass

func emit_switch_task(s: String) -> void:
	switch_task.emit(s)

func emit_switch_behaviour(s: String) -> void:
	switch_behaviour.emit(s)
