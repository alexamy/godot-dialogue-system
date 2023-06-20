@tool
extends EditorPlugin

var dock: Control 

func _enter_tree():
  dock = preload("res://addons/godialosys/dialogue_editor.tscn").instantiate()
  add_control_to_bottom_panel(dock, "Godialosys")


func _exit_tree():
  remove_control_from_bottom_panel(dock)
  dock.queue_free()
