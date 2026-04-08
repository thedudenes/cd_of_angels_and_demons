@tool
extends Button

var resource: Character

func set_resource(r: Character) -> void:
	text = r.name
	resource = r
	tooltip_text = r.name + "."
