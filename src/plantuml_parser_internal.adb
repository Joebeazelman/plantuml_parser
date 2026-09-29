with PlantUML_Lexer;   use PlantUML_Lexer;
with UML_Model.Elements;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body PlantUML_Parser_Internal is

   Parse_Failed : exception;

   type Parser_State is record
      Tokens : Token_Vector;
      Pos    : Natural := 0;
   end record;

   function Current (S : Parser_State) return Token is
   begin
      if S.Pos = 0 or else S.Pos > S.Tokens.Last_Index then
         return (Kind     => End_Of_Input,
                 Text     => Null_Unbounded_String,
                 Location => No_Location);
      end if;
      return S.Tokens.Element (S.Pos);
   end Current;

   procedure Advance (S : in out Parser_State) is
   begin
      if S.Pos <= S.Tokens.Last_Index then
         S.Pos := S.Pos + 1;
      end if;
   end Advance;

   function Text_Of (T : Token) return String is
     (To_String (T.Text));

   --  Consume any run of Stereotype tokens at the current position
   --  and return them as a Stereotype_Vector. Returns an empty
   --  vector if no stereotypes are present.
   function Collect_Stereotypes (S : in out Parser_State)
     return UML_Model.Elements.Stereotype_Vector
   is
      Result : UML_Model.Elements.Stereotype_Vector;
   begin
      while Current (S).Kind = Stereotype loop
         Result.Append
           (UML_Model.Elements.Make_Stereotype (Text_Of (Current (S))));
         Advance (S);
      end loop;
      return Result;
   end Collect_Stereotypes;

   function Parse_Member (S : in out Parser_State) return Member is
      Result : Member;
   begin
      Result.Location := Current (S).Location;

      if Current (S).Kind = Unknown
        and then Text_Of (Current (S))'Length = 1
        and then Text_Of (Current (S)) (1) in '+' | '-' | '#' | '~'
      then
         Result.Vis := Current (S).Text;
         Advance (S);
      end if;

      if Current (S).Kind /= Ident then
         raise Parse_Failed;
      end if;
      Result.Name := Current (S).Text;
      Advance (S);

      --  Stereotypes may appear after the member name.
      Result.Stereotypes := Collect_Stereotypes (S);

      if Current (S).Kind = L_Paren then
         Result.Kind := Method;
         Advance (S);  --  consume '('
         loop
            exit when Current (S).Kind in R_Paren | End_Of_Input;

            declare
               P : Parameter;
            begin
               P.Location := Current (S).Location;
               if Current (S).Kind = Ident then
                  P.Name := Current (S).Text;
                  Advance (S);
               end if;
               if Current (S).Kind = Colon then
                  Advance (S);
                  if Current (S).Kind = Ident then
                     P.Of_Type := Current (S).Text;
                     Advance (S);
                  end if;
               end if;
               Result.Parameters.Append (P);
            end;

            if Current (S).Kind in Comma | Semicolon then
               Advance (S);
            end if;
         end loop;

         if Current (S).Kind = R_Paren then
            Advance (S);
         end if;
      else
         Result.Kind := Attribute;
      end if;

      if Current (S).Kind = Colon then
         Advance (S);
         if Current (S).Kind = Ident then
            Result.Of_Type := Current (S).Text;
            Advance (S);
         end if;
      end if;

      if Current (S).Kind = Semicolon then
         Advance (S);
      end if;

      return Result;
   end Parse_Member;

   procedure Parse_Class_Body (S : in out Parser_State;
                               C : in out Class_Decl) is
   begin
      Advance (S);  --  '{'
      while Current (S).Kind /= R_Brace
        and then Current (S).Kind /= End_Of_Input
      loop
         begin
            C.Members.Append (Parse_Member (S));
         exception
            when Parse_Failed =>
               while Current (S).Kind not in
                 Semicolon | R_Brace | End_Of_Input
               loop
                  Advance (S);
               end loop;
               if Current (S).Kind = Semicolon then
                  Advance (S);
               end if;
         end;
      end loop;
      if Current (S).Kind = R_Brace then
         Advance (S);
      end if;
   end Parse_Class_Body;

   procedure Parse_Class_Decl (S : in out Parser_State;
                               D : in out Diagram) is
      C : Class_Decl;
   begin
      C.Location := Current (S).Location;
      Advance (S);
      if Current (S).Kind /= Ident then
         return;
      end if;
      C.Name := Current (S).Text;
      Advance (S);

      C.Stereotypes := Collect_Stereotypes (S);

      if Current (S).Kind = L_Brace then
         Parse_Class_Body (S, C);
      end if;
      D.Classes.Append (C);
   end Parse_Class_Decl;

   procedure Parse_Relation (S : in out Parser_State;
                             D : in out Diagram) is
      R : Relation_Decl;
   begin
      R.Location := Current (S).Location;
      if Current (S).Kind /= Ident then
         return;
      end if;
      R.Source := Current (S).Text;
      Advance (S);
      if Current (S).Kind /= Arrow then
         return;
      end if;
      R.Kind := Current (S).Text;
      Advance (S);
      if Current (S).Kind /= Ident then
         return;
      end if;
      R.Target := Current (S).Text;
      Advance (S);
      R.Stereotypes := Collect_Stereotypes (S);
      D.Relations.Append (R);
   end Parse_Relation;

   procedure Parse_State_Decl (S : in out Parser_State;
                               D : in out Diagram;
                               Parent : Unbounded_String);

   procedure Parse_State_Body (S : in out Parser_State;
                               D : in out Diagram;
                               Parent : Unbounded_String) is
   begin
      Advance (S);
      while Current (S).Kind /= R_Brace
        and then Current (S).Kind /= End_Of_Input
      loop
         if Current (S).Kind = Kw_State then
            Parse_State_Decl (S, D, Parent);
         else
            Advance (S);
         end if;
      end loop;
      if Current (S).Kind = R_Brace then
         Advance (S);
      end if;
   end Parse_State_Body;

   procedure Parse_State_Decl (S : in out Parser_State;
                               D : in out Diagram;
                               Parent : Unbounded_String) is
      Decl : State_Decl;
   begin
      Decl.Location := Current (S).Location;
      Advance (S);

      if Current (S).Kind in
        Kw_Start | Kw_End | Kw_Choice | Kw_Fork | Kw_Join | Kw_History
      then
         Decl.Pseudo := Current (S).Text;
         Advance (S);
      end if;

      if Current (S).Kind /= Ident then
         return;
      end if;
      Decl.Name := Current (S).Text;
      Decl.Parent := Parent;
      Advance (S);

      Decl.Stereotypes := Collect_Stereotypes (S);

      D.States.Append (Decl);

      if Current (S).Kind = L_Brace then
         Parse_State_Body (S, D, Decl.Name);
      end if;
   end Parse_State_Decl;

   procedure Collect_Until
     (S    : in out Parser_State;
      Buf  : out Unbounded_String;
      Stop : Token_Kind) is
   begin
      Buf := Null_Unbounded_String;
      while Current (S).Kind not in
        Stop | Semicolon | R_Brace | End_Of_Input
      loop
         if Length (Buf) > 0 then
            Append (Buf, ' ');
         end if;
         Append (Buf, Text_Of (Current (S)));
         Advance (S);
      end loop;
   end Collect_Until;

   procedure Parse_Transition (S : in out Parser_State;
                               D : in out Diagram) is
      T : Transition_Decl;

      function Next_Kind return Token_Kind is
      begin
         if S.Pos + 1 > S.Tokens.Last_Index then
            return End_Of_Input;
         end if;
         return S.Tokens.Element (S.Pos + 1).Kind;
      end Next_Kind;

      function At_New_Transition return Boolean is
        (Current (S).Kind = Ident and then Next_Kind = Arrow);

   begin
      T.Location := Current (S).Location;
      if Current (S).Kind /= Ident then
         return;
      end if;
      T.Source := Current (S).Text;
      Advance (S);
      if Current (S).Kind /= Arrow then
         return;
      end if;
      Advance (S);
      if Current (S).Kind /= Ident then
         return;
      end if;
      T.Target := Current (S).Text;
      Advance (S);

      T.Stereotypes := Collect_Stereotypes (S);

      if Current (S).Kind = Colon then
         Advance (S);

         T.Event := Null_Unbounded_String;
         while Current (S).Kind not in
           L_Bracket | Slash | Semicolon | R_Brace | End_Of_Input
           and then not At_New_Transition
         loop
            if Length (T.Event) > 0 then
               Append (T.Event, ' ');
            end if;
            Append (T.Event, Text_Of (Current (S)));
            Advance (S);
         end loop;

         T.Guard := Null_Unbounded_String;
         if Current (S).Kind = L_Bracket then
            Advance (S);
            Collect_Until (S, T.Guard, R_Bracket);
            if Current (S).Kind = R_Bracket then
               Advance (S);
            end if;
         end if;

         T.Action := Null_Unbounded_String;
         if Current (S).Kind = Slash then
            Advance (S);
            while Current (S).Kind not in
              Semicolon | R_Brace | End_Of_Input
              and then not At_New_Transition
            loop
               if Length (T.Action) > 0 then
                  Append (T.Action, ' ');
               end if;
               Append (T.Action, Text_Of (Current (S)));
               Advance (S);
            end loop;
         end if;
      end if;

      if Current (S).Kind = Semicolon then
         Advance (S);
      end if;

      D.Transitions.Append (T);
   end Parse_Transition;

   function Parse_To_AST (Source : String) return AST_Results.Result is
      S : Parser_State;
      D : Diagram;
   begin
      S.Tokens := Lex (Source);
      if not S.Tokens.Is_Empty then
         S.Pos := S.Tokens.First_Index;
      end if;

      if Current (S).Kind = Kw_Startuml then
         Advance (S);
      end if;

      case Current (S).Kind is
         when Kw_Class =>
            D.Kind := Class_Diagram;
         when Kw_State =>
            D.Kind := State_Diagram;
         when Ident =>
            D.Kind := Class_Diagram;
         when End_Of_Input =>
            return AST_Results.Err
              (Make_Error (No_Location, "empty input"));
         when others =>
            return AST_Results.Err
              (Make_Error (Current (S).Location,
                           "expected 'class' or 'state', found "
                           & Token_Kind'Image (Current (S).Kind)));
      end case;

      D.Location := Current (S).Location;

      loop
         case Current (S).Kind is
            when Kw_Class =>
               Parse_Class_Decl (S, D);
            when Kw_State =>
               Parse_State_Decl (S, D, Null_Unbounded_String);
            when Ident =>
               if D.Kind = Class_Diagram then
                  Parse_Relation (S, D);
               else
                  Parse_Transition (S, D);
               end if;
            when Kw_Enduml =>
               Advance (S);
            when End_Of_Input =>
               exit;
            when others =>
               Advance (S);
         end case;
      end loop;

      return AST_Results.Ok (D);
   end Parse_To_AST;

end PlantUML_Parser_Internal;
