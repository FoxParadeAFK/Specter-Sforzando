class_name Interaction extends Resource

signal completed_manuscript

func increment_manuscript() -> void:
	manuscript_counter += 1
	trigger()

@export var manuscript: Array[Interact]:
	get: return manuscript
	set(_manuscript):
		manuscript = _manuscript
		for _manuscript_counter in range(manuscript_length):
			manuscript[_manuscript_counter].has_interacted.connect(increment_manuscript)
			
var manuscript_length: int:
	get: return len(manuscript)
var manuscript_counter: int:
	get: return min(manuscript_counter, manuscript_length)

func trigger() -> void:
	if manuscript_counter >= manuscript_length:
		completed_manuscript.emit()
	else:
		manuscript[manuscript_counter].trigger()
