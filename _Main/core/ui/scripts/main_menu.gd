extends Control

const HUB = "res://_Main/levels/player_hub/player_hub.tscn"

func _on_new_game_pressed() -> void:
	GameManager.set_state(GameManager.STATES.RUN)
	GameManager.emit_change_scene(HUB)

func _on_quit_pressed() -> void:
	get_tree().quit()
