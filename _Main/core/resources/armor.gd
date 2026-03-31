extends Resource
class_name Armor

enum ARMOR_TYPE {
	hand,
	arms,
	torso,
	legs
}

@export var mesh: Resource
@export var physical_resistance: float
@export var armor_type: ARMOR_TYPE
