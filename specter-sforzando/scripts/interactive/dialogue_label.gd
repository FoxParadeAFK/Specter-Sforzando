class_name DialogueLabel extends Label

func _ready() -> void:
	Interface.trigger_dialogue.connect(read_lines)

func read_lines(_line: String) -> void:
	text = _line
