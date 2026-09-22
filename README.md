# plantuml_parser

PlantUML state- and class-diagram parser for Ada 2022. Parses a `.puml`
source into a normalized `UML.Model.Diagram` that downstream tools can
consume without knowing PlantUML syntax.

Part of the [uml2code](https://github.com/Joebeazelman/uml2code) project.

## What it does

Two diagram kinds are recognized:

- **State diagrams** — states, composite (nested) states, transitions
  with triggers, guards, effects, labels; pseudostates (`[*]`, `[H]`,
  `[H*]`, choice, fork, join); entry/exit/do actions; internal
  transitions; attached and diagram-level notes.
- **Class diagrams** — classes, abstract classes, interfaces,
  enumerations, records, packages, objects; attributes, methods, enum
  literals; inheritance, realization, composition, aggregation,
  association; multiplicities; stereotypes; notes.

The parser does not generate code, render diagrams, or perform
semantic validation. It produces the model and stops there.

## Using it

Two functions:

```ada
with PlantUML;
with UML.Model;

D : constant UML.Model.Diagram := PlantUML.Parse (Source);
