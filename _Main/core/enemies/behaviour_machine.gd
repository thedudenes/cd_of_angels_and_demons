extends Node

@export var animations: AnimationPlayer
@export var enemy: Enemy

var behaviours: Dictionary[String, Node]

var current_behaviour = null

signal behaviour_changed(previous, current)

func _ready() -> void:
	var children = get_children().filter(func () )
	if "Patrol" in behaviours:
		switch_behaviour("Patrol")

func _process(delta: float) -> void:
	if current_behaviour:
		current_behaviour.update(delta)

func _physics_process(delta: float) -> void:
	if current_behaviour:
		current_behaviour.physics_update(delta)

func _unhandled_input(event: InputEvent) -> void:
	if current_behaviour:
		current_behaviour.input(event)

func switch_behaviour(new_state_name: String) -> void:
	if behaviours.has(new_state_name):
		var previous_state = current_behaviour
		if current_behaviour:
			current_behaviour.exit()
		current_behaviour = behaviours[new_state_name]
		current_behaviour.enter()
		behaviour_changed.emit(previous_state, current_behaviour)
	else:
		push_error("ERROR: State '" + new_state_name + "' not found!")

func _on_state_switch(new_state_name: String) -> void:
	switch_behaviour(new_state_name)
