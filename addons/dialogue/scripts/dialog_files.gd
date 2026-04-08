@tool
extends VBoxContainer

const DIALOGUE_PATH = "res://_Main/dialogue/"
const DIALOGUE_ITEM_PATH = "res://addons/dialogue/scenes/dialog_list_item.tscn"

@export var characters: VBoxContainer
@export var list: VBoxContainer
@export var creation_pop_up: Panel
@export var dialogue_editor: VBoxContainer

var current_dialogue: Dialogue

func _ready() -> void:
	for child in list.get_children():
		child.queue_free()

func refresh_list() -> void:
	var dialogue_list_path = DIALOGUE_PATH + characters.current_character + "/dialogue/"
	
	# Clear existing list
	for child in list.get_children():
		child.queue_free()

	if not DirAccess.dir_exists_absolute(dialogue_list_path):
		print("No dialogue folder found for: ", characters.current_character)
		return

	var dir = DirAccess.open(dialogue_list_path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()

		while file_name != "":
			# FIX 1: Look for FILES, not directories. 
			# Also filter for .tres files and ignore the import files
			if not dir.current_is_dir() and file_name.ends_with(".tres"):
				var item_scene = load(DIALOGUE_ITEM_PATH)
				var instance = item_scene.instantiate()
				#print(characters.current_character + " DIALOGUES: ",dialogue_list_path + file_name)
				var resource = load(dialogue_list_path + file_name)
				#print("DIALOGUE: ", resource)
				instance.set_resource(resource)
				instance.pressed.connect(set_current_dialogue.bind(resource))
				list.add_child(instance)
			
			file_name = dir.get_next()
			
		dir.list_dir_end()
	else:
		printerr("Error: Could not open path ", dialogue_list_path)

func set_current_dialogue(r: Dialogue) -> void:
	current_dialogue = r
	

func _on_popup_button_pressed() -> void:
	if characters.current_character != "":
		creation_pop_up.current_character = characters.current_character
		creation_pop_up.show()
