with Ada.Containers.Vectors;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with UML_Model.Source;      use UML_Model.Source;

package PlantUML_Lexer is

   type Token_Kind is
     (Kw_Class, Kw_State, Kw_Attr, Kw_Method,
      Kw_Start, Kw_End, Kw_Choice, Kw_Fork, Kw_Join, Kw_History,
      Ident, Number,
      L_Brace, R_Brace, Colon, Semicolon, Arrow,
      End_Of_Input, Unknown);

   type Token is record
      Kind     : Token_Kind      := Unknown;
      Text     : Unbounded_String;
      Location : Source_Location := No_Location;
   end record;

   package Token_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Token);
   use Token_Vectors;

   subtype Token_Vector is Token_Vectors.Vector;

   function Lex (Source : String) return Token_Vector;

end PlantUML_Lexer;
