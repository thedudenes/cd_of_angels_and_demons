extends Node

signal behaviour_changed(previous, current)

@export var default_behaviour: Behaviour

var behaviours: Dictionary[String, Node]

var current_behaviour: Behaviour = null

func _ready() -> void:
	initialize()
	if default_behaviour:
		switch_behaviour(default_behaviour.name.to_lower())

func initialize() -> void:
	#print("INIT BEHAVIOUR MACHINE")
	var children = get_children().filter(func(child): return child is Behaviour)
	for behaviour in children:
		#print("BEHAVIOUR: ",behaviour)
		behaviours[behaviour.name.to_lower()] = behaviour
		behaviour.switch_behaviour.connect(switch_behaviour)
		behaviour.switch_task.connect(switch_task)

func _process(delta: float) -> void:
	if current_behaviour.current_task:
		current_behaviour.current_task.update(delta)

func _physics_process(delta: float) -> void:
	if current_behaviour.current_task:
		current_behaviour.current_task.physics_update(delta)

func switch_behaviour(new_behaviour_name: String) -> void:
	#print("1.0 SWITCH BEHAVIOUR")
	#print("1.1 BEHAVIOURS: ",behaviours)
	if behaviours.has(new_behaviour_name):
		#print("1.2: ",behaviours[new_behaviour_name])
		var previous_behaviour = current_behaviour
		if previous_behaviour:
			previous_behaviour.current_task.exit()
		current_behaviour = behaviours[new_behaviour_name]
		behaviour_changed.emit(previous_behaviour, current_behaviour)
		#print("1.2 NEW BEHAVIOUR: ",current_behaviour)
		#print("1.3 CURRENT TASK: ",current_behaviour.initial_task)
		switch_task(current_behaviour.initial_task)
	else:
		push_error("ERROR: behaviour '" + new_behaviour_name + "' not found!")

func switch_task(new_task_name) -> void:
	#print("2.0 SWITCH TASK")
	if current_behaviour.tasks.has(new_task_name):
		#print("2.1 new_task_name: ",new_task_name)
		var previous_state = current_behaviour.current_task
		if current_behaviour.current_task:
			current_behaviour.current_task.exit()
		current_behaviour.current_task = current_behaviour.tasks[new_task_name]
		current_behaviour.current_task.enter()
		behaviour_changed.emit(previous_state, current_behaviour.current_task)
	else:
		push_error("ERROR: task '" + new_task_name + "' not found!")

func _on_state_switch(new_behaviour_name: String) -> void:
	switch_behaviour(new_behaviour_name)
