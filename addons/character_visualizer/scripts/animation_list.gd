@tool
extends VBoxContainer

const ANIMATION_ITEM = preload("res://addons/character_visualizer/scenes/animation_item.tscn")

@export var animations: AnimationPlayer

func _ready() -> void:
	if not animations:
		push_warning("Character Visualizer: No AnimationPlayer assigned.")
		return
	var anim_list = animations.get_animation_list()
	populate_animation_list(anim_list)

func populate_animation_list(anim_list: Array[String]) -> void:
	for anim_name in anim_list:
		var item = ANIMATION_ITEM.instantiate()
		add_child(item)
		item.set_anim_name(anim_name)
		item.text = anim_name.get_file()
		item.play_animation.connect(play_animation)

func play_animation(anim_name: String) -> void:
	#print("PLAY: ", anim_name)
	if animations.has_animation(anim_name):
		animations.play(anim_name)
