@tool
extends Panel

const CHARACTER_PATH = "res://_Main/dialogue/"

@export var text_input: TextEdit
@export var dialogue: VBoxContainer

var current_character: String

func _ready() -> void:
	hidden.connect(on_hide)
	hide()

func _on_cancel_pressed() -> void:
	hide()

func _on_create_dialogue_pressed() -> void:
	# 1. Sanitize the input
	var dialogue_name = text_input.text.strip_edges().replace(".", "_") # Replace dots with underscores to keep filename valid
	
	if current_character == "":
		printerr("ERROR: SELECT A CHARACTER FIRST")
		return

	if dialogue_name == "":
		printerr("WARNING: MUST ENTER DIALOGUE NAME")
		return 
	
	var new_dialogue_directory = CHARACTER_PATH + current_character + "/dialogue/"
	
	# 2. Ensure the directory exists before attempting to save
	if not DirAccess.dir_exists_absolute(new_dialogue_directory):
		var error = DirAccess.make_dir_recursive_absolute(new_dialogue_directory)
		if error != OK:
			printerr("CRITICAL: Could not create folder. Error code: ", error)
			return # Stop here if we can't create the path
		print("Created new directory: ", new_dialogue_directory)

	# 3. Create the file now that we are sure the path exists
	create_file(dialogue_name, new_dialogue_directory)
	dialogue.refresh_list()
	hide()

func create_file(dialogue_name: String, new_dialogue_directory: String) -> void:
	var new_dialogue = Dialogue.new()
	new_dialogue.title = dialogue_name
	
	var file_path = new_dialogue_directory + dialogue_name + ".tres"
	
	# Check if file already exists to prevent accidental overwriting
	if FileAccess.file_exists(file_path):
		printerr("ERROR: Dialogue file already exists at: ", file_path)
		return

	var save_err = ResourceSaver.save(new_dialogue, file_path)
	
	if save_err == OK:
		print("SUCCESS: Resource created at ", file_path)
		# Force the editor to see the new file immediately
		if Engine.is_editor_hint():
			EditorInterface.get_resource_filesystem().scan()
	else:
		printerr("ERROR: Could not save resource. Error code: ", save_err)

func on_hide() -> void:
	text_input.text = ""
	# Depending on your UI, you might want to keep the character selected 
	# until a new one is clicked, but resetting here matches your original code.
	current_character = ""
