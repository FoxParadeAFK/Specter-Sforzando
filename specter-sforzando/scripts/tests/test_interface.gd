extends Node2D

@export var interaction: Interaction

func _physics_process(_delta: float) -> void:
	var interact_input: bool = Input.is_action_just_pressed("ui_accept")
	
	if interact_input:
		interaction.trigger()
