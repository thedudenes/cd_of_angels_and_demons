extends Resource
class_name Armor

enum ARMOR_TYPE {
	head,
	torso,
	legs
}

@export var mesh: Resource
@export var name: String
@export var armor_type: ARMOR_TYPE
@export var weight: float
@export_group("resistances")
@export var physical_resistance: float
@export var magic_resistance: float
@export var fire_resistance: float
@export var freeze_resistance: float
@export var poison_resistance: float
