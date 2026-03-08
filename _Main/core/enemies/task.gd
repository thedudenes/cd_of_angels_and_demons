extends Node
class_name Task

signal task_finished(b: bool)

var animations: AnimationPlayer
var enemy: Enemy

func enter() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func input() -> void:
	pass

func exit() -> void:
	pass
	

func emit_task_finished(b: bool) -> void:
	task_finished.emit(b)

func connect_signals() -> void:
	if !animations.animation_finished.is_connected(animation_finished):
		#print("CONNECT ANIMATIONS SIGNALS")
		animations.animation_finished.connect(animation_finished)

func animation_finished(_s: String) -> void:
	pass
