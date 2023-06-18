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

### Choice (`=<`)
Options to choose from. Written in form of `=<block_name>` and after selecting
one of them interpreter will jump to block specified by anchor name.

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
Runned when saying phrase. Not implemented in base interpreter.

### `_ask(text, choices)`
Runned when asking question. Must return index of choosen choice. Not implemented in base interpreter.

### `_run(code)`
Runned when executing code line. Run code as godot expression in context of interpreter by default.

### `_interpolate(text)`
Runned on displayed text. Interpolate godot expressions in curly braces by default.
Also can by used to implement custom phrase syntax, i.e. effects, word highlighting, font change, etc.

## TODO
- [x] Multiline phrases
- [x] Options choose
- [x] Branching
- [ ] If / switch logic
- [x] Variable interpolation
- [x] Phrase syntax (effects, highlight, font, etc)
- [x] Escape special characters in start of string if it is a phrase
- [ ] Node editor
- [ ] Conditional choice options
