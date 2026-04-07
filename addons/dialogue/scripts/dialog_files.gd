@tool
extends VBoxContainer

const DIALOGUE_PATH = "res://_Main/dialogue/"
const DIALOGUE_ITEM_PATH = "res://addons/dialogue/scenes/dialog_list_item.tscn"

@export var characters: VBoxContainer
@export var list: VBoxContainer
@export var creation_pop_up: Panel

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
				
				# FIX 2: Ensure 'text' is set on the right property.
				# If your item is a Button, 'instance.text' works.
				# If your item is a Panel with a Label, use: instance.get_node("Label").text
				instance.text = file_name.replace(".tres", "") 
				#instance.pressed.connect()
				list.add_child(instance)
				instance.tooltip_text = file_name
			
			file_name = dir.get_next()
			
		dir.list_dir_end()
	else:
		printerr("Error: Could not open path ", dialogue_list_path)

func _on_popup_button_pressed() -> void:
	if characters.current_character != "":
		creation_pop_up.current_character = characters.current_character
		creation_pop_up.show()
