class_name DialogueInteract extends Interact

# NOTE
# turned this into a singular dialogue option
# designed to make inline effects a little easier
# can be converted back into an array instead at anytime

@export var lines: String
var lines_length: int:
	get: return 1
var lines_counter: int:
	get: return min(lines_length, lines_counter)
	
func trigger() -> void:
	if lines_counter >= lines_length:
		Interface.trigger_dialogue.emit(" ")
		has_interacted.emit()
	else:
		Interface.trigger_dialogue.emit(lines)
		lines_counter += 1
