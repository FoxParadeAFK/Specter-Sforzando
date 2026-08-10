class_name IdleState extends State

func enter() -> void:
	player.velocity.x = 0

func physics_update(_delta: float) -> void:
	if not player.is_on_floor(): player.transition_state(player.in_air_state)
	elif player.horizontal_input != 0: player.transition_state(player.move_state)
	elif player.vertical_input and player.is_on_floor(): player.transition_state(player.jump_state)

func exit() -> void: pass
