@tool
extends Control

signal refresh

const inventory_item = preload("res://addons/character_visualizer/scenes/inventory_item.tscn")

@export_group("Mesh Slots")
@export var head: MeshInstance3D
@export var torso: MeshInstance3D
@export var legs: MeshInstance3D
@export var layered: MeshInstance3D
@export_group("Clothing")
@export var head_clothing: Clothing
@export var torso_clothing: Clothing
@export var legs_clothing: Clothing
@export var layered_clothing: Clothing
@export_group("Armor")
@export var head_armor: Armor
@export var torso_armor: Armor
@export var legs_armor: Armor

func _ready() -> void:
	if Engine.is_editor_hint():
		var efs = EditorInterface.get_resource_filesystem()
		if not efs.filesystem_changed.is_connected(_on_filesystem_changed):
			efs.filesystem_changed.connect(_on_filesystem_changed)

func _on_filesystem_changed() -> void:
	print("Filesystem changed, updating Visualizer...")
	refresh.emit()

func equip_head(r: Wearable) -> void:
	if r is Clothing:
		if head_armor == null:
			head.mesh = r.mesh
		head_clothing = r
	if r is Armor:
		head.mesh = r.mesh
		head_armor = r

func unequip_head(r: Wearable) -> void:
	if r is Clothing:
		if head_armor == null:
			head.mesh = null
		head_clothing = null
	if r is Armor:
		if head_clothing == null:
			head.mesh = null
		else:
			head.mesh = head_clothing.mesh
		head_armor = null

func equip_torso(r: Wearable) -> void:
	if r is Clothing:
		if torso_armor == null:
			torso.mesh = r.mesh
		torso_clothing = r
	if r is Armor:
		torso.mesh = r.mesh
		torso_armor = r

func unequip_torso(r: Wearable) -> void:
	if r is Clothing:
		if torso_armor == null:
			torso.mesh = null
		torso_clothing = null
	if r is Armor:
		if torso_clothing == null:
			torso.mesh = null
		else:
			torso.mesh = torso_clothing.mesh
		torso_armor = null

func equip_legs(r: Wearable) -> void:
	if r is Clothing:
		if legs_armor == null:
			legs.mesh = r.mesh
		legs_clothing = r
	if r is Armor:
		legs.mesh = r.mesh
		legs_armor = r

func unequip_legs(r: Wearable) -> void:
	if r is Clothing:
		if legs_armor == null:
			legs.mesh = null
		legs_clothing = null
	if r is Armor:
		if legs_clothing == null:
			legs.mesh = null
		else:
			legs.mesh = legs_clothing.mesh
		legs_armor = null

func equip_layered(r: Wearable) -> void:
	layered.mesh = r.mesh
	layered_clothing

func unequip_layered(r: Wearable) -> void:
	layered.mesh = null
	layered_clothing = null

# cada tab envia el path de items y la lista a ser llenada, se instancian los botones,
# se le asigna un resource a cada uno y se conecta por señal pressed a la funcion
# equipar item
func populate_table(path: String, list: VBoxContainer, items: Array[InventoryItem]) -> void:
	var dir = DirAccess.open(path)
	if dir:
		# Start iterating through the files
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".tres"):
				#load item resource
				var resource_path: String = path + file_name
				var resource = load(path + file_name)
				#load list_item scene
				var list_item =  inventory_item.instantiate()
				if resource is Item:
					list_item.write_res(resource)
					list_item.write_name(resource.name)
					items.push_front(list_item)
					list.add_child(list_item)
				else:
					push_warning("Found resource at " + resource_path + " but it is not an Item.")
			
			file_name = dir.get_next()
		
		dir.list_dir_end()
	else:
		push_error("An error occurred when trying to access the path: " + dir)
