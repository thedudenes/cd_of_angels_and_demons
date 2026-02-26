extends PlayerState


func enter() -> void:
	player.velocity = Vector3.ZERO
	connect_signals()
	if animations:
		animations.play("universal_anim_library/Sword_Attack")


func animation_finished(_ss:String) -> void:
	if _ss == "universal_anim_library/Sword_Attack":
		switch_state_emit("melee_idle")
