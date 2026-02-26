extends Node
class_name PlayerState

signal switch_state
var animations: AnimationPlayer
var player: Player

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
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

func animation_finished(_s:String) -> void:
	pass
