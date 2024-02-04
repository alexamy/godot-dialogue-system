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
![](./imgs/phrase_node.png)

Dialogue node with `name` and `text` multiline properties.

When executed via `start_dialogue`, will run `say` method of an interpreter, providing it's properties as arguments.

![](./imgs/phrase_props.png)

## Question
![](./imgs/question_node.png)

Dialogue node with `question` and `options` properties.

When executed via `start_dialogue`, will run `ask` method of an interpreter, providing question text and text from it's options.

`ask` method must return index of choosen question option.

![](./imgs/question_props.png)

`option` is a `DialogueQuestionOption` custom resource with `text` and `path` node path, used for alter dialogue execution path.

![](./imgs/question_resource.png)

## Group
![](./imgs/group_node.png)

Dialogue node used for grouping other nodes.

When executed via `start_dialogue`, will run `start_dialogue` of each of it's children sequentially.

Children's `start_dialogue` can return node path of another dialogue node, and it's `start_dialogue` will be executed in a sequence as well. This behaviour provides a way to change a way of dialogue execution through question dialogue node, for example.

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
