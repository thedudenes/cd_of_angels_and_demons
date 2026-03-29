extends PlayerState

func enter() -> void:
	connect_signals()
	if animations:
		animations.play("animation_library_one/Idle_Talking")

func animation_finished(_s:String) -> void:
	pass
