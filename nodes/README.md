# Node-based dialogue system
There are two parts of the system:
- Blocks

For making dialogue content.
- Interpreter

For executing dialogue.

## Dialogue blocks
Base node: `DialogueNodeBase`.

Every derived node must redefine:
- `start_dialogue()`

Each block can have it's own interpreter link, or will search for
one above the parent tree.

Derived nodes:
- Group

Groups and sequentially runs other nodes.
- Phrase

Provides `name` and `text`.
- Question

Provides `question` and array of text `option` / NodePath `target`.
After selecting some `option`, dialogue will continue from `target`.

## Dialogue interpreter
Base node: `DialogueInterpreterBase`.

Every derived node must redefine:
- `_say(name, text)`
- `_ask(question, options)`

## Example
`example/dialogue_example.tscn`.
There are `interpreter_console` for simple printing
and `interpreter_example` for ui-based dialogue.
Redefine (drag-and-drop) `interpreter` on `DialogueGroup` for changes.
