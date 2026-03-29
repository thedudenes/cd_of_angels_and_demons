extends CanvasLayer

@export var main_menu: Control
@export var in_game_ui: Control

func _ready() -> void:
	GameManager.state_changed.connect(handle_state_changed)
	main_menu.show()
	in_game_ui.hide()

func handle_state_changed(new_state: GameManager.STATES, _old_state: GameManager.STATES) -> void:
	print("UPDATE UI ON GAME STATE CHANGE: ",new_state)
	match new_state:
		GameManager.STATES.MAIN_MENU:
			pass
		GameManager.STATES.RUN:
			main_menu.hide()
			in_game_ui.show()
