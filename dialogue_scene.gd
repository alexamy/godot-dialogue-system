extends DialogueInterpreter

@export_node_path("Label") var _name_label
@onready var name_label = get_node(_name_label) as Label

@export_node_path("Label") var _text_label
@onready var text_label = get_node(_text_label) as Label

@export var button_group: ButtonGroup
@onready var buttons = button_group.get_buttons() as Array[BaseButton]

func _ready():
  _hide_buttons()  
  await run("start")

func _say(name_t: String, text: String):
  name_label.text = name_t
  text_label.text = text

func _ask(text: String, options: Array[String]) -> int:
  _say(text, "")
  _show_buttons(options)
  await button_group.pressed
  _hide_buttons()  
  var pressed = button_group.get_pressed_button()
  var idx = options.find(pressed.text)
  return idx
  
func _show_buttons(options: Array[String]):
  for i in buttons.size():
    if i == options.size(): return
    buttons[i].visible = true
    buttons[i].text = options[i]

func _hide_buttons():
  for button in buttons:
    button.visible = false
