@tool
extends Panel

const CHARACTER_PATH = "res://_Main/dialogue/"

@export var text_input: TextEdit

func _ready() -> void:
	hidden.connect(on_hide)
	hide()

func _on_cancel_pressed() -> void:
	hide()

func _on_create_new_character_pressed() -> void:
	# 1. Sanitize the input to prevent illegal Windows paths (no trailing spaces or dots)
	var character_name = text_input.text.strip_edges().replace(".", "")
	
	if character_name == "":
		printerr("WARNING: MUST ENTER CHARACTER NAME")
		return 

	var new_character_directory = CHARACTER_PATH + character_name
	
	if DirAccess.dir_exists_absolute(new_character_directory):
		printerr("WARNING: CHARACTER ALREADY EXISTS")
	else:
		var error = DirAccess.make_dir_recursive_absolute(new_character_directory)
		
		if error == OK:
			# --- CREATE DIALOGUE RESOURCE ---
			var new_character = Character.new()
			new_character.name = character_name
			
			var file_path = new_character_directory + "/" + character_name + ".tres"
			var save_err = ResourceSaver.save(new_character, file_path)
			
			# --- CREATE THE "dialogue" SUBFOLDER ---
			var dialogue_folder_path = new_character_directory + "/dialogue"
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
			
			hide()
		else:
			printerr("An error occurred while creating the folder. Error code: ", error)

func on_hide() -> void:
	text_input.text = ""

func _on_button_pressed() -> void:
	show()
