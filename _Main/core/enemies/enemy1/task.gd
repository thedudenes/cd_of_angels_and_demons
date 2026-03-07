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
