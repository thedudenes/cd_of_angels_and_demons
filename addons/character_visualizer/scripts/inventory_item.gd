@tool
class_name InventoryItem extends Button

signal equip_item(item: Resource, b: InventoryItem)
signal unequip_item(item: Resource, b: InventoryItem)

@export var item_name: Label
@export var level: Label
@export var dmg: Label
@export var weight: Label
@export var equiped_color: Color
@export var unequiped_color: Color

var item_res: Resource
var selected: bool = false

func write_name(s: String) -> void:
	item_name.text = s

func read_name() -> String:
	return item_name.text

func write_level(s: String) -> void:
	level.text = s

func read_level() -> String:
	return level.text

func write_dmg(s: String) -> void:
	dmg.text = s

func read_dmg() -> String:
	return dmg.text

func write_weight(s: String) -> void:
	weight.text = s

func read_weight() -> String:
	return weight.text

func write_res(r: Resource) -> void:
	item_res = r

func read_res() -> Resource:
	return item_res

func write_selected(b: bool) -> void:
	selected = b

func read_selected() -> bool:
	return selected

func toggle_select() -> void:
	write_selected(!selected)
	if selected:
		set_button_color(equiped_color)
	else:
		set_button_color(unequiped_color) 

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
