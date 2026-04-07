@tool
extends Control

@export var characters: VBoxContainer
@export var dialogue: VBoxContainer

var current_character: String

func _ready() -> void:
	if Engine.is_editor_hint():
		var efs = EditorInterface.get_resource_filesystem()
		if not efs.filesystem_changed.is_connected(_on_filesystem_changed):
			efs.filesystem_changed.connect(_on_filesystem_changed)
	
	refresh_all()

#THIS FUNCTION TRIGGERS WHENEVER ANY FILE IN THE PROJECT CHANGES
func _on_filesystem_changed() -> void:
	#print("Filesystem changed, updating Visualizer...")
	refresh_all()

func refresh_all() -> void:
	#print("REFRESH CHARACTER LIST: ",characters)
	characters.refresh_list()
	if current_character != "":
		dialogue.refresh_list(current_character)

func set_character(s: String) -> void:
	current_character = s
	dialogue.refresh_list(current_character)


func _on_button_pressed() -> void:
	pass # Replace with function body.
