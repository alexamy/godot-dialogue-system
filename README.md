# Dialogue system

## Quick start
1. Create `DialogueData` resource and write a dialogue.
2. Create script, which extends `DialogueInterpreter`, and implement your custom `_ask` and `_say` methods.
3. Call `run_block()` method of interpreter with dialogue block key.

Example of dialogue resource is `dialogue1.tres`, and custom interpeter is `dialogue_scene.gd`.

## Syntax
### Phrase
Every line without special symbols in the start considered as a phrase.
It has two parts - name before `:` and phrase text afterwards. Can have multiline text, if has no characters after `:`.
If for some weird reason your phrase line must start with special symbol (below) - escape it with '\\', i.e. '\\$'.
To start phrase line with '\\', use '\\\\'.
Interpolate any code in a phrase between curly braces. It will use the same runner as expression line (`$`).

### Block (`#`)
Used for defining start of the dialogue block. Can be referenced later by other instructions.
Everything after '#' till end of line will be the name of dialogue block.
Block ends when there will be another dialogue block or the end of file.

### Expression (`$`)
Used for executing arbitrary code. As default, will be executed as Godot Expression in context of dialogue interpreter.
Typically it is a method call.

### Question (`=?`)
Text with followed options to choose from.

### Question choice (`=<`)
Options to choose from. Written in form of `=<block_name> Text` and after selecting
one of them interpreter will jump to block specified by block name.
Can have visibility condition in form of `=<block_name>code> Text`. 
If all choices are not visible, question block is skipped.
If no choice is choosen, will proceed to next line without jump.

### Switch (`$?`)
Code what will be matched with choices.

### Switch choice (`=<`)
Options to match switch value. Written in form of `=<block_name> code` and after finding first  
choice which code value is equals switch code value, interpreter will jump to block specified by block name.
Can have guard condition in form of `=<block_name>guard_code> code`. 
If all choices are excluded, switch block is skipped.
If no choice matches switch code, will proceed to next line without jump.

### Goto (`=>`)
Used for jumping to another dialogue block unconditionally.

### Comment (`//`)
Oneline comment. Stripped from output.

## ADT
TODO

## Interpreter
TODO

## Interpreter hooks
### `_say(name, text)`
Used for saying phrase. Not implemented in base interpreter.

### `_ask(text, choices)`
Used for asking question. Must return index of choosen choice. 
Can return -1 if no choice is choosen. Not implemented in base interpreter.

### `_run_code(code)`
Used for executing code line. 
Executes code as awaited godot expression in context of interpreter by default.

### `_interpolate(text)`
Used for interpolating text and names in phrases, also goto / question / switch targets.
Interpolate text in curly braces ("{}") as sync godot expressions by default.

## TODO
- [x] Multiline phrases
- [x] Options choose
- [x] Branching
- [x] If / switch logic
- [x] Variable interpolation
- [x] Phrase syntax (effects, highlight, font, etc)
- [x] Escape special characters in start of string if it is a phrase
- [ ] Node editor
- [ ] Conditional choice options
- [x] Expression in text of goto
