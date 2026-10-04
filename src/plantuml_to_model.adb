with UML_Model;
with UML_Model.Class;         use UML_Model.Class;
with UML_Model.State_Machine; use UML_Model.State_Machine;

package body PlantUML_To_Model is

   function Classify_State_Kind (Pseudo : String) return State_Kind is
   begin
      if Pseudo = "start" then
         return Initial;
      elsif Pseudo = "end" then
         return Final;
      elsif Pseudo = "choice" then
         return Choice;
      elsif Pseudo = "fork" then
         return Fork;
      elsif Pseudo = "join" then
         return Join;
      elsif Pseudo = "history" then
         return History;
      else
         return Simple;
      end if;
   end Classify_State_Kind;

   function To_Visibility (Prefix : String) return Visibility is
   begin
      if Prefix'Length = 0 then
         return Public;
      end if;

      case Prefix (Prefix'First) is
         when '+'    =>
            return Public;

         when '-'    =>
            return Vis_Private;

         when '#'    =>
            return Vis_Protected;

         when '~'    =>
            return Package_Level;

         when others =>
            return Public;
      end case;
   end To_Visibility;

   function To_Model (D : Diagram) return Model_Results.Result is
      -- ... existing lowering logic ...
   begin
      return Model_Results.Ok (Empty_Model);
   end To_Model;

end PlantUML_To_Model;
