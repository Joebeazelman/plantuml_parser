with Ada.Characters.Handling; use Ada.Characters.Handling;

package body PlantUML_Lexer is

   function Lex (Source : String) return Token_Vector is
      --  Nested state: the lexer is a one-shot scan of Source, so
      --  everything lives in the enclosing subprogram's scope.
      Pos : Natural := 0;              --  offset into Source
      Loc : Source_Location := No_Location;

      Vec : Token_Vector;

      function At_End return Boolean is
        (Pos >= Source'Length);

      function Peek return Character is
        (if At_End then ASCII.NUL
         else Source (Source'First + Pos));

      function Peek_Next return Character is
        (if Pos + 1 >= Source'Length then ASCII.NUL
         else Source (Source'First + Pos + 1));

      procedure Advance is
      begin
         if At_End then
            return;
         end if;
         if Peek = ASCII.LF then
            Loc := (Line => Loc.Line + 1, Column => 1);
         else
            Loc := (Line => Loc.Line, Column => Loc.Column + 1);
         end if;
         Pos := Pos + 1;
      end Advance;

      procedure Skip_Whitespace is
      begin
         while not At_End
           and then Peek in ' ' | ASCII.HT | ASCII.LF | ASCII.CR
         loop
            Advance;
         end loop;
      end Skip_Whitespace;

      procedure Skip_Line_Comment is
      begin
         while not At_End and then Peek /= ASCII.LF loop
            Advance;
         end loop;
      end Skip_Line_Comment;

      procedure Skip_Block_Comment is
      begin
         Advance;  --  '/'
         Advance;  --  '''
         while not At_End loop
            if Peek = ''' and then Peek_Next = '/' then
               Advance;
               Advance;
               return;
            end if;
            Advance;
         end loop;
      end Skip_Block_Comment;

      function Make_Token
        (Kind : Token_Kind; Text : String; Loc : Source_Location)
         return Token is
        ((Kind => Kind, Text => To_Unbounded_String (Text), Location => Loc));

      function Keyword_Of (S : String) return Token_Kind is
      begin
         if    S = "class"    then return Kw_Class;
         elsif S = "state"    then return Kw_State;
         elsif S = "attr"     then return Kw_Attr;
         elsif S = "method"   then return Kw_Method;
         elsif S = "start"    then return Kw_Start;
         elsif S = "end"      then return Kw_End;
         elsif S = "choice"   then return Kw_Choice;
         elsif S = "fork"     then return Kw_Fork;
         elsif S = "join"     then return Kw_Join;
         elsif S = "history"  then return Kw_History;
         elsif S = "startuml" then return Kw_Startuml;
         elsif S = "enduml"   then return Kw_Enduml;
         else return Ident;
         end if;
      end Keyword_Of;

      function Scan_Ident return Token is
         Start_Loc : constant Source_Location := Loc;
         Buf       : Unbounded_String;
      begin
         while not At_End
           and then (Is_Alphanumeric (Peek) or else Peek = '_')
         loop
            Append (Buf, Peek);
            Advance;
         end loop;
         declare
            S : constant String := To_String (Buf);
         begin
            return Make_Token (Keyword_Of (S), S, Start_Loc);
         end;
      end Scan_Ident;

      function Scan_Number return Token is
         Start_Loc : constant Source_Location := Loc;
         Buf       : Unbounded_String;
      begin
         while not At_End and then Is_Digit (Peek) loop
            Append (Buf, Peek);
            Advance;
         end loop;
         return Make_Token (Number, To_String (Buf), Start_Loc);
      end Scan_Number;

      function Is_Arrow_Char (Ch : Character) return Boolean is
        (Ch in '-' | '.' | '>' | '|' | 'o' | '*');

      function Scan_Arrow return Token is
         Start_Loc : constant Source_Location := Loc;
         Buf       : Unbounded_String;
      begin
         while not At_End and then Is_Arrow_Char (Peek) loop
            Append (Buf, Peek);
            Advance;
         end loop;
         return Make_Token (Arrow, To_String (Buf), Start_Loc);
      end Scan_Arrow;

      procedure Emit_Punct (Kind : Token_Kind; Text : String) is
      begin
         Vec.Append (Make_Token (Kind, Text, Loc));
         Advance;
      end Emit_Punct;

   begin
      while not At_End loop
         Skip_Whitespace;

         exit when At_End;

         if Peek = ''' then
            Skip_Line_Comment;
         elsif Peek = '/' and then Peek_Next = ''' then
            Skip_Block_Comment;
         elsif Peek = '@' then
            declare
               Start_Loc : constant Source_Location := Loc;
               Buf       : Unbounded_String;
            begin
               Advance;  --  '@'
               while not At_End
                 and then (Is_Alphanumeric (Peek) or else Peek = '_')
               loop
                  Append (Buf, Peek);
                  Advance;
               end loop;
               declare
                  S : constant String := To_String (Buf);
               begin
                  Vec.Append (Make_Token (Keyword_Of (S), S, Start_Loc));
               end;
            end;
         else
            declare
               Ch : constant Character := Peek;
            begin
               case Ch is
                  when '{' =>
                     Emit_Punct (L_Brace, "{");
                  when '}' =>
                     Emit_Punct (R_Brace, "}");
                  when '(' =>
                     Emit_Punct (L_Paren, "(");
                  when ')' =>
                     Emit_Punct (R_Paren, ")");
                  when ':' =>
                     Emit_Punct (Colon, ":");
                  when ';' =>
                     Emit_Punct (Semicolon, ";");
                  when '-' | '.' | 'o' | '*' =>
                     declare
                        Save_Pos : constant Natural := Pos;
                        Save_Loc : constant Source_Location := Loc;
                        T : constant Token := Scan_Arrow;
                        S : constant String := To_String (T.Text);
                     begin
                        --  Valid arrow: at least two chars, ends in
                        --  '>' or '-' or '.'.
                        if S'Length >= 2
                          and then S (S'Last) in '>' | '-' | '.'
                        then
                           Vec.Append (T);
                        else
                           Pos := Save_Pos;
                           Loc := Save_Loc;
                           Emit_Punct (Unknown, (1 => Ch));
                        end if;
                     end;
                  when others =>
                     if Is_Letter (Ch) then
                        Vec.Append (Scan_Ident);
                     elsif Is_Digit (Ch) then
                        Vec.Append (Scan_Number);
                     else
                        Emit_Punct (Unknown, (1 => Ch));
                     end if;
               end case;
            end;
         end if;
      end loop;

      Vec.Append (Make_Token (End_Of_Input, "", Loc));
      return Vec;
   end Lex;

end PlantUML_Lexer;
