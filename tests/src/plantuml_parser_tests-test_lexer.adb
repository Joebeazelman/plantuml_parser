with AUnit.Assertions;         use AUnit.Assertions;
with AUnit.Test_Cases;         use AUnit.Test_Cases;
with AUnit.Test_Suites;
with Ada.Strings.Unbounded;    use Ada.Strings.Unbounded;
with PlantUML_Lexer;           use PlantUML_Lexer;
with UML_Model.Source;         use UML_Model.Source;

package body PlantUML_Parser_Tests.Test_Lexer is

   type Test is new Test_Case with null record;

   overriding function Name (T : Test) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Test);

   procedure Test_Class_Keyword (T : in out Test_Case'Class);
   procedure Test_Arrow (T : in out Test_Case'Class);
   procedure Test_Location (T : in out Test_Case'Class);

   overriding function Name (T : Test) return AUnit.Message_String is
     (AUnit.Format ("PlantUML_Lexer"));

   overriding procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Class_Keyword'Access,
                        "'class' becomes Kw_Class");
      Register_Routine (T, Test_Arrow'Access,
                        "'-->' becomes an Arrow");
      Register_Routine (T, Test_Location'Access,
                        "locations track lines and columns");
   end Register_Tests;

   procedure Test_Class_Keyword (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      Toks : constant Token_Vector := Lex ("class");
   begin
      Assert (Natural (Toks.Length) >= 2, "at least one token + eof");
      Assert (Toks.Element (1).Kind = Kw_Class, "expected Kw_Class");
   end Test_Class_Keyword;

   procedure Test_Arrow (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      Toks : constant Token_Vector := Lex ("A --> B");
   begin
      Assert (Toks.Element (2).Kind = Arrow, "expected Arrow");
      Assert (To_String (Toks.Element (2).Text) = "-->",
              "expected -->");
   end Test_Arrow;

   procedure Test_Location (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      Toks : constant Token_Vector :=
        Lex ("A" & ASCII.LF & "B");
   begin
      Assert (Toks.Element (1).Location.Line = 1, "A on line 1");
      Assert (Toks.Element (2).Location.Line = 2, "B on line 2");
   end Test_Location;

   The_Test : aliased Test;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test (The_Test'Access);
      return Result;
   end Suite;

end PlantUML_Parser_Tests.Test_Lexer;
