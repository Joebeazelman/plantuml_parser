with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;  use Ada.Strings.Unbounded;

package PlantUML.Tokens is
   pragma Preelaborate;

   type Token_Kind is (Word, Str, Symbol, Arrow, Newline, Eof);

   type Token is record
      Kind         : Token_Kind := Eof;
      Text         : Unbounded_String;
      Line         : Positive := 1;
      Space_Before : Boolean := False;
   end record;

   package Vectors is new Ada.Containers.Vectors (Positive, Token);
   subtype List is Vectors.Vector;

   function Tokenize (Source : String) return List;
   Eof_Token : constant Token;

   type Cursor (Src : not null access constant List) is private;

   function  Make     (L : aliased in List) return Cursor;
   function  Peek     (C : Cursor) return Token;
   function  Peek_At  (C : Cursor; Ahead : Natural := 1) return Token;
   procedure Next     (C : in out Cursor);
   function  At_Eof   (C : Cursor) return Boolean;
   function  Position (C : Cursor) return Natural;
   function  Word_Is  (C : Cursor; S : String) return Boolean;
   function  Sym_Is   (C : Cursor; S : String) return Boolean;

   function Take (C : in out Cursor) return Token;
   function Take_If_Word_Is (C : in out Cursor; S : String) return Boolean;
   function Take_If_Sym_Is  (C : in out Cursor; S : String) return Boolean;

   procedure Skip_Newlines (C : in out Cursor);
   procedure Skip_To_End_Of_Line (C : in out Cursor);
   function Decode_Escapes (S : String) return String;

private
   type Cursor (Src : not null access constant List) is record
      I : Natural := 1;
   end record;

   Eof_Token : constant Token :=
     (Kind         => Eof,
      Text         => Null_Unbounded_String,
      Line         => 1,
      Space_Before => False);
end PlantUML.Tokens;
