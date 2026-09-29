with AUnit.Assertions;         use AUnit.Assertions;
with AUnit.Test_Cases;         use AUnit.Test_Cases;
with AUnit.Test_Suites;
with Ada.Strings.Unbounded;    use Ada.Strings.Unbounded;
with PlantUML_Parser;          use PlantUML_Parser;
with UML_Model.Class;          use UML_Model.Class;
with UML_Model.Elements;       use UML_Model.Elements;
with UML_Model.Models;         use UML_Model.Models;
with UML_Model.Source;         use UML_Model.Source;
with UML_Model.State_Machine;  use UML_Model.State_Machine;

package body PlantUML_Parser_Tests.Test_Parse is

   type Test is new Test_Case with null record;

   overriding function Name (T : Test) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Test);

   procedure Test_Class_With_Attribute (T : in out Test_Case'Class);
   procedure Test_Empty_Input (T : in out Test_Case'Class);
   procedure Test_Structured_Transition (T : in out Test_Case'Class);

   overriding function Name (T : Test) return AUnit.Message_String is
     (AUnit.Format ("PlantUML_Parser.Parse"));

   overriding procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Class_With_Attribute'Access,
                        "class with attribute parses");
      Register_Routine (T, Test_Empty_Input'Access,
                        "empty input is an error");
      Register_Routine (T, Test_Structured_Transition'Access,
                        "transition trigger splits into event/guard/action");
   end Register_Tests;

   procedure Test_Class_With_Attribute (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      Input : constant String :=
        "class Foo {" & ASCII.LF &
        "  + x : Integer;" & ASCII.LF &
        "}";
      Result : constant Parse_Results.Result := Parse (Input);
   begin
      Assert (Result.Success, "parse should succeed");
      if Result.Success then
         Assert (Natural (Result.Output.Classes.Length) = 1,
                 "one class");
         if not Result.Output.Classes.Is_Empty then
            declare
               C : constant Class_Model :=
                 Result.Output.Classes.Element (1);
            begin
               Assert (To_String (C.Name) = "Foo", "class name");
               Assert (Natural (C.Attributes.Length) = 1,
                       "one attribute");
               if not C.Attributes.Is_Empty then
                  Assert
                    (To_String (C.Attributes.Element (1).Name) = "x",
                     "attribute name");
               end if;
            end;
         end if;
      end if;
   end Test_Class_With_Attribute;

   procedure Test_Empty_Input (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      Result : constant Parse_Results.Result := Parse ("");
   begin
      Assert (not Result.Success, "empty input should fail");
   end Test_Empty_Input;

   procedure Test_Structured_Transition (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      Input : constant String :=
        "state Idle" & ASCII.LF &
        "state Running" & ASCII.LF &
        "Idle --> Running : start [count > 0] / reset";
      Result : constant Parse_Results.Result := Parse (Input);
   begin
      Assert (Result.Success, "parse should succeed");
      if not Result.Success then
         return;
      end if;

      Assert (Natural (Result.Output.State_Machines.Length) = 1,
              "one state machine");
      if Result.Output.State_Machines.Is_Empty then
         return;
      end if;

      declare
         Chart : constant State_Chart_Model :=
           Result.Output.State_Machines.Element (1);
      begin
         Assert (Natural (Chart.Transitions.Length) = 1,
                 "one transition");
         if Chart.Transitions.Is_Empty then
            return;
         end if;

         declare
            Tr : constant Transition := Chart.Transitions.Element (1);
         begin
            Assert (To_String (Tr.Event)  = "start",
                    "event = start, got '" & To_String (Tr.Event) & "'");
            Assert (To_String (Tr.Guard)  = "count > 0",
                    "guard = 'count > 0', got '" & To_String (Tr.Guard) & "'");
            Assert (To_String (Tr.Action) = "reset",
                    "action = reset, got '" & To_String (Tr.Action) & "'");
         end;
      end;
   end Test_Structured_Transition;

   The_Test : aliased Test;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test (The_Test'Access);
      return Result;
   end Suite;

end PlantUML_Parser_Tests.Test_Parse;
