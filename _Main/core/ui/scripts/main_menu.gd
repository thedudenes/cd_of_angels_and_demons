extends Control

const HUD = "res://_Main/levels/player_hud/player_hud.tscn"

func _on_new_game_pressed() -> void:
	GameManager.set_state(GameManager.STATES.RUN)
	GameManager.emit_change_scene(HUD)

func _on_quit_pressed() -> void:
	get_tree().quit()
