extends PlayerState

var input_dir: Vector2

func enter() -> void:
	initialize()
	if animations:
		animations.play("animation_library_one/Sword_Idle")
	
func update(_delta: float) -> void:
	# move player velocity towards zero
	player.velocity.x = move_toward(player.velocity.x, 0, 0.8)
	player.velocity.z = move_toward(player.velocity.z, 0, 0.8)
	
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	if input_dir.length() > 0:
		switch_state_emit("walk")

func input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("melee_attack"):
		switch_state_emit("melee_attack")

func animation_finished(s:String) -> void:
	if s == "animation_library_one/Sword_Idle":
		switch_state_emit("idle")
