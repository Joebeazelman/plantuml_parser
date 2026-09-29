with PlantUML_Parser_Internal;
with PlantUML_To_Model;

package body PlantUML_Parser is

   function Parse (Source : String) return Parse_Results.Result is
      AST_Res   : constant PlantUML_Parser_Internal.AST_Results.Result :=
        PlantUML_Parser_Internal.Parse_To_AST (Source);
      Model_Res : PlantUML_To_Model.Model_Results.Result;
   begin
      if not AST_Res.Success then
         return Parse_Results.Err (AST_Res.Error);
      end if;

      Model_Res := PlantUML_To_Model.To_Model (AST_Res.Output);

      if not Model_Res.Success then
         return Parse_Results.Err (Model_Res.Error);
      end if;

      return Parse_Results.Ok (Model_Res.Output);
   end Parse;

end PlantUML_Parser;
