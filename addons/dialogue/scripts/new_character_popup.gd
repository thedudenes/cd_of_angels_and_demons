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
	var character_name = text_input.text
	
	if character_name == "":
		print("MUST ENTER CHARACTER NAME")
		return 

	var new_character_directory = CHARACTER_PATH + character_name
	
	if DirAccess.dir_exists_absolute(new_character_directory):
		printerr("WARNING: CHARACTER ALREADY EXISTS")
	else:
		var error = DirAccess.make_dir_recursive_absolute(new_character_directory)
		
		if error == OK:
			print("CHARACTER CREATED AT: ", new_character_directory)
			
			# --- CREATE DIALOGUE RESOURCE ---
			# 1. Instance the custom resource
			var new_character = Character.new()
			
			#2. 
			new_character.character_name = character_name
			
			# 3. Define the full file path (e.g., res://.../Bob/Bob_data.tres)
			var file_path = new_character_directory + "/" + character_name + "_data.tres"
			
			# 4. Save it to the disk
			var save_err = ResourceSaver.save(new_character, file_path)
			
			if save_err == OK:
				print("SUCCESS: Resource created at ", file_path)
			else:
				print("ERROR: Could not save resource. Error code: ", save_err)
			# --------------------------------
			
			if Engine.is_editor_hint():
				EditorInterface.get_resource_filesystem().scan()
			
			hide()
		else:
			print("An error occurred while creating the folder. Error code: ", error)

func on_hide() -> void:
	print("HIDE")
	text_input.text = ""

func _on_button_pressed() -> void:
	show()
