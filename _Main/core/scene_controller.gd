extends Node

const TITLE_SCREEN = "res://_Main/levels/title/title.tscn"

var current_level: Level

func _ready() -> void:
	# CONNECT SIGNALS
	GameManager.change_scene.connect(switch_current_level)
	
	# WINDOW MODE AND SIZE:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	DisplayServer.window_set_size(Vector2i(960, 540))
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()
	DisplayServer.window_set_position(screen_size / 2 - window_size / 2)

	# LOAD INITIAL LEVEL:
	switch_current_level(TITLE_SCREEN)

func switch_current_level(s: String) -> void:
	# 1. Start the background loading request
	ResourceLoader.load_threaded_request(s)
	
	var check_and_instantiate = func():
		# This loop waits until the resource is fully loaded in the background
		var status = ResourceLoader.load_threaded_get_status(s)
		
		while status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			# Wait for one frame to keep the game responsive
			await get_tree().process_frame
			status = ResourceLoader.load_threaded_get_status(s)
		
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			var new_scene_res = ResourceLoader.load_threaded_get(s)
			current_level = new_scene_res.instantiate()
			add_child(current_level)
		else:
			printerr("Error loading level: ", s)

	# 2. Logic to wait for the old level
	if current_level == null:
		check_and_instantiate.call()
	else:
		current_level.tree_exited.connect(check_and_instantiate, CONNECT_ONE_SHOT)
		current_level.queue_free()
