with Ada.Containers.Vectors;

package UML.Model.Queries is
   pragma Preelaborate;

   function Find_By_Id (D : UML.Model.Diagram; Name : String) return UML.Model.Element_Index;
   function Require_By_Id (D : UML.Model.Diagram; Name : String) return UML.Model.Element_Index;

   function Region_Of (D : UML.Model.Diagram; Idx : UML.Model.Element_Index) return Natural;
   function States_In (D : UML.Model.Diagram; Region : Natural) return UML.Model.Element_Index_Vectors.Vector;
   function Is_Composite (D : UML.Model.Diagram; Idx : UML.Model.Element_Index) return Boolean;
   function Composite_Children_Of (D : UML.Model.Diagram; States : UML.Model.Element_Index_Vectors.Vector)
                                   return UML.Model.Element_Index_Vectors.Vector;

   function Transitions_In (D : UML.Model.Diagram; Region : Natural) return UML.Model.Relation_Vectors.Vector;
   function Is_History (D : UML.Model.Diagram; Idx : UML.Model.Element_Index) return Boolean;

   function Parents_Of (D : UML.Model.Diagram; Idx : UML.Model.Element_Index) return UML.Model.Relation_Vectors.Vector;
   function Associations_From (D : UML.Model.Diagram; Idx : UML.Model.Element_Index) return UML.Model.Relation_Vectors.Vector;
   function Has_Parent_Method (D : UML.Model.Diagram; Idx : UML.Model.Element_Index; Sanitized_Method_Name : String) return Boolean;

   function Title_Of (D : UML.Model.Diagram) return String;
   function Notes_Of (D : UML.Model.Diagram) return String;

   type Region_Cache is private;
   function Build_Cache (D : UML.Model.Diagram) return Region_Cache;
   function Region_Of (Cache : Region_Cache; Idx : UML.Model.Element_Index) return Natural;
   function Transitions_In (Cache : Region_Cache; D : UML.Model.Diagram; Region : Natural)
                            return UML.Model.Relation_Vectors.Vector;

private
   package Natural_Vectors is new Ada.Containers.Vectors (Positive, Natural);
   type Region_Cache is record
      Regions : Natural_Vectors.Vector;
   end record;

   --  Metadata helpers
   function Title_Line_Of (D : UML.Model.Diagram) return String;
   function Notes_Header_Of (D : UML.Model.Diagram) return String;

   --  Cached regions
   type Region_Cache is private;
   function Build (D : UML.Model.Diagram) return Region_Cache;
   function Region_Of (Cache : Region_Cache; Idx : UML.Model.Element_Index) return Natural;
   function Transitions_In (Cache : Region_Cache; D : UML.Model.Diagram; Region : Natural)
                            return UML.Model.Relation_Vectors.Vector;

private
   package Natural_Vectors is new Ada.Containers.Vectors (Positive, Natural);
   type Region_Cache is record
      Regions : Natural_Vectors.Vector;
   end record;

end UML.Model.Queries;
