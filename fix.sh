cat > /tmp/run.sh <<'ENDSCRIPT'
#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PYEOF'
p = "/Users/manuelbarros/Projects/ai-generated/plantuml_parser/src/plantuml-to_model.adb"
s = open(p).read()

# 1. Add title promotion to From_State
old = '''      Result.Kind := UML.Model.State_Diagram;
      Result.Id   := D.Diagram_Name;

      for S of D.Pool loop'''

new = '''      Result.Kind := UML.Model.State_Diagram;
      Result.Id   := D.Diagram_Name;

      if Length (D.Title) > 0 then
         Result.Metadata.Append
           (UML.Model.Metadata'(Kind => UML.Model.Title,
                                Text => D.Title));
      end if;

      for S of D.Pool loop'''

assert old in s, "From_State anchor"
s = s.replace(old, new, 1)
print("From_State: title promotion added")

# 2. Remove the duplicate in From_Classes
old2 = '''      if Length (D.Title) > 0 then
         Result.Metadata.Append
           (UML.Model.Metadata'(Kind => UML.Model.Title,
                                Text => D.Title));
      end if;

      if Length (D.Title) > 0 then
         Result.Metadata.Append
           (UML.Model.Metadata'(Kind => UML.Model.Title,
                                Text => D.Title));
      end if;'''

new2 = '''      if Length (D.Title) > 0 then
         Result.Metadata.Append
           (UML.Model.Metadata'(Kind => UML.Model.Title,
                                Text => D.Title));
      end if;'''

if old2 in s:
    s = s.replace(old2, new2, 1)
    print("From_Classes: duplicate removed")
else:
    print("From_Classes: duplicate anchor not found")

open(p, 'w').write(s)
PYEOF

cd ~/Projects/ai-generated/plantuml_parser
alr build 2>&1 | tail -4
cd ../uml2code
alr build 2>&1 | tail -3
./bin/uml2code dump ../samples/adb_protocol.puml 2>&1 | head -8
ENDSCRIPT

bash /tmp/run.sh