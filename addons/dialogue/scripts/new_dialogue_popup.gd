@tool
extends Panel

const CHARACTER_PATH = "res://_Main/dialogue/"

@export var text_input: TextEdit

var current_character: String

func _ready() -> void:
	hidden.connect(on_hide)
	hide()

func _on_cancel_pressed() -> void:
	hide()

func _on_create_dialogue_pressed() -> void:
	# 1. Sanitize the input to prevent illegal Windows paths (no trailing spaces or dots)
	var dialogue_name = text_input.text.strip_edges().replace(".", "")
	
	if current_character == "":
		print("SELECT A CHARACTER")
		hide()
		return

	if dialogue_name == "":
		printerr("WARNING: MUST ENTER CHARACTER NAME")
		return 
	
	var new_dialogue_directory = CHARACTER_PATH + current_character + "/dialogue/"
	print("CHARACTER DIALOGUE DIRECTORY: ",new_dialogue_directory)
	
	if DirAccess.dir_exists_absolute(new_dialogue_directory):
		print("FOLDER EXISTS")
		create_file(dialogue_name, new_dialogue_directory)
	else:
		print("FOLDER DOESNT EXISTS")
		var error = DirAccess.make_dir_recursive_absolute(new_dialogue_directory)
		create_file(dialogue_name, new_dialogue_directory)
		if error == OK:
			# --- CREATE DIALOGUE RESOURCE ---
			hide()
		else:
			printerr("An error occurred while creating the folder. Error code: ", error)

func create_file(dialogue_name: String, new_dialogue_directory: String) -> void:
	var new_dialogue = Dialogue.new()
	new_dialogue.title = dialogue_name
	
	var file_path = new_dialogue_directory + dialogue_name + "_data.tres"
	var save_err = ResourceSaver.save(new_dialogue, file_path)
	
	# --- CREATE THE "dialogue" SUBFOLDER ---
	var dialogue_folder_path = new_dialogue_directory + "/dialogue"
	var dir_err = DirAccess.make_dir_absolute(dialogue_folder_path)
	
	if dir_err == OK:
		print("Subfolder 'dialogue' created.")
	else:
		printerr("Failed to create subfolder. Error: ", dir_err)
	
	if save_err == OK:
		print("SUCCESS: Resource created at ", file_path)
	else:
		printerr("ERROR: Could not save resource. Error code: ", save_err)
	
	if Engine.is_editor_hint():
		EditorInterface.get_resource_filesystem().scan()

func on_hide() -> void:
	text_input.text = ""
	current_character = ""
