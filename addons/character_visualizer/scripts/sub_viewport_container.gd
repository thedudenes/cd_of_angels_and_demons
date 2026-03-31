@tool
extends SubViewportContainer # Change to TextureRect if you used that instead!

# Drag your Character/Mesh node into this slot in the inspector
@export var character_to_rotate: Node3D 
@export var rotation_sensitivity: float = 0.3

var is_dragging: bool = false

func _gui_input(event: InputEvent) -> void:
	# Check for left mouse click
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = event.pressed
			
			# This stops the click from "clicking through" to editor elements behind it
			accept_event() 

	# Check for mouse movement while dragging
	if event is InputEventMouseMotion and is_dragging:
		if character_to_rotate:
			# Rotates the character horizontally based on side-to-side mouse movement
			var y_rotation = deg_to_rad(-event.relative.x * rotation_sensitivity)
			character_to_rotate.rotate_y(y_rotation)
			
			accept_event()
