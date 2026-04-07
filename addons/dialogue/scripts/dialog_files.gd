@tool
extends VBoxContainer

const DIALOGUE_PATH = "res://_Main/dialogue/"
const DIALOGUE_ITEM_PATH = "res://addons/dialogue/scenes/dialog_list_item.tscn"

@export var dialogue_list: VBoxContainer
@export var creation_pop_up: Panel

var current_character: String

func _ready() -> void:
	for child in dialogue_list.get_children():
		child.queue_free()

func refresh_list(s: String) -> void:
	var dialogue_list_path = DIALOGUE_PATH + s + "/dialogue"
	print("CHARACTER DIALOGUE FOLDER: ", dialogue_list_path)
	current_character = s
	print("CHARACTER SELECTED: ",current_character)
	for child in dialogue_list.get_children():
		child.queue_free()

	var dir = DirAccess.open(dialogue_list_path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()

		while file_name != "":
			# Use begins_with (plural) to skip hidden system folders
			if dir.current_is_dir() and not file_name.begins_with("."):
				var character_scene = load(DIALOGUE_ITEM_PATH)
				var instance = character_scene.instantiate()
				
				# If your tscn's root is a Button, set the text
				if instance is Button:
					instance.text = file_name
				
				dialogue_list.add_child(instance)
				instance.tooltip_text = file_name + "."
			
			file_name = dir.get_next()
			
		dir.list_dir_end()
	else:
		print("Error: Could not open path ", DIALOGUE_PATH)

func _on_popup_button_pressed() -> void:
	if current_character != "":
		creation_pop_up.current_character = current_character
		creation_pop_up.show()
