extends GutTest

# Example test which wont work
class Phrase:
  extends GutTest
  
  func test_variable_interpolation():
    var dialogue = DialogueData.new("#start\nJohn: Hey {you}!")
    
    set_double_strategy(DOUBLE_STRATEGY.SCRIPT_ONLY)
    var interpreter = double(DialogueInterpreter).new()
    interpreter.dialogue = dialogue
    
    interpreter.run_block("start")
    assert_called(interpreter, '_say', ['John', 'Hey {you}!'])
    
