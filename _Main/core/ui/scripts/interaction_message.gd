extends Control

@export var message: Label

func _ready() -> void:
	UiManager.interact_show.connect(show_self)
	UiManager.interact_hide.connect(hide_self)
	message.text = ""

func _process(_delta: float) -> void:
	#message.text = UiManager.interaction_message
	pass

func show_self() -> void:
	show()
	message.text = UiManager.interaction_message

func hide_self() -> void:
	hide()
	message.text = ""
