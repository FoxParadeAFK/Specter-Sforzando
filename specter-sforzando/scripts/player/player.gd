class_name Player extends CharacterBody2D

func transition_state(_transiting_state: State) -> void:
	if _transiting_state == null: return
	if current_state != null: current_state.exit()
	
	current_state = _transiting_state
	print("Time %8s - State: %s" % [Time.get_ticks_msec(), current_state.animation_name])
	current_state.enter()

func get_state(_path: NodePath, _animation_name: String) -> State:
	var state: State = get_node_or_null(_path)
	if state != null: state.engage(self, _animation_name)
		
	return state

var current_state: State
var idle_state: IdleState
var move_state: MoveState
var in_air_state: InAirState
var jump_state: JumpState

enum { HORIZONTAL_VELOCITY = 70, VERTICAL_VELOCITY = 110 }
enum { MAXIMUM_JUMP_COUNT = 1 }
var jump_count: int:
	get: return min(jump_count, MAXIMUM_JUMP_COUNT)
func can_jump() -> bool: return jump_count > 0
var horizontal_input: float
var vertical_input: bool
var vertical_input_released: bool

var coyote_jump_timer: Timer
var vertical_input_timer: Timer

func _ready() -> void:
	idle_state = get_state("FiniteStateMachine/IdleState", "idle") as IdleState
	move_state = get_state("FiniteStateMachine/MoveState", "move") as MoveState
	in_air_state = get_state("FiniteStateMachine/InAirState", "in air") as InAirState
	jump_state = get_state("FiniteStateMachine/JumpState", "jump") as JumpState
	transition_state(idle_state)

	coyote_jump_timer = get_node_or_null("Timer/CoyoteJumpTimer")
	vertical_input_timer = get_node_or_null("Timer/VerticalInputTimer")

func _physics_process(_delta: float) -> void:
	horizontal_input = Input.get_axis("move_left", "move_right")
	hold_vertical_input(Input.is_action_just_pressed("jump"))
	vertical_input_released = Input.is_action_just_released("jump")
	
	current_state.physics_update(_delta)
	move_and_slide()
	
func hold_vertical_input(_vertical_input: bool) -> void:
	if not _vertical_input or vertical_input_timer.time_left != 0: return
	
	vertical_input_timer.start()
	vertical_input = true
