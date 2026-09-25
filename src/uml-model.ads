with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;  use Ada.Strings.Unbounded;

package UML.Model is
   pragma Preelaborate;

   subtype Name is Unbounded_String;
   package Name_Vectors is new Ada.Containers.Vectors (Positive, Name);

   type Diagram_Kind is (Unknown, State_Diagram, Class_Diagram, Activity_Diagram);

   type Element_Kind is
     (State, Simple_State, Composite_State, Submachine_Reference,
      Class, Abstract_Class, Interface_Kind, Enumeration, Record_Type,
      Annotation_Type, Object, Package_Kind,
      Start_Pseudostate, End_Pseudostate, Choice, Fork, Join,
      History_Shallow, History_Deep, Entry_Point, Exit_Point,
      Attribute, Method, Enum_Literal, Nested_Class, Note_Element);

   type Annotation_Kind is (Entry_Action, Exit_Action, Do_Activity, Internal_Transition, Stereotype, Tag, Other);
   type Annotation is record
      Kind : Annotation_Kind := Other; Text : Name; Trigger : Name; Guard : Name;
   end record;
   package Annotation_Vectors is new Ada.Containers.Vectors (Positive, Annotation);

   type Note_Position is (Attached, Left_Of, Right_Of, Top_Of, Bottom_Of);
   type Element_Index is new Natural;
   type Note is record
      Text : Name; Subject : Element_Index := 0; Position : Note_Position := Attached;
   end record;
   package Note_Vectors is new Ada.Containers.Vectors (Positive, Note);

   type Metadata_Kind is (Title, Theme, Include, Directive, Other);
   type Metadata is record Kind : Metadata_Kind := Other; Text : Name; end record;
   package Metadata_Vectors is new Ada.Containers.Vectors (Positive, Metadata);

   type Visibility is (Public_Vis, Private_Vis, Protected_Vis, Package_Vis);
   type Member is record
      Kind : Element_Kind := Attribute; Id : Name; Type_Name : Name; Params : Name;
      Vis : Visibility := Public_Vis; Is_Static : Boolean := False; Is_Abstract : Boolean := False;
      Annotations : Annotation_Vectors.Vector;
   end record;
   package Member_Vectors is new Ada.Containers.Vectors (Positive, Member);

   package Element_Index_Vectors is new Ada.Containers.Vectors (Positive, Element_Index);

   --  REMOVED 'tagged' to save memory and prevent misuse (no polymorphic dispatch used)
   type Element is record
      Id : Name; Display : Name; Kind : Element_Kind := State;
      Annotations : Annotation_Vectors.Vector; Notes : Note_Vectors.Vector;
      Members : Member_Vectors.Vector; Children : Element_Index_Vectors.Vector;
      Parent : Element_Index := 0;
   end record;
   package Element_Vectors is new Ada.Containers.Vectors (Positive, Element);

   type Relation_Kind is (Transition, Internal_Transition_Kind, Completion, Inheritance,
      Realization, Composition, Aggregation, Association, Dependency, Link);
      
   --  REMOVED 'tagged'
   type Relation is record
      From, To : Element_Index := 0; Kind : Relation_Kind := Transition;
      Trigger : Name; Guard : Name; Effect : Name; Label : Name;
      Mult_From : Name; Mult_To : Name;
      Stereotypes : Name_Vectors.Vector; Notes : Note_Vectors.Vector;
   end record;
   package Relation_Vectors is new Ada.Containers.Vectors (Positive, Relation);

   type Diagram is tagged record
      Id : Name; Kind : Diagram_Kind := Unknown; Metadata : Metadata_Vectors.Vector;
      Elements : Element_Vectors.Vector; Roots : Element_Index_Vectors.Vector;
      Relations : Relation_Vectors.Vector; Notes : Note_Vectors.Vector;
   end record;

end UML.Model;
