@tool
extends Control

const wearables_path = "res://_Main/assets/resources/armor/"
const inventory_item = preload("res://addons/character_visualizer/scenes/inventory_item.tscn")

@export var head: MeshInstance3D
@export var helm: MeshInstance3D
@export var torso: MeshInstance3D
@export var legs: MeshInstance3D
@export var head_naked: ArrayMesh
@export var torso_naked: ArrayMesh
@export var legs_naked: ArrayMesh

@export var armor_tab: Control
@export var clothing_tab: Control

var wearables: Array[Wearable] = []

func _ready() -> void:
	print("START EDITOR")
	load_wearables()
	populate_table()
	if Engine.is_editor_hint():
		var efs = EditorInterface.get_resource_filesystem()
		if not efs.filesystem_changed.is_connected(_on_filesystem_changed):
			efs.filesystem_changed.connect(_on_filesystem_changed)
	
	refresh_all()

# 2. This function triggers whenever any file in the project changes
func _on_filesystem_changed() -> void:
	print("Filesystem changed, updating Visualizer...")
	refresh_all()

func refresh_all() -> void:
	clear_tables()
	load_wearables()
	populate_table()

func clear_tables() -> void:
	if armor_tab:
		for child in armor_tab.get_children().filter(func(child): return child is InventoryItem):
			child.queue_free()
	if clothing_tab:
		for child in clothing_tab.get_children().filter(func(child): return child is InventoryItem):
			child.queue_free()
	wearables.clear()

func load_wearables() -> void:
	# Open the directory
	var dir = DirAccess.open(wearables_path)
	
	if dir:
		# Start iterating through the files
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			# Ignore directories and focus on resource files
			# Note: When exported, .tres files become .remap, 
			# but load() handles this automatically if you use the original path.
			if !dir.current_is_dir() and file_name.ends_with(".tres"):
				var full_path = wearables_path + file_name
				var resource = load(full_path)
				
				# Check if the resource is actually a Wearable
				if resource is Wearable:
					wearables.append(resource)
				else:
					push_warning("Found resource at " + full_path + " but it is not a Wearable.")
			
			file_name = dir.get_next()
		
		dir.list_dir_end()
	else:
		push_error("An error occurred when trying to access the path: " + wearables_path)

func populate_table() -> void:
	for e in wearables:
		var list_item = inventory_item.instantiate()
		list_item.change_name(e.name)
		list_item.assing_ref(e)
		list_item.equip_item.connect(equip_item)
		list_item.unequip_item.connect(unequip_item)
		if e is Clothing:
			clothing_tab.add_child(list_item)
		if e is Armor:
			armor_tab.add_child(list_item)

#func change_mesh(target: String, mesh: ArrayMesh) -> void:
func equip_item(item: Resource) -> void:
	if item is Wearable:
		print("NAME: ", item.name)
		# Get the array of keys and use the enum value as the index
		var slot_key = Wearable.SLOT.keys()[item.slot]
		match slot_key:
			"helm":
				helm.mesh = item.mesh
			"torso":
				torso.mesh = item.mesh
			"legs":
				legs.mesh = item.mesh
		print("SLOT: ", slot_key) 
		print("WEIGHT: ", item.weight)
	else:
		print("Resource is not a Wearable!")

func unequip_item(item: Resource) -> void:
	if item is Wearable:
		print("NAME: ", item.name)
		# Get the array of keys and use the enum value as the index
		var slot_key = Wearable.SLOT.keys()[item.slot]
		match slot_key:
			"helm":
				helm.mesh = null
			"torso":
				torso.mesh = torso_naked
			"legs":
				legs.mesh = legs_naked
		print("SLOT: ", slot_key) 
		print("WEIGHT: ", item.weight)
	else:
		print("Resource is not a Wearable!")
