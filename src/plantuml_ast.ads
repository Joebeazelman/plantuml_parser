with Ada.Containers.Vectors;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with UML_Model.Elements;    use UML_Model.Elements;
with UML_Model.Source;      use UML_Model.Source;

package PlantUML_AST is

   type Member_Kind is (Attribute, Method);

   type Parameter is record
      Name     : Unbounded_String;
      Of_Type  : Unbounded_String;
      Location : Source_Location := No_Location;
   end record;

   package Parameter_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Parameter);
   use Parameter_Vectors;

   subtype Parameter_Vector is Parameter_Vectors.Vector;

   type Member is record
      Kind        : Member_Kind;
      Name        : Unbounded_String;
      Of_Type     : Unbounded_String;
      Vis         : Unbounded_String;
      Parameters  : Parameter_Vector;
      Stereotypes : Stereotype_Vector;
      Location    : Source_Location := No_Location;
   end record;

   package Member_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Member);
   use Member_Vectors;

   subtype Member_Vector is Member_Vectors.Vector;

   type Class_Decl is record
      Name        : Unbounded_String;
      Stereotypes : Stereotype_Vector;
      Members     : Member_Vector;
      Location    : Source_Location := No_Location;
   end record;

   package Class_Decl_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Class_Decl);
   use Class_Decl_Vectors;

   subtype Class_Decl_Vector is Class_Decl_Vectors.Vector;

   type Relation_Decl is record
      Kind        : Unbounded_String;
      Source      : Unbounded_String;
      Target      : Unbounded_String;
      Source_Role : Unbounded_String;
      Target_Role : Unbounded_String;
      Stereotypes : Stereotype_Vector;
      Location    : Source_Location := No_Location;
   end record;

   package Relation_Decl_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Relation_Decl);
   use Relation_Decl_Vectors;

   subtype Relation_Decl_Vector is Relation_Decl_Vectors.Vector;

   type State_Decl is record
      Name         : Unbounded_String;
      Pseudo       : Unbounded_String;
      Parent       : Unbounded_String;
      Entry_Action : Unbounded_String;
      Exit_Action  : Unbounded_String;
      Stereotypes  : Stereotype_Vector;
      Location     : Source_Location := No_Location;
   end record;

   package State_Decl_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => State_Decl);
   use State_Decl_Vectors;

   subtype State_Decl_Vector is State_Decl_Vectors.Vector;

   type Transition_Decl is record
      Source      : Unbounded_String;
      Target      : Unbounded_String;
      Event       : Unbounded_String;
      Guard       : Unbounded_String;
      Action      : Unbounded_String;
      Stereotypes : Stereotype_Vector;
      Location    : Source_Location := No_Location;
   end record;

   package Transition_Decl_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Transition_Decl);
   use Transition_Decl_Vectors;

   subtype Transition_Decl_Vector is Transition_Decl_Vectors.Vector;

   type Diagram_Kind is (Class_Diagram, State_Diagram, Unknown);

   type Diagram is record
      Kind        : Diagram_Kind := Unknown;
      Classes     : Class_Decl_Vector;
      Relations   : Relation_Decl_Vector;
      States      : State_Decl_Vector;
      Transitions : Transition_Decl_Vector;
      Location    : Source_Location := No_Location;
   end record;

end PlantUML_AST;
