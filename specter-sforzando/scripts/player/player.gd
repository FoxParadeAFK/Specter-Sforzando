class_name Player extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * _delta
		
	var horizontal_input: float = Input.get_axis("ui_left", "ui_right")
	
	velocity.x = horizontal_input * 50
	move_and_slide()
