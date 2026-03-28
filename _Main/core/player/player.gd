extends CharacterBody3D
class_name Player

@export var move_speed = 5.0
@export var state_machine: Node

var interactables: Array[Node3D]

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is NPC:
		interactables.push_front(body)
		UiManager.emit_interact_show(body.interact_message)

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is NPC:
		interactables.erase(body)
		UiManager.emit_interact_hide()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and interactables.size() > 0:
		state_machine._on_state_switch("dialogue")
		interactables[0].start_dialog()
		print("SHOW DIALOG")
