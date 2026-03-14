extends NPC

const message = "e to interact"

func _on_interaction_area_body_entered(body: Node3D) -> void:
	print("PLAYER ENTERED")
	if body is Player:
		UiManager.interaction_message = message

func _on_interaction_area_body_exited(body: Node3D) -> void:
	print("PLAYER EXITED")
	if body is Player:
		UiManager.interaction_message = ""
