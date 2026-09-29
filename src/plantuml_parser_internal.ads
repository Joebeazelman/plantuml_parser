with PlantUML_AST;     use PlantUML_AST;
with UML_Model.Source; use UML_Model.Source;

package PlantUML_Parser_Internal is

   package AST_Results is new Results (Output_Type => Diagram);

   function Parse_To_AST (Source : String) return AST_Results.Result;

end PlantUML_Parser_Internal;
