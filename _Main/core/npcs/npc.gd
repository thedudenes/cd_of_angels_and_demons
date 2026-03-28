extends CharacterBody3D
class_name NPC

var interact_message: String = "e to interact"
var player: Player

func start_dialog() -> void:
	pass

#func _on_interaction_area_body_entered(body: Node3D) -> void:
	#if body is Player:
		#body.add_interactable(get_parent())
		#UiManager.interaction_message = interact_message
#
#func _on_interaction_area_body_exited(body: Node3D) -> void:
	#if body is Player:
		#UiManager.interaction_message = ""
