--  TODO: implement per the design discussion.
package body PlantUML_Lexer is
   function Lex (Source : String) return Token_Vector is
      pragma Unreferenced (Source);
      Result : Token_Vector;
   begin
      Result.Append ((Kind => End_Of_Input,
                      Text => Null_Unbounded_String,
                      Location => No_Location));
      return Result;
   end Lex;
end PlantUML_Lexer;
