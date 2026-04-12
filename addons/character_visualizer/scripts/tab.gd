@tool
extends Control

@export var path: String
@export var main: Control
@export var list: VBoxContainer

var items: Array[InventoryItem]
var equiped_items: Array[InventoryItem]

func _ready() -> void:
	main.refresh.connect(populate_table)

func populate_table() -> void:
	for e in items:
		e.queue_free()
	items.clear()
	main.populate_table(path, list, items)
	for e in items:
		e.pressed.connect(equip_item.bind(e))
		e.set_button_color(e.unequiped_color)

func equip_item(b: InventoryItem) -> void:
	var res = b.read_res()
	var slot_key = Wearable.SLOT.keys()[res.slot]
	if b.read_selected():
		match slot_key:
			"head": main.unequip_head(res)
			"torso": main.unequip_torso(res)
			"legs": main.unequip_legs(res)
			"layered": main.unequip_layered(res)
	else:
		match slot_key:
			"head": main.equip_head(res)
			"torso": main.equip_torso(res)
			"legs": main.equip_legs(res)
			"layered": main.equip_layered(res)
	b.toggle_select()
