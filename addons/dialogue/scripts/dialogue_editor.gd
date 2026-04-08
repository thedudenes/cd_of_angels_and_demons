@tool
extends VBoxContainer

@export var character: VBoxContainer
@export var dialog: VBoxContainer
@export var character_name: Label

func set_current_character() -> void:
	character_name.text = character.current_character
