with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body UML.Model.Queries is

   function Find_By_Id (D : UML.Model.Diagram; Name : String) return UML.Model.Element_Index is
   begin
      for I in D.Elements.First_Index .. D.Elements.Last_Index loop
         if To_String (D.Elements (I).Id) = Name then return UML.Model.Element_Index (I); end if;
      end loop;
      return 0;
   end Find_By_Id;

   function Require_By_Id (D : UML.Model.Diagram; Name : String) return UML.Model.Element_Index is
      Idx : constant UML.Model.Element_Index := Find_By_Id (D, Name);
   begin
      if Idx = 0 then raise Constraint_Error with "Element not found: " & Name; end if;
      return Idx;
   end Require_By_Id;

   function Region_Of (D : UML.Model.Diagram; Idx : UML.Model.Element_Index) return Natural is
      Curr : Natural := Natural (Idx);
   begin
      while Curr > 0 loop
         if Is_Composite (D, UML.Model.Element_Index (Curr)) then return Curr; end if;
         Curr := Natural (D.Elements (Curr).Parent);
      end loop;
      return 0;
   end Region_Of;

   function States_In (D : UML.Model.Diagram; Region : Natural) return UML.Model.Element_Index_Vectors.Vector is
      Result : UML.Model.Element_Index_Vectors.Vector;
   begin
      if Region = 0 then
         for R of D.Roots loop
            if D.Elements (Positive (R)).Kind not in UML.Model.Note_Element then
               Result.Append (R);
            end if;
         end loop;
      else
         for C of D.Elements (Positive (Region)).Children loop
            if D.Elements (Positive (C)).Kind not in UML.Model.Note_Element then
               Result.Append (C);
            end if;
         end loop;
      end if;
      return Result;
   end States_In;

   function Is_Composite (D : UML.Model.Diagram; Idx : UML.Model.Element_Index) return Boolean is
   begin
      if Idx = 0 then return False; end if;
      return D.Elements (Positive (Idx)).Kind in UML.Model.Composite_State | UML.Model.Package_Kind |
             UML.Model.Class | UML.Model.Abstract_Class | UML.Model.Interface_Kind |
             UML.Model.Enumeration | UML.Model.Record_Type | UML.Model.Annotation_Type | UML.Model.Object
        or else not D.Elements (Positive (Idx)).Children.Is_Empty;
   end Is_Composite;

   function Composite_Children_Of (D : UML.Model.Diagram; States : UML.Model.Element_Index_Vectors.Vector)
                                   return UML.Model.Element_Index_Vectors.Vector is
      Result : UML.Model.Element_Index_Vectors.Vector;
   begin
      for S of States loop
         if Is_Composite (D, S) then Result.Append (S); end if;
      end loop;
      return Result;
   end Composite_Children_Of;

   function Is_History (D : UML.Model.Diagram; Idx : UML.Model.Element_Index) return Boolean is
   begin
      return Idx > 0 and then D.Elements (Positive (Idx)).Kind in UML.Model.History_Shallow | UML.Model.History_Deep;
   end Is_History;

   function Transitions_In (D : UML.Model.Diagram; Region : Natural) return UML.Model.Relation_Vectors.Vector is
      Result : UML.Model.Relation_Vectors.Vector;
   begin
      for R of D.Relations loop
         if R.Kind in UML.Model.Transition | UML.Model.Internal_Transition_Kind | UML.Model.Completion then
            declare
               From_Reg : constant Natural := Region_Of (D, R.From);
               To_Reg   : constant Natural := Region_Of (D, R.To);
            begin
               if (From_Reg = Region and then To_Reg = Region) or else
                  (From_Reg = Region and then Is_History (D, R.To) and then To_Reg = Region)
               then Result.Append (R); end if;
            end;
         end if;
      end loop;
      return Result;
   end Transitions_In;

   function Parents_Of (D : UML.Model.Diagram; Idx : UML.Model.Element_Index) return UML.Model.Relation_Vectors.Vector is
      Result : UML.Model.Relation_Vectors.Vector;
   begin
      for R of D.Relations loop
         if R.Kind in UML.Model.Inheritance | UML.Model.Realization and then R.To = Idx then
            Result.Append (R);
         end if;
      end loop;
      return Result;
   end Parents_Of;

   function Associations_From (D : UML.Model.Diagram; Idx : UML.Model.Element_Index) return UML.Model.Relation_Vectors.Vector is
      Result : UML.Model.Relation_Vectors.Vector;
   begin
      for R of D.Relations loop
         if R.Kind in UML.Model.Composition | UML.Model.Aggregation | UML.Model.Association and then R.From = Idx then
            Result.Append (R);
         end if;
      end loop;
      return Result;
   end Associations_From;

   function Has_Parent_Method (D : UML.Model.Diagram; Idx : UML.Model.Element_Index; Sanitized_Method_Name : String) return Boolean is
   begin
      for R of Parents_Of (D, Idx) loop
         for M of D.Elements (Positive (R.From)).Members loop
            if M.Kind = UML.Model.Method and then To_String (M.Id) = Sanitized_Method_Name then
               return True;
            end if;
         end loop;
      end loop;
      return False;
   end Has_Parent_Method;

   function Title_Of (D : UML.Model.Diagram) return String is
   begin
      for M of D.Metadata loop
         if M.Kind = UML.Model.Title and then Length (M.Text) > 0 then
            return To_String (M.Text);
         end if;
      end loop;
      return "";
   end Title_Of;

   function Notes_Of (D : UML.Model.Diagram) return String is
      R     : Unbounded_String;
      First : Boolean := True;
   begin
      for N of D.Notes loop
         if not First then
            Append (R, ASCII.LF);
         end if;
         Append (R, N.Text);
         First := False;
      end loop;
      return To_String (R);
   end Notes_Of;

   function Build (D : UML.Model.Diagram) return Region_Cache is
      Result : Region_Cache;
   begin
      Result.Regions.Set_Length (D.Elements.Length);
      for I in D.Elements.First_Index .. D.Elements.Last_Index loop
         for C of D.Elements (I).Children loop
            Result.Regions (Positive (C)) := I;
         end loop;
      end loop;
      return Result;
   end Build_Cache;

   function Region_Of (Cache : Region_Cache; Idx : UML.Model.Element_Index) return Natural is
   begin
      if Idx = 0 or else Positive (Idx) > Natural (Cache.Regions.Length) then return 0; end if;
      return Cache.Regions (Positive (Idx));
   end Region_Of;

   function Transitions_In (Cache : Region_Cache; D : UML.Model.Diagram; Region : Natural)
                            return UML.Model.Relation_Vectors.Vector is
      Result : UML.Model.Relation_Vectors.Vector;
   begin
      for R of D.Relations loop
         if R.Kind in UML.Model.Transition | UML.Model.Internal_Transition_Kind | UML.Model.Completion then
            declare
               From_Reg : constant Natural := Region_Of (Cache, R.From);
               To_Reg   : constant Natural := Region_Of (Cache, R.To);
            begin
               if (From_Reg = Region and then To_Reg = Region) or else
                  (From_Reg = Region and then Is_History (D, R.To) and then To_Reg = Region)
               then Result.Append (R); end if;
            end;
         end if;
      end loop;
      return Result;
   end Transitions_In;

end UML.Model.Queries;
