# Node-based dialogue system

Two core concepts of this system are **dialogue nodes** and **interpreters**.

Dialogue is composed with **dialogue nodes** in a scene tab and later executed via **interpreter** in a script.

## Dialogue nodes
Base class: [`DialogueNodeBase`](./dialogue_node_base.gd).

Every node has:
- `start_dialogue` method

Used for starting interpreter with dialogue data.
Must be redefined in a derived class.

- `interpreter` accessor

Access node's **`Interpreter`** property. If property is not set in the editor, method will attempt to find an interpreter above in a node tree. If none is found, prints an error.

- `Interpreter` property

![](./imgs/node_interpreter.png)

### Phrase


Derived nodes:

- Group

Groups and sequentially runs other nodes.

- Phrase

Provides `name` and `text`.

- Question

Provides `question` and array of text `option` / NodePath `target`.
After selecting some `option`, dialogue will continue from `target`.

- Custom node

Just extend `DialogueNodeBase` and redefine `start_dialogue()`.
If `start_dialogue` will return dialogue node, it will be executed with group, if nothing is returned, group executes only this node.

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
