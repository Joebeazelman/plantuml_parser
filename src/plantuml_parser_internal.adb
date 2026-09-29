package body PlantUML_Parser_Internal is

   function Parse_To_AST (Source : String) return AST_Results.Result is
      pragma Unreferenced (Source);
   begin
      return AST_Results.Err
        (Make_Error (No_Location, "parser not yet implemented"));
   end Parse_To_AST;

end PlantUML_Parser_Internal;
