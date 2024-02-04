extends Resource

class_name DialogueQuestionOption

@export_multiline var text: String
@export var path: NodePath

func _ready(p_text = "", p_path = ""):
	text = p_text
	path = p_path
