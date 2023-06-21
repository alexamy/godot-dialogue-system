@tool

extends VBoxContainer

class_name NodePhraseLine

func as_object():
  return {
    "type": "phrase",
    "name": %Name.text,
    "text": %Text.text,
  }

