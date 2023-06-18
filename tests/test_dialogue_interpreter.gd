extends GutTest
  
# Example test which wont work
class TestPhrase:
  extends GutTest
  
  func test_variable_interpolation():
    set_double_strategy(DOUBLE_STRATEGY.SCRIPT_ONLY)
    var dialogue = DialogueData.new("#start\nJohn: Hey {wife}!")
    var interpreter_path = load("res://tests/test_interpreter.gd")
    var interpreter = partial_double(interpreter_path).new()
    interpreter.dialogue = dialogue
    add_child_autofree(interpreter)
    interpreter.run_block("start")
    assert_called(interpreter, '_say', ['John', 'Hey Mary!'])
    
