extends GutTest

class TestPhrase:
  extends GutTest
  
  func make_interpreter(dialogue):
    set_double_strategy(DOUBLE_STRATEGY.SCRIPT_ONLY)
    var interpreter_path = load("res://tests/test_interpreter.gd")
    var interpreter = partial_double(interpreter_path).new()
    interpreter.dialogue = dialogue
    add_child_autofree(interpreter)  
    return interpreter
  
  func test_variable_interpolation():
    var dialogue = DialogueData.new("#start\nJohn: Hey {wife}!")
    var interpreter = make_interpreter(dialogue)
    interpreter.run_block("start")
    assert_called(interpreter, '_say', ['John', 'Hey Mary!'])
    
