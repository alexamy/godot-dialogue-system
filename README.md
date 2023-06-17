# Dialogue system

## Quick start
1. Create `DialogueData` resource and write a dialogue.
2. Create script, which extends `DialogueInterpreter`, and implement your custom `_ask` and `_say` methods.
3. Call `run()` method of interpreter with dialogue block key.

Example of dialogue resource is `dialogue1.tres`, and custom interpeter is `dialogue_scene.gd`.

## Syntax
### Phrase
Every line without special symbols in the start consdired as a phrase.
It has two parts - name before `:` and phrase text afterwards.

### Anchor (`#`)
Used for defining start of the dialogue block and later switch to it.
Anchor starts with `#`. Everything after this will be the name of dialogue block.
Ends when there will be another dialogue block or the end of file.

### Expression (`$`)
Used for executing arbitrary code. Will be executed as Godot Expression in context of dialogue interpreter.
Typically it is a method call.

### Question (`=?`)
Text with followed options to choose from.

### Options (`=<`)
Options to choose from. Written in form of `=<anchor_name>` and after selecting
one of them interpreter will jump to block specified by anchor name.

### Goto (`=>`)
Used for jumping to another dialogue block unconditionally.

## AST
TODO

## Interpreter
TODO

## TODO
- [ ] Multiline phrases
- [x] Options choose
- [x] Branching
- [ ] If / switch logic
- [ ] Variable read?
- [ ] Phrase syntax (effects, highlight, font, etc)
- [ ] Escape special characters in start of string if it is a phrase
