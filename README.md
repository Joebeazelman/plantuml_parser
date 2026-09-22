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

    with PlantUML;
    with UML.Model;

    D : constant UML.Model.Diagram := PlantUML.Parse (Source);

`Parse` detects the diagram kind and returns a `UML.Model.Diagram`. On
a source with no recognizable diagram, `D.Kind` is `Unknown`. A
malformed source raises `PlantUML.Parse_Error`.

For detection alone, without parsing:

    K : constant PlantUML.Diagram_Kind := PlantUML.Detect_Kind (Source);

`Detect_Kind` returns `State_Diagram`, `Class_Diagram`, or `Unknown`
based on the diagram's keywords.

## The model

`UML.Model` is types only, `pragma Preelaborate`, no dependencies
beyond `Ada.Containers` and `Ada.Strings.Unbounded`. The important
types:

- **`Diagram`** — `Id`, `Kind`, `Metadata`, `Elements`, `Roots`,
  `Relations`, `Notes`
- **`Element`** — `Id`, `Display`, `Kind`, `Annotations`, `Notes`,
  `Members`, `Children`, `Parent`
- **`Relation`** — `From`, `To`, `Kind`, `Trigger`, `Guard`, `Effect`,
  `Label`, `Mult_From`, `Mult_To`, `Stereotypes`, `Notes`
- **`Member`** — `Kind`, `Id`, `Type_Name`, `Params`, `Vis`, static
  and abstract flags, annotations
- **`Note`** — `Text`, `Subject`, `Position`
- **`Annotation`** — `Kind`, `Text`, `Trigger`, `Guard`

The model is *flat*: `Elements` is a vector of records, and links
between them are indices, not pointers. This is the standard Ada
workaround for containers of self-referential records.
`Element.Parent` and `Element.Children` describe containment;
`Relation.From` and `Relation.To` are indices into `Elements`.

`UML.Model.Queries` provides structural helpers over the flat model:

- `Find_By_Id`, `Require_By_Id`
- `Region_Of`, `States_In`, `Transitions_In`, `Is_Composite`,
  `Is_History`
- `Parents_Of`, `Associations_From`

These reconstruct the views that generators need (regions, parent
chains, transitions scoped to a region) without adding fields to the
model.

## Public interface

Four packages are intended for external consumers:

- `UML` — the parent package for the `UML` namespace
- `UML.Model` — the normalized model
- `UML.Model.Queries` — structural helpers over the model
- `PlantUML` — the entry point (`Parse`, `Detect_Kind`)

`PlantUML.Tokens`, `PlantUML.States`, and `PlantUML.Classes` are
*internal*: they exist because the parser is split across diagram
kinds, and `PlantUML.To_Model` bridges their record types into
`UML.Model`. External code should never `with` them.

They are nonetheless listed in the `Library_Interface` clause of
`plantuml_parser.gpr`, because the test suite links against the
library's exported interface rather than its source tree. This is an
Ada/GPR constraint, not an endorsement of their use. The rule for
consumers is: import only the four packages above.

If you add a new *public* package, add it to `Library_Interface` as
well, or dependents won't see it.

## Building

    alr build

Requires Alire 2.x and GNAT 16 with `-gnat2022 -gnatX`. The only
dependency is `aunit`, used by the test suite.

## Testing

    ./run_tests.sh

24 AUnit tests across three suites:

- `Test_Tokens` — tokenizer edge cases
- `Test_States` — state-diagram parsing, region-scoped pseudostates,
  composite children, entry annotations, history
- `Test_Classes` — class-diagram parsing, members, inheritance,
  interfaces, enumerations, diagram-kind detection

## Design notes

**Full fidelity.** Every detail the parser can extract has a home in
the model. If a construct cannot be represented, the model is wrong —
not the parser. This is why `Element_Kind` includes fork, join, choice,
and both history kinds, even though few downstream tools use them.

**Parsers do not import the model.** `PlantUML.States` and
`PlantUML.Classes` have their own record types and don't `with
UML.Model`. `PlantUML.To_Model` is the only bridge. This keeps the
parsers independently testable and makes it possible to add new source
formats without touching the model.

**Notes are first-class.** `Element.Notes` holds element-attached
notes; `Diagram.Notes` holds diagram-level notes (floating and block
forms). Multi-line note text uses backslash-n escapes, decoded at
parse time by `PlantUML.Tokens.Decode_Escapes`.

**Region membership is by containment, not by name.** The parser
records which package or composite a classifier or state belongs to
via `Children`; the translator reverse-populates `Parent`. Consumers
walk either direction. Canonical names like `Running.[*]_start` are
parse-time artifacts, not the primary source of containment.

## License

MIT OR Apache-2.0 WITH LLVM-exception.
