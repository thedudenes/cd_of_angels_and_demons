extends Node

@export var player: Player
@export var animations: AnimationPlayer

var states: Dictionary[String, Node]

var current_state = null

signal state_changed(previous, current)

func _ready() -> void:
	initialize_states()
	if "idle" in states:
		switch_state("idle")

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.input(event)

func initialize_states() -> void:
	var children = get_children().filter(func(child): return child is PlayerState)
	for state: PlayerState in children:
		#print("STATE: ",state)
		states[state.name.to_lower()] = state
		state.animations = animations
		state.player = player
		state.switch_state.connect(switch_state)
	

func switch_state(new_state_name: String) -> void:
	if states.has(new_state_name):
		var previous_state = current_state
		if current_state:
			current_state.exit()
		current_state = states[new_state_name]
		current_state.enter()
		state_changed.emit(previous_state, current_state)
	else:
		push_error("ERROR: State '" + new_state_name + "' not found!")

func _on_state_switch(new_state_name: String) -> void:
	switch_state(new_state_name)
