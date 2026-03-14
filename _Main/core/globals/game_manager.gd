extends Node

signal change_scene(s: String)

signal state_changed(new_state: String, old_state: String)

var current_state: STATES = STATES.MAIN_MENU  # initial state
var old_state: STATES

enum STATES {
	RUN,
	DEAD,
	PAUSE,
	MAIN_MENU
}

func set_state(new_state: STATES) -> void:
	if new_state == current_state:
		return
	old_state = current_state
	current_state = new_state
	print("🎮 Game state changed:", STATES.find_key(new_state))
	emit_signal("state_changed", new_state, old_state)

func is_state(state: STATES) -> bool:
	return current_state == state

func emit_change_scene(s: String) -> void:
	change_scene.emit(s)
