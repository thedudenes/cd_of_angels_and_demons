@tool
extends Button
class_name InventoryItem

signal equip_item(item: Resource, b: InventoryItem)
signal unequip_item(item: Resource, b: InventoryItem)

@export var item_name: Label
@export var level: Label
@export var dmg: Label
@export var weight: Label
@export var equiped_color: Color
@export var unequiped_color: Color

var item_ref: Resource
var equiped: bool = false

func change_name(s: String) -> void:
	item_name.text = s

func change_level(s: String) -> void:
	level.text = s

func change_dmg(s: String) -> void:
	dmg.text = s

func change_weight(s: String) -> void:
	weight.text = s

func assing_ref(r: Resource) -> void:
	item_ref = r

func _pressed() -> void:
	if equiped:
		unequip_item.emit(item_ref, self)
		unselect()
	else:
		equip_item.emit(item_ref, self)
		select()
		
	equiped = !equiped

func unselect() -> void:
	set_button_color(unequiped_color) 
	equiped = !equiped

func select() -> void:
	set_button_color(equiped_color)

func set_button_color(new_color: Color) -> void:
	# 1. Get the current stylebox or create a new one if it doesn't exist
	var stylebox = get_theme_stylebox("normal").duplicate()
	
	# 2. If it's a flat stylebox, we can change the bg_color
	if stylebox is StyleBoxFlat:
		stylebox.bg_color = new_color
		
		# 3. Apply it back to the button's theme overrides
		add_theme_stylebox_override("normal", stylebox)
		add_theme_stylebox_override("hover", stylebox) # Optional: keep color while hovering
		add_theme_stylebox_override("pressed", stylebox)
