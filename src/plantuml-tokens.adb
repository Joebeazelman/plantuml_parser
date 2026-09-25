package body PlantUML.Tokens is

   function Make_Eof_Token return Token is
   begin
      return
        (Kind         => Eof,
         Text         => Null_Unbounded_String,
         Line         => 1,
         Space_Before => False);
   end Make_Eof_Token;

   function Tokenize (Source : String) return List is
      R              : List;
      I              : Natural := Source'First;
      Line           : Positive := 1;
      Last_Was_Space : Boolean := False;

      procedure Emit (K : Token_Kind; S : String) is
         T : constant Token :=
           (Kind         => K,
            Text         => To_Unbounded_String (S),
            Line         => Line,
            Space_Before => Last_Was_Space);
      begin
         R.Append (T);
         Last_Was_Space := False;
      end Emit;

      function Is_Ident_Char (C : Character) return Boolean
      is (case C is
            when 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' | '$' => True,
            when others                                           => False);

      function Span_Ident return String is
         Start : constant Natural := I;
         J     : Natural := I;
      begin
         if J <= Source'Last and then Source (J) = '@' then
            J := J + 1;
         end if;
         while J <= Source'Last and then Is_Ident_Char (Source (J)) loop
            J := J + 1;
         end loop;
         I := J;
         return Source (Start .. J - 1);
      end Span_Ident;

      function Line_Starts_Comment (Src : String; Pos : Natural) return Boolean
      is
         J : Natural := Pos;
      begin
         while J > Src'First loop
            J := J - 1;
            exit when Src (J) = ASCII.LF;
            if Src (J) not in ' ' | ASCII.HT | ASCII.CR then
               return False;
            end if;
         end loop;
         return True;
      end Line_Starts_Comment;

      function Span_Arrow return String is
         Start : constant Natural := I;
         J     : Natural := I;
      begin
         while J <= Source'Last loop
            if Source (J) in '-' | '.' | 'o' | '*' | '<' | '>' | '|' | '/' then
               J := J + 1;
            else
               exit;
            end if;
         end loop;
         I := J;
         return Source (Start .. J - 1);
      end Span_Arrow;
   begin
      while I <= Source'Last loop
         declare
            C : constant Character := Source (I);
         begin
            if C = '@'
              and then I + 1 <= Source'Last
              and then Is_Ident_Char (Source (I + 1))
            then
               Emit (Word, Span_Ident);
            elsif Is_Ident_Char (C) then
               Emit (Word, Span_Ident);
            elsif C in ' ' | ASCII.HT | ASCII.LF | ASCII.CR then
               if C = ASCII.LF then
                  Emit (Newline, "");
                  Line := Line + 1;
               else
                  Last_Was_Space := True;
               end if;
               I := I + 1;
            elsif C = ''' and then Line_Starts_Comment (Source, I) then
               while I <= Source'Last and then Source (I) /= ASCII.LF loop
                  I := I + 1;
               end loop;
            elsif C = '"' then
               declare
                  Start : constant Natural := I + 1;
                  J     : Natural := Start;
               begin
                  while J <= Source'Last and then Source (J) /= '"' loop
                     J := J + 1;
                  end loop;
                  if J > Source'Last then
                     raise Parse_Error
                       with "Unterminated string at line" & Line'Image;
                  end if;
                  Emit (Str, Source (Start .. J - 1));
                  I := J + 1;
               end;
            elsif C in '-' | '.' | 'o' | '*' | '<' | '>' | '|' | '/' then
               declare
                  S : constant String := Span_Arrow;
               begin
                  Emit ((if S'Length >= 2 then Arrow else Symbol), S);
               end;
            else
               Emit (Symbol, String'[C]);
               I := I + 1;
            end if;
         end;
      end loop;
      Emit (Eof, "");
      return R;
   end Tokenize;

   function Make (L : aliased in List) return Cursor
   is ((Src => L'Unchecked_Access, I => 1));
   function Peek (C : Cursor) return Token
   is (if C.I <= Natural (C.Src.Length) then C.Src (C.I) else Make_Eof_Token);
   function Peek_At (C : Cursor; Ahead : Natural := 1) return Token is
      I : constant Natural := C.I + Ahead;
   begin
      return
        (if I <= Natural (C.Src.Length) then C.Src (I) else Make_Eof_Token);
   end Peek_At;
   procedure Next (C : in out Cursor) is
   begin
      C.I := C.I + 1;
   end Next;
   function At_Eof (C : Cursor) return Boolean
   is (Peek (C).Kind = Eof);
   function Position (C : Cursor) return Natural
   is (C.I);
   function Word_Is (C : Cursor; S : String) return Boolean
   is (declare
         T : constant Token := Peek (C);
       begin
         T.Kind = Word and then To_String (T.Text) = S);
   function Sym_Is (C : Cursor; S : String) return Boolean
   is (declare
         T : constant Token := Peek (C);
       begin
         T.Kind = Symbol and then To_String (T.Text) = S);

   function Take (C : in out Cursor) return Token is
      T : constant Token := Peek (C);
   begin
      Next (C);
      return T;
   end Take;

   function Take_If_Word_Is (C : in out Cursor; S : String) return Boolean is
   begin
      if Word_Is (C, S) then
         Next (C);
         return True;
      end if;
      return False;
   end Take_If_Word_Is;

   function Take_If_Sym_Is (C : in out Cursor; S : String) return Boolean is
   begin
      if Sym_Is (C, S) then
         Next (C);
         return True;
      end if;
      return False;
   end Take_If_Sym_Is;

   procedure Skip_Newlines (C : in out Cursor) is
   begin
      while Peek (C).Kind = Newline loop
         Next (C);
      end loop;
   end Skip_Newlines;

   procedure Skip_To_End_Of_Line (C : in out Cursor) is
   begin
      while Peek (C).Kind not in Newline | Eof loop
         Next (C);
      end loop;
   end Skip_To_End_Of_Line;

   function Decode_Escapes (S : String) return String is
      N : Natural := 0;
   begin
      if S'Length = 0 then
         return "";
      end if;
      for I in S'First .. S'Last - 1 loop
         if S (I) = '\' and then S (I + 1) = 'n' then
            N := N + 1;
         end if;
      end loop;
      declare
         R : String (1 .. S'Length - N);
         J : Natural := 1;
         I : Natural := S'First;
      begin
         while I <= S'Last loop
            if S (I) = '\' and then I < S'Last and then S (I + 1) = 'n' then
               R (J) := ASCII.LF;
               J := J + 1;
               I := I + 2;
            else
               R (J) := S (I);
               J := J + 1;
               I := I + 1;
            end if;
         end loop;
         return R;
      end;
   end Decode_Escapes;

end PlantUML.Tokens;
