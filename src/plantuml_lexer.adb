with Ada.Characters.Handling; use Ada.Characters.Handling;

package body PlantUML_Lexer is

   function Lex (Source : String) return Token_Vector is
      Cursor_Index : Natural := 0;
      Loc          : Source_Location := No_Location;
      Vec          : Token_Vector;

      function At_End return Boolean
      is (Cursor_Index >= Source'Length);

      function Peek return Character
      is (if At_End then ASCII.NUL else Source (Source'First + Cursor_Index));

      function Peek_Next return Character
      is (if Cursor_Index + 1 >= Source'Length
          then ASCII.NUL
          else Source (Source'First + Cursor_Index + 1));

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
         Cursor_Index := Cursor_Index + 1;
      end Advance;

      procedure Skip_Whitespace is
      begin
         while not At_End and then Peek in ' ' | ASCII.HT | ASCII.LF | ASCII.CR
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
         Advance;
         Advance;
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
        (Kind : Token_Kind; Text : String; Loc : Source_Location) return Token
      is ((Kind => Kind, Text => To_Unbounded_String (Text), Location => Loc));

      function Is_Arrow_Char (Ch : Character) return Boolean
      is (Ch in '-' | '.' | '>' | '|' | 'o' | '*');

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

      function Scan_Ident return Token is
         Start_Loc : constant Source_Location := Loc;
         Buf       : Unbounded_String;
      begin
         while not At_End and then (Is_Alphanumeric (Peek) or else Peek = '_')
         loop
            Append (Buf, Peek);
            Advance;
         end loop;
         return Make_Token (Ident, To_String (Buf), Start_Loc);
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

      function Scan_String return Token is
         Start_Loc : constant Source_Location := Loc;
         Buf       : Unbounded_String;
      begin
         Advance;
         while not At_End and then Peek /= '"' loop
            Append (Buf, Peek);
            Advance;
         end loop;
         if not At_End then
            Advance;
         end if;
         return Make_Token (String_Lit, To_String (Buf), Start_Loc);
      end Scan_String;

      procedure Emit_Punct (Kind : Token_Kind; Text : String) is
      begin
         Vec.Append (Make_Token (Kind, Text, Loc));
         Advance;
      end Emit_Punct;

   begin
      while not At_End loop
         Skip_Whitespace;
         if At_End then
            exit;
         end if;

         declare
            Ch : constant Character := Peek;
         begin
            if Ch = '/' and then Peek_Next = '/' then
               Skip_Line_Comment;
            elsif Ch = '/' and then Peek_Next = ''' then
               Skip_Block_Comment;
            elsif Is_Digit (Ch) then
               Vec.Append (Scan_Number);
            elsif Is_Letter (Ch) and then not (Ch in 'o' | '*') then
               Vec.Append (Scan_Ident);
            elsif Ch = '"' then
               Vec.Append (Scan_String);
            else
               case Ch is
                  when '-' | '.' | 'o' | '*' =>
                     declare
                        Is_Arrow_Start : constant Boolean :=
                          (Ch in '-' | '.')
                          or else (Is_Arrow_Char (Peek_Next));
                     begin
                        if Is_Arrow_Start then
                           declare
                              Save_Pos : constant Natural := Cursor_Index;
                              Save_Loc : constant Source_Location := Loc;
                              T        : constant Token := Scan_Arrow;
                              S        : constant String := To_String (T.Text);
                           begin
                              if S'Length >= 2
                                and then S (S'Last) in '>' | '-' | '.'
                              then
                                 Vec.Append (T);
                              else
                                 Cursor_Index := Save_Pos;
                                 Loc := Save_Loc;
                                 Emit_Punct (Unknown, [1 => Ch]);
                              end if;
                           end;
                        elsif Is_Letter (Ch) then
                           Vec.Append (Scan_Ident);
                        else
                           Emit_Punct (Unknown, [1 => Ch]);
                        end if;
                     end;

                  when ':'                   =>
                     Emit_Punct (Colon, ":");

                  when '{'                   =>
                     Emit_Punct (L_Brace, "{");

                  when '}'                   =>
                     Emit_Punct (R_Brace, "}");

                  when '('                   =>
                     Emit_Punct (L_Paren, "(");

                  when ')'                   =>
                     Emit_Punct (R_Paren, ")");

                  when others                =>
                     Emit_Punct (Unknown, [1 => Ch]);
               end case;
            end if;
         end;
      end loop;

      Vec.Append (Make_Token (End_Of_Input, "", Loc));
      return Vec;
   end Lex;

end PlantUML_Lexer;
