class_name MoveState extends State

func enter() -> void:
	player.jump_count = player.MAXIMUM_JUMP_COUNT

func physics_update(_delta: float) -> void: 
	player.velocity.x = player.horizontal_input * player.HORIZONTAL_VELOCITY

	if not player.is_on_floor(): player.transition_state(player.in_air_state)
	elif player.horizontal_input == 0: player.transition_state(player.idle_state)
	elif player.vertical_input and player.can_jump(): player.transition_state(player.jump_state)

func exit() -> void: pass
