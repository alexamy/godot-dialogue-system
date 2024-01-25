extends Resource

class_name DialogueQuestionOption

@export_multiline var option: String
@export var path: NodePath

func _ready(p_option = "", p_path = ""):
	option = p_option
	path = p_path
