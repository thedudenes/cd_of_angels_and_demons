@tool
extends Button

signal play_animation(s: String)

var anim_name: String

func _pressed() -> void:
	play_animation.emit(anim_name)

func set_anim_name(s: String) -> void:
	anim_name = s
