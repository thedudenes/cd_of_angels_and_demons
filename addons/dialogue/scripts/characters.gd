@tool
extends VBoxContainer

const CHARACTER_LIST = "res://_Main/dialogue/"
const CHARACTER_ITEM_PATH = "res://addons/dialogue/scenes/character_list_item.tscn"

@export var list: VBoxContainer
@export var dialogue: VBoxContainer

var current_character: String

func _ready() -> void:
	refresh_list()

func refresh_list() -> void:
	for child in list.get_children():
		child.queue_free()

	var dir = DirAccess.open(CHARACTER_LIST)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var current_character_persists: bool = false
		while file_name != "":
			if current_character == file_name and current_character_persists == false:
				current_character_persists = true
			# Use begins_with (plural) to skip hidden system folders
			if dir.current_is_dir() and not file_name.begins_with("."):
				var character_scene = load(CHARACTER_ITEM_PATH)
				var instance = character_scene.instantiate()
				
				# If your tscn's root is a Button, set the text
				if instance is Button:
					instance.text = file_name
				
				list.add_child(instance)
				instance.pressed.connect(set_character.bind(file_name))
				instance.tooltip_text = file_name + "."
			
			file_name = dir.get_next()
			
		if current_character_persists == false:
			current_character = ""
		dir.list_dir_end()
	else:
		print("Error: Could not open path ", CHARACTER_LIST)

func set_character(s: String) -> void:
	current_character = s
	dialogue.refresh_list()
	
