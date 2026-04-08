@tool
extends Button

var resource: Dialogue

func set_resource(r: Dialogue) -> void:
	text = r.title
	resource = r
	tooltip_text = r.title + "."
