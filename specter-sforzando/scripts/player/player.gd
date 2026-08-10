class_name Player extends CharacterBody2D

func transition_state(_transiting_state: State) -> void:
	if current_state != null:
		current_state.exit()
	
	current_state = _transiting_state
	print("Time %8s - State: %s" % [Time.get_ticks_msec(), current_state.animation_name])
	current_state.enter()

var current_state: State
var idle_state: IdleState
var move_state: MoveState

var horizontal_input: float

func _ready() -> void:
	idle_state = get_node_or_null("FiniteStateMachine/IdleState")
	idle_state.engage(self, "idle")
	move_state = get_node_or_null("FiniteStateMachine/MoveState")
	move_state.engage(self, "move")
	transition_state(idle_state)

func _physics_process(_delta: float) -> void:
	horizontal_input = Input.get_axis("ui_left", "ui_right")
	
	current_state.physics_update(_delta)
	move_and_slide()
