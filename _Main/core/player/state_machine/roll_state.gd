extends PlayerState

func enter() -> void:
	connect_signals()
	if animations:
		animations.play("animation_library_one/Roll")
		player.velocity = player.velocity * 2
	#invencible

func update(_delta: float) -> void:
	# move player velocity towards zero
	player.velocity.x = move_toward(player.velocity.x, 0, 0.1)
	player.velocity.z = move_toward(player.velocity.z, 0, 0.1)

func animation_finished(s:String) -> void:
	if s == "animation_library_one/Roll":
		player.velocity = Vector3.ZERO
		switch_state_emit("idle")
	#active vencible
