with AUnit.Test_Suites;
with PlantUML_Parser_Tests.Test_Lexer;
with PlantUML_Parser_Tests.Test_Parse;

package body PlantUML_Parser_Tests.Suite is

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test (Test_Lexer.Suite);
      Result.Add_Test (Test_Parse.Suite);
      return Result;
   end Suite;

end PlantUML_Parser_Tests.Suite;
