with PlantUML.Tokens;          use PlantUML.Tokens;

package body PlantUML.States is

   type Builder is record
      D    : aliased State_Diagram;
      Open : Index_Vectors.Vector;
   end record;

   function Parse (Source : String) return State_Diagram is
      Toks : aliased constant List := Tokenize (Source);
      C    : Cursor  := Make (Toks);
      B    : Builder;

      function Scoped (Name : String) return String is
        (if B.Open.Is_Empty then Name
         else To_String (B.D.Pool (Positive (B.Open.Last_Element)).Id) & "." & Name);

      function Add_State (S : State) return State_Index is
      begin
         B.D.Pool.Append (S);
         return State_Index (B.D.Pool.Last_Index);
      end Add_State;

      procedure Append_State (S : State) is
         Idx : constant State_Index := Add_State (S);
      begin
         if B.Open.Is_Empty then B.D.Roots.Append (Idx);
         else B.D.Pool (Positive (B.Open.Last_Element)).Children.Append (Idx);
         end if;
      end Append_State;

      procedure Open_Composite (S : State) is
      begin
         Append_State (S);
         B.Open.Append (State_Index (B.D.Pool.Last_Index));
      end Open_Composite;

      procedure Close_Composite is
      begin
         if B.Open.Is_Empty then return; end if;
         if B.D.Pool (Positive (B.Open.Last_Element)).Children.Is_Empty then
            B.D.Pool (Positive (B.Open.Last_Element)).Kind := Simple;
         end if;
         B.Open.Delete_Last;
      end Close_Composite;

      function Pseudostate_Exists (Name : String) return Boolean is
      begin
         for S of B.D.Pool loop
            if To_String (S.Id) = Name then return True; end if;
         end loop;
         return False;
      end Pseudostate_Exists;

      procedure Register_Pseudostate (Name : String; Kind : State_Kind) is
      begin
         if not Pseudostate_Exists (Name) then
            Append_State ((Id => To_Unbounded_String (Name), Display => Null_Unbounded_String,
                           Kind => Kind, Annotations => Annotation_Vectors.Empty_Vector,
                           Children => Index_Vectors.Empty_Vector));
         end if;
      end Register_Pseudostate;

      procedure Apply_Annotation (Name : String; A : Annotation) is
      begin
         for I in B.D.Pool.First_Index .. B.D.Pool.Last_Index loop
            if To_String (B.D.Pool (I).Id) = Name then
               B.D.Pool (I).Annotations.Append (A);
               return;
            end if;
         end loop;
      end Apply_Annotation;

      procedure Parse_Bracket_Pseudostate (Kind : out State_Kind; Ok : out Boolean) is
      begin
         Kind := Simple; Ok := False;
         if not C.Sym_Is ("[") then return; end if;
         C.Next;
         if C.Sym_Is ("*") then
            C.Next;
            if C.Take_If_Sym_Is ("]") then Kind := Start_Pseudostate; Ok := True; end if;
         elsif C.Take_If_Word_Is ("H") then
            if C.Sym_Is ("*") then
               C.Next;
               if C.Take_If_Sym_Is ("]") then Kind := History_Deep; Ok := True; end if;
            elsif C.Take_If_Sym_Is ("]") then Kind := History_Shallow; Ok := True;
            end if;
         end if;
      end Parse_Bracket_Pseudostate;

      function Canon_For (Kind : State_Kind) return Name is
        (case Kind is
            when Start_Pseudostate => To_Unbounded_String ("[*]"),
            when History_Shallow   => To_Unbounded_String (Shallow_History_Name),
            when History_Deep      => To_Unbounded_String (Deep_History_Name),
            when others            => raise Parse_Error with "Unknown pseudostate kind");

      function Canon_Name (Kind : State_Kind) return Name is
        (case Kind is
            when Start_Pseudostate => To_Unbounded_String (Scoped (Start_Pseudostate_Name)),
            when History_Shallow   => To_Unbounded_String (Scoped (Shallow_History_Name)),
            when History_Deep      => To_Unbounded_String (Scoped (Deep_History_Name)),
            when others            => To_Unbounded_String (Scoped (Start_Pseudostate_Name)));

      procedure Parse_Label (Trigger : out Name; Guard : out Name; Effect : out Name; Raw : out Name);

      function Parse_Target_Pseudostate return Name is
         Kind : State_Kind; Ok : Boolean; Canon : Name;
      begin
         Parse_Bracket_Pseudostate (Kind, Ok);
         if not Ok then raise Parse_Error with "Unrecognized pseudostate as target"; end if;
         Canon := Canon_For (Kind);
         if Kind = Start_Pseudostate then
            Register_Pseudostate (Scoped (End_Pseudostate_Name), End_Pseudostate);
            return To_Unbounded_String (Scoped (End_Pseudostate_Name));
         else
            Register_Pseudostate (Scoped (To_String (Canon)), Kind);
            return To_Unbounded_String (Scoped (To_String (Canon)));
         end if;
      end Parse_Target_Pseudostate;

      function Parse_Target return Name is
      begin
         if C.Sym_Is ("[") then return Parse_Target_Pseudostate;
         elsif C.Peek.Kind = Word then
            declare
               Result : Name := Take (C).Text;
            begin
               while C.Take_If_Sym_Is (".") loop
                  Append (Result, ".");
                  if C.Sym_Is ("[") then
                     declare Kind : State_Kind; Ok : Boolean; Canon : Name; begin
                        Parse_Bracket_Pseudostate (Kind, Ok);
                        if not Ok then raise Parse_Error with "Unrecognized pseudostate"; end if;
                        Canon := Canon_For (Kind);
                        Append (Result, To_String (Canon));
                        if Kind in Start_Pseudostate | History_Shallow | History_Deep then
                           Register_Pseudostate (To_String (Result), Kind);
                        end if;
                     end;
                  elsif C.Peek.Kind = Word then Append (Result, Take (C).Text);
                  else exit; end if;
               end loop;
               return Result;
            end;
         else raise Parse_Error with "Expected transition target"; end if;
      end Parse_Target;

      procedure Parse_Tail (Tr : in out Transition) is
      begin
         if C.Take_If_Sym_Is (":") then
            Parse_Label (Tr.Trigger, Tr.Guard, Tr.Effect, Tr.Label);
            if Length (Tr.Trigger) = 0 and then Length (Tr.Guard) = 0 and then Length (Tr.Effect) = 0 then
               Tr.Kind := Completion;
            end if;
         else Tr.Kind := Completion; end if;
      end Parse_Tail;

      procedure Parse_Transition_From (Source : Name) is
         Tr : Transition;
      begin
         Tr.From := Source; Tr.Kind := External;
         Next (C); Tr.To := Parse_Target;
         Parse_Tail (Tr);
         B.D.Transitions.Append (Tr);
      end Parse_Transition_From;

      function Parse_Annotation return Annotation is
         A : Annotation;
         T : constant Token := C.Peek;
         S : constant String := (if T.Kind = Word then T.Text.To_String else "");
      begin
         if S in "entry" | "exit" | "do" then
            A.Kind := (if S = "entry" then Entry_Action elsif S = "exit" then Exit_Action else Do_Activity);
            C.Next;
            if Take_If_Sym_Is (C, "/") then null; end if;
            A.Action := Take (C).Text;
         else
            declare Has_Slash : Boolean := False; begin
               for Lookahead in 0 .. Natural'Last loop
                  declare Tk : constant Token := Peek_At (C, Lookahead); begin
                     exit when Tk.Kind in Newline | Eof;
                     if Tk.Kind = Symbol and then To_String (Tk.Text) = "/" then Has_Slash := True; exit; end if;
                  end;
               end loop;
               if not Has_Slash then
                  A.Kind := Note;
                  declare Raw : Unbounded_String := Null_Unbounded_String; begin
                     while C.Peek.Kind not in Newline | Eof loop
                        declare Tk : constant Token := C.Peek; begin
                           if Tk.Space_Before and then Length (Raw) > 0 then Append (Raw, " "); end if;
                           Append (Raw, Tk.Text); C.Next;
                        end;
                     end loop;
                     A.Action := To_Unbounded_String (Decode_Escapes (To_String (Raw)));
                  end;
                  return A;
               end if;
            end;
            A.Kind := Internal_Transition;
            if C.Peek.Kind = Word then A.Trigger := Take (C).Text; end if;
            if C.Take_If_Sym_Is ("[") then
               declare G : Name := Null_Unbounded_String; begin
                  while not (C.Sym_Is ("]") or else C.At_Eof) loop G := G & C.Peek.Text & " "; C.Next; end loop;
                  if Take_If_Sym_Is (C, "]") then null; end if;
                  A.Guard := G;
               end;
            end if;
            if C.Take_If_Sym_Is ("/") then A.Action := Take (C).Text; end if;
         end if;
         if A.Kind in Note | Stereotype | Unknown or else Length (A.Action) = 0 then
            while C.Peek.Kind not in Newline | Eof loop
               if Length (A.Action) = 0 then A.Action := C.Peek.Text;
               else A.Action := A.Action & " " & C.Peek.Text; end if;
               C.Next;
            end loop;
         end if;
         return A;
      end Parse_Annotation;

      procedure Parse_Label (Trigger : out Name; Guard : out Name; Effect : out Name; Raw : out Name) is
         R : Unbounded_String;
      begin
         Trigger := Null_Unbounded_String; Guard := Null_Unbounded_String; Effect := Null_Unbounded_String;
         if C.Peek.Kind = Word then Trigger := Take (C).Text; R := Trigger; end if;
         if C.Take_If_Sym_Is ("[") then
            declare G : Name := Null_Unbounded_String; begin
               while not (C.Sym_Is ("]") or else C.At_Eof) loop G := G & C.Peek.Text & " "; C.Next; end loop;
               if Take_If_Sym_Is (C, "]") then null; end if;
               Guard := G; R := R & " [" & G & "]";
            end;
         end if;
         if C.Take_If_Sym_Is ("/") then Effect := Take (C).Text; R := R & " / " & Effect; end if;
         while C.Peek.Kind not in Newline | Eof loop
            declare T : constant Token := Take (C); begin
               if Length (Effect) = 0 then Effect := T.Text; else Effect := Effect & " " & T.Text; end if;
               R := R & " " & T.Text;
            end;
         end loop;
         Raw := R;
      end Parse_Label;

      procedure Register_Source_Pseudostate (Kind : State_Kind) is
      begin
         case Kind is
            when Start_Pseudostate => Register_Pseudostate (Scoped (Start_Pseudostate_Name), Start_Pseudostate);
            when History_Shallow => Register_Pseudostate (Scoped (Shallow_History_Name), History_Shallow);
            when History_Deep => Register_Pseudostate (Scoped (Deep_History_Name), History_Deep);
            when others => null;
         end case;
      end Register_Source_Pseudostate;

   begin
      while not C.At_Eof loop
         declare
            T  : constant Token  := C.Peek;
            Tx : constant String := (if T.Kind = Word then T.Text.To_String else "");
         begin
            if Tx = "@startuml" then
               C.Next;
               if C.Peek.Kind = Word then B.D.Diagram_Name := Take (C).Text; end if;
            elsif Tx in "@enduml" | "@endstate" then exit;
            elsif Tx = "@startstate" then C.Next;
            elsif Tx = "title" then
               C.Next;
               declare Title : Unbounded_String := Null_Unbounded_String; begin
                  while C.Peek.Kind not in Newline | Eof loop
                     if Length (Title) > 0 and then C.Peek.Space_Before then Append (Title, " "); end if;
                     Append (Title, C.Peek.Text); C.Next;
                  end loop;
                  B.D.Title := Title;
               end;
            elsif T.Kind = Newline then C.Next;
            elsif C.Take_If_Sym_Is ("}") then Close_Composite;
            elsif C.Take_If_Sym_Is ("{") then null;
            elsif C.Take_If_Sym_Is ("--") then Skip_To_End_Of_Line (C);
            elsif Tx = "state" then
               C.Next; Skip_Newlines (C);
               if C.At_Eof then raise Parse_Error with "Unexpected end"; end if;
               declare S : State; begin
                  S.Id := Take (C).Text; S.Kind := Simple;
                  if Take_If_Word_Is (C, "as") then S.Display := Take (C).Text; end if;
                  if C.Sym_Is ("<") then
                     while C.Peek.Kind /= Newline and then not C.Sym_Is (">") and then not C.At_Eof loop C.Next; end loop;
                     if Take_If_Sym_Is (C, ">") then null; end if;
                  end if;
                  if C.Take_If_Sym_Is ("{") then S.Kind := Composite; Open_Composite (S);
                  else Append_State (S); end if;
               end;
            elsif C.Sym_Is ("[") then
               declare Kind : State_Kind; Ok : Boolean; begin
                  Parse_Bracket_Pseudostate (Kind, Ok);
                  if not Ok then raise Parse_Error with "Unrecognized"; end if;
                  Register_Source_Pseudostate (Kind);
                  if C.Peek.Kind = Arrow then Parse_Transition_From (Canon_Name (Kind)); end if;
               end;
            elsif T.Kind = Word then
               declare Nxt : constant Token := Peek_At (C); begin
                  if Nxt.Kind = Arrow then
                     declare From : constant Name := C.Peek.Text; begin C.Next; Parse_Transition_From (From); end;
                  elsif Nxt.Kind = Symbol and then Nxt.Text.To_String = ":" then
                     declare Subj : constant Name := C.Peek.Text; begin
                        C.Next; C.Next; Apply_Annotation (To_String (Subj), Parse_Annotation);
                     end;
                  else Skip_To_End_Of_Line (C); end if;
               end;
            else Skip_To_End_Of_Line (C); end if;
         end;
      end loop;
      return B.D;
   end Parse;

   function Get (D : State_Diagram; Index : State_Index) return State is (D.Pool (Positive (Index)));
end PlantUML.States;
