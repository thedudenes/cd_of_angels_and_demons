extends Node

signal dialog_started(n: String)
signal dialog_update
signal dialog_finished

signal interact_show
signal interact_hide

var dialog_history: Array[String]
var interaction_message = ""

func emit_dialog_started(n: String, m: String):
	dialog_history = []
	dialog_history.push_front(m)
	dialog_started.emit(n)

func emit_dialog_update(m: String):
	dialog_history.push_front(m)
	dialog_update.emit()

func emit_dialog_finished():
	dialog_finished.emit()

func emit_interact_show(m: String):
	interaction_message = m
	interact_show.emit()

func emit_interact_hide():
	interact_hide.emit()
