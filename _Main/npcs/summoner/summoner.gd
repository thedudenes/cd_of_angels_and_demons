extends NPC

@export var animations: AnimationPlayer

#@export var look_at: LookAtModifier3D

const message = "e to interact"

func _ready() -> void:
	animations.play("animation_library_two/Idle_FoldArms")

func start_dialog() -> void:
	animations.play("animation_library_one/Idle_Talking")
	UiManager.emit_dialog_started("Summoner", "Hail, wanderer. I be the Summoner, bound by oath and ember. Does thy heart yearn for a comrade in this hollow silence? Or art thou moved by grace to lend thy strength unto a soul in direst need?")
