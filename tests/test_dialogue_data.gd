extends GutTest

class TestPhrase:
  extends GutTest
  
  func test_oneline():
    var d = DialogueData.new("#start\nJohn: Hey!")
    assert_eq_deep(
      d.parse()["start"],
      [{ "type": "phrase", "name": "John", "text": "Hey!" }]
    )
    
  func test_multiline():
    var d = DialogueData.new("#start\nJohn: \nHey!\nAre we gonna dance?")
    assert_eq_deep(
      d.parse()["start"],
      [{ "type": "phrase", "name": "John", "text": "Hey!\nAre we gonna dance?" }]
    )    

  func test_special_symbol():
    var d = DialogueData.new("#start\n\\$John: Hey!")
    assert_eq_deep(
      d.parse()["start"],
      [{ "type": "phrase", "name": "$John", "text": "Hey!" }]
    )

  func test_special_symbol_slash():
    var d = DialogueData.new("#start\n\\\\John: Hey!")
    assert_eq_deep(
      d.parse()["start"],
      [{ "type": "phrase", "name": "\\John", "text": "Hey!" }]
    )
