# Dialogue system

## Quick start
1. Create `DialogueData` resource and write a dialogue.
2. Create script, which extends `DialogueInterpreter`, and implement your custom `_ask` and `_say` methods.
3. Call `run()` method of interpreter with dialogue block key.

Example of dialogue resource is `dialogue1.tres`, and custom interpeter is `dialogue_scene.gd`.

## Syntax
### Phrase
Every line without special symbols in the start considered as a phrase.
It has two parts - name before `:` and phrase text afterwards. Can have multiline text, if has no characters after `:`.
If for some weird reason your phrase line must start with special symbol (below) - escape it with '\', i.e. '\$'.
To start phrase line with '\', use '\\'.

### Anchor (`#`)
Used for defining start of the dialogue block. Can be referenced later by other instructions.
Everything after '#' till end of line will be the name of dialogue block.
Block ends when there will be another dialogue block or the end of file.

### Expression (`$`)
Used for executing arbitrary code. As default, will be executed as Godot Expression in context of dialogue interpreter.
Typically it is a method call.

### Question (`=?`)
Text with followed options to choose from.

### Choice (`=<`)
Options to choose from. Written in form of `=<anchor_name>` and after selecting
one of them interpreter will jump to block specified by anchor name.

### Goto (`=>`)
Used for jumping to another dialogue block unconditionally.

### Comment (`//`)
One-line comment. Stripped from output.

## ADT
TODO

## Interpreter
TODO

## Interpreter hooks
### `_say(name, text)`
Runned when saying phrase.

### `_ask(text, choices)`
Runned when asking question. Must return index of choosen choice.

### `_run(code)`
Runned when executing code line. Default to Godot Expression in context of interpreter.

## TODO
- [ ] Multiline phrases
- [x] Options choose
- [x] Branching
- [ ] If / switch logic
- [ ] Variable read?
- [ ] Phrase syntax (effects, highlight, font, etc)
- [x] Escape special characters in start of string if it is a phrase
- [ ] Node editor
