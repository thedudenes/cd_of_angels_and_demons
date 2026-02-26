extends PlayerState

func enter() -> void:
	connect_signals()
	if animations:
		animations.play("universal_anim_library/Roll")


func animation_finished(_ss:String) -> void:
	if _ss == "universal_anim_library/Roll":
		switch_state_emit("idle")
