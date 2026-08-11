class_name InAirState extends State

const HOVER_VELOCITY_THRESHOLD: int = 30
const HOVER_VELOCITY_PERCENTAGE: float = 0.3

func enter() -> void:
	if player.jump_count == player.MAXIMUM_JUMP_COUNT:
		player.coyote_jump_timer.start()

func physics_update(_delta: float) -> void:
	var gravity: Vector2 = player.get_gravity()
	if sign(player.velocity.y) == -1 and player.velocity.y >= -HOVER_VELOCITY_THRESHOLD:
		gravity *= HOVER_VELOCITY_PERCENTAGE
	elif sign(player.velocity.y) == -1 and player.vertical_input_released:
		player.velocity *= 0.65
		
	player.velocity += gravity * _delta
	player.velocity.x = player.horizontal_input * player.HORIZONTAL_VELOCITY
	
	if player.is_on_floor() and player.horizontal_input != 0: player.transition_state(player.move_state)
	elif player.is_on_floor() and player.horizontal_input == 0: player.transition_state(player.idle_state)
	elif player.vertical_input and player.coyote_jump_timer.time_left != 0: player.transition_state(player.jump_state)

func exit() -> void:
	player.coyote_jump_timer.stop()
