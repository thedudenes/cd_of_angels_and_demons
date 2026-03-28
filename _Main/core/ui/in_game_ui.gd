extends Control

@export var interaction_message: Control
@export var dialog_menu: Control

func _ready() -> void:
	UiManager.dialog_started.connect(dialog_started)
	hide_all()

func hide_all() -> void:
	interaction_message.hide()
	dialog_menu.hide()

func dialog_started(_n: String) -> void:
	interaction_message.hide()
