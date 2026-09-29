with Ada.Strings.Fixed;       use Ada.Strings.Fixed;
with Ada.Strings.Unbounded;   use Ada.Strings.Unbounded;
with UML_Model.Models;        use UML_Model.Models;
with UML_Model.Elements;      use UML_Model.Elements;
with UML_Model.Types;         use UML_Model.Types;
with UML_Model.Class;         use UML_Model.Class;
with UML_Model.State_Machine; use UML_Model.State_Machine;

package body PlantUML_To_Model is

   function To_Visibility (Prefix : String) return Visibility is
   begin
      if Prefix'Length = 0 then
         return Public;
      end if;
      case Prefix (Prefix'First) is
         when '+' => return Public;
         when '-' => return Vis_Private;
         when '#' => return Vis_Protected;
         when '~' => return Package_Level;
         when others => return Public;
      end case;
   end To_Visibility;

   function To_State_Kind (Pseudo : String) return State_Kind is
   begin
      if Pseudo = "start"     then return Initial;
      elsif Pseudo = "end"    then return Final;
      elsif Pseudo = "choice" then return Choice;
      elsif Pseudo = "fork"   then return Fork;
      elsif Pseudo = "join"   then return Join;
      elsif Pseudo = "history" then return History;
      else return Simple;
      end if;
   end To_State_Kind;

   function To_Relation_Kind (Arrow : String) return Relation_Kind is
   begin
      if Index (Arrow, "|>") > 0 then
         if Index (Arrow, "..") > 0 then
            return Realization;
         else
            return Inheritance;
         end if;
      elsif Index (Arrow, "o") > 0 then
         return Aggregation;
      elsif Index (Arrow, "*") > 0 then
         return Composition;
      else
         return Association;
      end if;
   end To_Relation_Kind;

   function To_Property (M : PlantUML_AST.Member) return Property is
      P : Property;
   begin
      P.Name         := Make_Identifier (To_String (M.Name));
      P.Of_Type      := Make_Type_Reference (To_String (M.Of_Type));
      P.Visibility   := To_Visibility (To_String (M.Vis));
      P.Stereotypes  := M.Stereotypes;
      P.Location     := M.Location;
      return P;
   end To_Property;

   function To_Operation (M : PlantUML_AST.Member) return Operation is
      O : Operation;
   begin
      O.Name         := Make_Identifier (To_String (M.Name));
      O.Return_Type  := Make_Type_Reference (To_String (M.Of_Type));
      O.Visibility   := To_Visibility (To_String (M.Vis));
      O.Stereotypes  := M.Stereotypes;
      O.Location     := M.Location;
      for P of M.Parameters loop
         declare
            Param : Property;
         begin
            Param.Name    := Make_Identifier (To_String (P.Name));
            Param.Of_Type := Make_Type_Reference (To_String (P.Of_Type));
            Param.Location := P.Location;
            O.Parameters.Append (Param);
         end;
      end loop;
      return O;
   end To_Operation;

   function To_Class_Model (C : PlantUML_AST.Class_Decl) return Class_Model is
      Result : Class_Model;
   begin
      Result.Name        := Make_Identifier (To_String (C.Name));
      Result.Stereotypes := C.Stereotypes;
      Result.Location    := C.Location;
      for M of C.Members loop
         case M.Kind is
            when PlantUML_AST.Attribute =>
               Result.Attributes.Append (To_Property (M));
            when PlantUML_AST.Method =>
               Result.Operations.Append (To_Operation (M));
         end case;
      end loop;
      return Result;
   end To_Class_Model;

   function To_Relation (R : PlantUML_AST.Relation_Decl) return Relation is
      Result : Relation;
   begin
      Result.Kind         := To_Relation_Kind (To_String (R.Kind));
      Result.Source       := Make_Identifier (To_String (R.Source));
      Result.Target       := Make_Identifier (To_String (R.Target));
      Result.Source_Role  := R.Source_Role;
      Result.Target_Role  := R.Target_Role;
      Result.Stereotypes  := R.Stereotypes;
      Result.Location     := R.Location;
      return Result;
   end To_Relation;

   function To_State (S : PlantUML_AST.State_Decl) return State is
      Result : State;
   begin
      Result.Name         := Make_Identifier (To_String (S.Name));
      Result.Kind         := To_State_Kind (To_String (S.Pseudo));
      Result.Parent       := Make_Identifier (To_String (S.Parent));
      Result.Entry_Action := Make_Fragment (To_String (S.Entry_Action),
                                            S.Location);
      Result.Exit_Action  := Make_Fragment (To_String (S.Exit_Action),
                                            S.Location);
      Result.Stereotypes  := S.Stereotypes;
      Result.Location     := S.Location;
      return Result;
   end To_State;

   function To_Transition (T : PlantUML_AST.Transition_Decl) return Transition is
      Result : Transition;
   begin
      Result.Source      := Make_Identifier (To_String (T.Source));
      Result.Target      := Make_Identifier (To_String (T.Target));
      Result.Event       := Make_Fragment (To_String (T.Event),  T.Location);
      Result.Guard       := Make_Fragment (To_String (T.Guard),  T.Location);
      Result.Action      := Make_Fragment (To_String (T.Action), T.Location);
      Result.Stereotypes := T.Stereotypes;
      Result.Location    := T.Location;
      return Result;
   end To_Transition;

   function To_Class_Diagram (D : PlantUML_AST.Diagram) return Model is
      Result : Model;
   begin
      for C of D.Classes loop
         Result.Classes.Append (To_Class_Model (C));
      end loop;
      for R of D.Relations loop
         Result.Relations.Append (To_Relation (R));
      end loop;
      return Result;
   end To_Class_Diagram;

   function To_State_Diagram (D : PlantUML_AST.Diagram) return Model is
      Chart  : State_Chart_Model;
      Result : Model;
   begin
      Chart.Name := Make_Identifier ("State_Machine");

      for S of D.States loop
         Chart.States.Append (To_State (S));
      end loop;

      for I in Chart.States.First_Index .. Chart.States.Last_Index loop
         declare
            Candidate : constant Identifier := Chart.States (I).Name;
         begin
            if Is_Valid (Candidate) then
               for J in Chart.States.First_Index .. Chart.States.Last_Index loop
                  if Chart.States (J).Parent = Candidate then
                     Chart.States (I).Kind := Composite;
                     exit;
                  end if;
               end loop;
            end if;
         end;
      end loop;

      for T of D.Transitions loop
         Chart.Transitions.Append (To_Transition (T));
      end loop;

      for S of Chart.States loop
         if S.Kind = Initial then
            Chart.Initial := S.Name;
            exit;
         end if;
      end loop;

      Result.State_Machines.Append (Chart);
      return Result;
   end To_State_Diagram;

   function To_Model (D : PlantUML_AST.Diagram)
     return Model_Results.Result
   is
   begin
      case D.Kind is
         when PlantUML_AST.Class_Diagram =>
            return Model_Results.Ok (To_Class_Diagram (D));
         when PlantUML_AST.State_Diagram =>
            return Model_Results.Ok (To_State_Diagram (D));
         when PlantUML_AST.Unknown =>
            return Model_Results.Err
              (Make_Error (D.Location,
                           "diagram kind could not be determined"));
      end case;
   end To_Model;

end PlantUML_To_Model;
