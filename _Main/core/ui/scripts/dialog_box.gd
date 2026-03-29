extends Control

const dialog_bubble = preload("res://_Main/core/ui/dialog_bubble.tscn")

@export var dialog_history: VBoxContainer
@export var player_dialog: PanelContainer
@export var npc_name: Label

func _ready() -> void:
	UiManager.dialog_started.connect(start_dialog)
	UiManager.dialog_finished.connect(end_dialog)
	UiManager.dialog_update.connect(dialog_update)

func add_message() -> void:
	pass

func start_dialog(n: String) -> void:
	npc_name.text = n
	self.show()
	for child in dialog_history.get_children():
		child.queue_free()

	var dialog = dialog_bubble.instantiate()
	dialog_history.add_child(dialog)

	dialog.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	dialog.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	dialog.text = UiManager.dialog_history[0]

func dialog_update() -> void:
	pass

func end_dialog() -> void:
	self.hide()
