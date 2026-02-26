extends Node
class_name PlayerState

signal switch_state
var animations: AnimationPlayer
var player: Player

func initialize():
	connect_signals()

func enter() -> void:
	pass
	
func exit() -> void:
	disconnect_signals()
	
func physics_update(_delta: float) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func input(_event: InputEvent) -> void:
	pass

func switch_state_emit(s: String) -> void:
	switch_state.emit(s)

func connect_signals() -> void:
	animations.animation_finished.connect(animation_finished)

func disconnect_signals() -> void:
	if animations.animation_finished.is_connected(animation_finished):
		animations.animation_finished.disconnect(animation_finished)

func animation_finished(_s:String) -> void:
	pass
