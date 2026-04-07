@tool
extends VBoxContainer

const CHARACTER_LIST = "res://_Main/dialogue/"
const CHARACTER_ITEM_PATH = "res://addons/dialogue/scenes/character_list_item.tscn"

@export var character_list: VBoxContainer
@export var dialogue_files: VBoxContainer

func _ready() -> void:
	refresh_list()

func refresh_list() -> void:
	
	# Clear existing items
	for child in character_list.get_children():
		child.queue_free()

	var dir = DirAccess.open(CHARACTER_LIST)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()

		while file_name != "":
			# Use begins_with (plural) to skip hidden system folders
			if dir.current_is_dir() and not file_name.begins_with("."):
				var character_scene = load(CHARACTER_ITEM_PATH)
				var instance = character_scene.instantiate()
				
				# If your tscn's root is a Button, set the text
				if instance is Button:
					instance.text = file_name
				
				character_list.add_child(instance)
				character_list.pressed.connect(dialogue_files.set_dialogue_list)
				instance.tooltip_text = file_name + "."
			
			file_name = dir.get_next()
			
		dir.list_dir_end()
	else:
		print("Error: Could not open path ", CHARACTER_LIST)
