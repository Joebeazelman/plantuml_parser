with PlantUML_AST;      use PlantUML_AST;
with UML_Model.Models;  use UML_Model.Models;
with UML_Model.Source;  use UML_Model.Source;

package PlantUML_To_Model is

   package Model_Results is new Results (Output_Type => Model);

   function To_Model (D : Diagram) return Model_Results.Result;

end PlantUML_To_Model;
