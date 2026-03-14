extends Control

@export var message: Label

func _ready() -> void:
	message.text = ""

func _process(_delta: float) -> void:
		message.text = UiManager.interaction_message
