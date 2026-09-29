with UML_Model.Models;  use UML_Model.Models;
with UML_Model.Source;  use UML_Model.Source;

package PlantUML_Parser is

   package Parse_Results is new Results (Output_Type => Model);

   function Parse (Source : String) return Parse_Results.Result;

end PlantUML_Parser;
