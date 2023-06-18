extends DialogueInterpreter

@export_node_path("Label") var _name_label
@onready var name_label = get_node(_name_label) as Label

@export_node_path("Label") var _text_label
@onready var text_label = get_node(_text_label) as Label

@export var button_group: ButtonGroup
@onready var buttons = button_group.get_buttons() as Array[BaseButton]

var health = 100

func where_to_go():
  return 'wait'

func _ready():
  _hide_buttons()  
  await run_block("start")
  print("completed")

func _say(name_t: String, text: String):
  name_label.text = name_t
  text_label.text = text
  await get_tree().create_timer(1.5).timeout

func _ask(text: String, choices: Array[String]) -> int:
  _say(text, "")
  _show_buttons(choices)
  await button_group.pressed
  var pressed = button_group.get_pressed_button()
  var idx = choices.find(pressed.text)
  _hide_buttons()  
  return idx
  
func _show_buttons(choices: Array[String]):
  for i in buttons.size():
    if i == choices.size(): return
    buttons[i].visible = true
    buttons[i].text = choices[i]

func _hide_buttons():
  for button in buttons:
    button.visible = false
    button.button_pressed = false
