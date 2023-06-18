extends GutTest

class TestComment:
  extends GutTest
  
  func test_skipped():
    var d = DialogueData.new("#start\n// comment")
    assert_eq_deep(
      d.parse()["start"],
      []
    )   

class TestPhrase:
  extends GutTest
  
  func test_oneline():
    var d = DialogueData.new("#start\nJohn: Hey!")
    assert_eq_deep(
      d.parse()["start"],
      [{ "type": "phrase", "name": "John", "text": "Hey!" }]
    )
    
  func test_multiline():
    var d = DialogueData.new("#start\nJohn:\nHey!\nAre we gonna dance?")
    assert_eq_deep(
      d.parse()["start"],
      [{ "type": "phrase", "name": "John", "text": "Hey!\nAre we gonna dance?" }]
    )    
    
  func test_multiline_with_next():
    var d = DialogueData.new("#start\nJohn: \nHey!\nAre we gonna dance?\n$ pause(1000)")
    assert_eq_deep(
      d.parse()["start"],
      [{ "type": "phrase", "name": "John", "text": "Hey!\nAre we gonna dance?" },
       { "type": "code", "code": "pause(1000)"}]
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

class TestQuestion:
  extends GutTest
  
  func test_is_parsed():
    var d = DialogueData.new("#start\n=? What?\n=<block1> Huh\n=<block2> Meh")
    assert_eq_deep(
      d.parse()["start"],
      [{ "type": "question", "text": "What?",
         "choices": [
          { "block": "block1", "text": "Huh" },
          { "block": "block2", "text": "Meh" }
        ] }]
    )
    
  func test_special_chars():
    var d = DialogueData.new("#start\n=? What?\n=<block1> H>u>h")
    assert_eq_deep(
      d.parse()["start"],
      [{ "type": "question", "text": "What?",
         "choices": [{ "block": "block1", "text": "H>u>h" }] }]
    )  

class TestSwitch:
  extends GutTest
  
  func test_is_parsed():
    var d = DialogueData.new("#start\n$? state()\n=<block1> 'start'\n=<block2> 'finish'")
    assert_eq_deep(
      d.parse()["start"],
      [{ "type": "switch", 
         "text": "state()",
         "fallback": "",
         "choices": [
          { "block": "block1", "text": "'start'" },
          { "block": "block2", "text": "'finish'" }
        ] }]
    )
    
  func test_special_chars():
    var d = DialogueData.new("#start\n$? state()\n=<block1> 'st>art'")
    assert_eq_deep(
      d.parse()["start"][0]["choices"],
      [{ "block": "block1", "text": "'st>art'" }]
    )
