extends Resource
class_name Wearable

enum SLOT {
	head,
	helm,
	torso,
	legs,
	ring,
	necklace,
	belt
}

@export var mesh: Resource
@export var name: String
@export var slot: SLOT
@export var weight: float
