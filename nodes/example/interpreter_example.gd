extends DialogueInterpreterBase

@export var name_label: Label
@export var text_label: Label

@export var choices_button_group: ButtonGroup
@onready var buttons = choices_button_group.get_buttons() as Array[BaseButton]

func _ready():
	_hide_buttons()

func say(name_t, text):
	name_label.text = name_t
	text_label.text = text
	await get_tree().create_timer(1.5).timeout

func ask(text, choices) -> int:
	say(text, "")
	_show_buttons(choices)
	await choices_button_group.pressed
	var pressed = choices_button_group.get_pressed_button()
	var idx = choices.find(pressed.text)
	_hide_buttons()
	return idx

# Can not use Array[String]. Bug?
func _show_buttons(choices: Array):
	for i in buttons.size():
		if i == choices.size(): return
		buttons[i].visible = true
		buttons[i].text = choices[i]

func _hide_buttons():
	for button in buttons:
		button.visible = false
		button.button_pressed = false
