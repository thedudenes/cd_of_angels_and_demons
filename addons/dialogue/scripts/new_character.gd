@tool
extends Button

const CHARACTERS_PATH = "res://_Main/dialogue/"

@export var popup: Panel

func _pressed() -> void:
	print("NEW CHARACTER")
	popup.show()
	var dir = DirAccess.open(CHARACTERS_PATH)
	
