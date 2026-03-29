extends PlayerState

func enter() -> void:
	player.velocity = Vector3.ZERO
	connect_signals()
	if animations:
		animations.play("animation_library_one/Sword_Attack")

func animation_finished(s:String) -> void:
	if s == "animation_library_one/Sword_Attack":
		switch_state_emit("melee_idle")
