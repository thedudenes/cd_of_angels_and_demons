@tool
extends VBoxContainer

const DIALOGUE_PATH = "res://_Main/dialogue/"
const DIALOGUE_ITEM_PATH = "res://addons/dialogue/scenes/dialog_list_item.tscn"

@export var dialogue_list: VBoxContainer

func _ready() -> void:
	for child in dialogue_list.get_children():
		child.queue_free()

func set_dialogue_list(s: String) -> void:
	var dialogue_path = DIALOGUE_PATH + s + "/dialogue"
	print("CHARACTER DIALOGUE FOLDER: ", dialogue_path)
	#for child in dialogue_list.get_children():
		#child.queue_free()
#
	#var dir = DirAccess.open(dialogue_path)
	#
	#if dir:
		#dir.list_dir_begin()
		#var file_name = dir.get_next()
#
		#while file_name != "":
			## Use begins_with (plural) to skip hidden system folders
			#if dir.current_is_dir() and not file_name.begins_with("."):
				#var character_scene = load(DIALOGUE_ITEM_PATH)
				#var instance = character_scene.instantiate()
				#
				## If your tscn's root is a Button, set the text
				#if instance is Button:
					#instance.text = file_name
				#
				#dialogue_list.add_child(instance)
				#instance.tooltip_text = file_name + "."
			#
			#file_name = dir.get_next()
			#
		#dir.list_dir_end()
	#else:
		#print("Error: Could not open path ", DIALOGUE_PATH)
