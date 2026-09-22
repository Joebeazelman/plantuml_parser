pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (plantuml_parsermain, Spec_File_Name => "b__plantuml_parser.ads");
pragma Source_File_Name (plantuml_parsermain, Body_File_Name => "b__plantuml_parser.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body plantuml_parsermain is

   E019 : Short_Integer; pragma Import (Ada, E019, "ada__exceptions_E");
   E024 : Short_Integer; pragma Import (Ada, E024, "system__soft_links_E");
   E035 : Short_Integer; pragma Import (Ada, E035, "system__exception_table_E");
   E036 : Short_Integer; pragma Import (Ada, E036, "system__exceptions_E");
   E031 : Short_Integer; pragma Import (Ada, E031, "system__soft_links__initialize_E");
   E132 : Short_Integer; pragma Import (Ada, E132, "ada__assertions_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ada__containers_E");
   E109 : Short_Integer; pragma Import (Ada, E109, "ada__io_exceptions_E");
   E063 : Short_Integer; pragma Import (Ada, E063, "ada__strings_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "ada__strings__utf_encoding_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "interfaces__c_E");
   E086 : Short_Integer; pragma Import (Ada, E086, "ada__tags_E");
   E076 : Short_Integer; pragma Import (Ada, E076, "ada__strings__text_buffers_E");
   E108 : Short_Integer; pragma Import (Ada, E108, "ada__streams_E");
   E115 : Short_Integer; pragma Import (Ada, E115, "system__finalization_root_E");
   E106 : Short_Integer; pragma Import (Ada, E106, "ada__finalization_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "system__storage_pools_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "system__storage_pools__subpools_E");
   E067 : Short_Integer; pragma Import (Ada, E067, "ada__strings__maps_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "ada__strings__maps__constants_E");
   E121 : Short_Integer; pragma Import (Ada, E121, "ada__strings__unbounded_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "system__pool_global_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "uml__model_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "plantuml_E");
   E002 : Short_Integer; pragma Import (Ada, E002, "plantuml__classes_E");
   E004 : Short_Integer; pragma Import (Ada, E004, "plantuml__states_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "plantuml__tokens_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E004 := E004 - 1;
      E002 := E002 - 1;
      E008 := E008 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "plantuml__tokens__finalize_spec");
      begin
         if E008 = 0 then
            F1;
         end if;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "plantuml__states__finalize_spec");
      begin
         if E004 = 0 then
            F2;
         end if;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "plantuml__classes__finalize_spec");
      begin
         if E002 = 0 then
            F3;
         end if;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "uml__model__finalize_spec");
      begin
         E013 := E013 - 1;
         if E013 = 0 then
            F4;
         end if;
      end;
      E134 := E134 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__pool_global__finalize_spec");
      begin
         if E134 = 0 then
            F5;
         end if;
      end;
      E121 := E121 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "ada__strings__unbounded__finalize_spec");
      begin
         if E121 = 0 then
            F6;
         end if;
      end;
      E142 := E142 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__storage_pools__subpools__finalize_spec");
      begin
         if E142 = 0 then
            F7;
         end if;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure plantuml_parserfinal is

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      finalize_library;
   end plantuml_parserfinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure plantuml_parserinit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");
      Interrupts_Default_To_System : Integer;
      pragma Import (C, Interrupts_Default_To_System, "__gl_interrupts_default_to_system");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      plantuml_parsermain'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      if E019 = 0 then
         Ada.Exceptions'Elab_Spec;
      end if;
      if E024 = 0 then
         System.Soft_Links'Elab_Spec;
      end if;
      if E035 = 0 then
         System.Exception_Table'Elab_Body;
      end if;
      E035 := E035 + 1;
      if E036 = 0 then
         System.Exceptions'Elab_Spec;
      end if;
      E036 := E036 + 1;
      if E031 = 0 then
         System.Soft_Links.Initialize'Elab_Body;
      end if;
      E031 := E031 + 1;
      E024 := E024 + 1;
      E019 := E019 + 1;
      if E132 = 0 then
         Ada.Assertions'Elab_Spec;
      end if;
      E132 := E132 + 1;
      if E103 = 0 then
         Ada.Containers'Elab_Spec;
      end if;
      E103 := E103 + 1;
      if E109 = 0 then
         Ada.Io_Exceptions'Elab_Spec;
      end if;
      E109 := E109 + 1;
      if E063 = 0 then
         Ada.Strings'Elab_Spec;
      end if;
      E063 := E063 + 1;
      if E078 = 0 then
         Ada.Strings.Utf_Encoding'Elab_Spec;
      end if;
      E078 := E078 + 1;
      if E100 = 0 then
         Interfaces.C'Elab_Spec;
      end if;
      E100 := E100 + 1;
      if E086 = 0 then
         Ada.Tags'Elab_Spec;
      end if;
      if E086 = 0 then
         Ada.Tags'Elab_Body;
      end if;
      E086 := E086 + 1;
      if E076 = 0 then
         Ada.Strings.Text_Buffers'Elab_Spec;
      end if;
      E076 := E076 + 1;
      if E108 = 0 then
         Ada.Streams'Elab_Spec;
      end if;
      E108 := E108 + 1;
      if E115 = 0 then
         System.Finalization_Root'Elab_Spec;
      end if;
      E115 := E115 + 1;
      if E106 = 0 then
         Ada.Finalization'Elab_Spec;
      end if;
      E106 := E106 + 1;
      if E140 = 0 then
         System.Storage_Pools'Elab_Spec;
      end if;
      E140 := E140 + 1;
      if E142 = 0 then
         System.Storage_Pools.Subpools'Elab_Spec;
      end if;
      E142 := E142 + 1;
      if E067 = 0 then
         Ada.Strings.Maps'Elab_Spec;
      end if;
      E067 := E067 + 1;
      if E157 = 0 then
         Ada.Strings.Maps.Constants'Elab_Spec;
      end if;
      E157 := E157 + 1;
      if E121 = 0 then
         Ada.Strings.Unbounded'Elab_Spec;
      end if;
      E121 := E121 + 1;
      if E134 = 0 then
         System.Pool_Global'Elab_Spec;
      end if;
      E134 := E134 + 1;
      if E013 = 0 then
         UML.MODEL'ELAB_SPEC;
      end if;
      E013 := E013 + 1;
      if E010 = 0 then
         Plantuml'Elab_Spec;
      end if;
      if E002 = 0 then
         Plantuml.Classes'Elab_Spec;
      end if;
      if E004 = 0 then
         Plantuml.States'Elab_Spec;
      end if;
      if E008 = 0 then
         Plantuml.Tokens'Elab_Spec;
      end if;
      E008 := E008 + 1;
      E010 := E010 + 1;
      E002 := E002 + 1;
      E004 := E004 + 1;
   end plantuml_parserinit;

--  BEGIN Object file/option list
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/uml.o
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/uml-model.o
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/plantuml-to_model.o
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/plantuml-tokens.o
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/plantuml.o
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/plantuml-classes.o
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/plantuml-states.o
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/uml-model-queries.o
   --   -L/Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/
   --   -L/users/manuelbarros/.local/share/alire/toolchains/gnat_native_16.1.0_657cf254/lib/gcc/aarch64-apple-darwin24.6.0/16.1.0/adalib/
   --   -static
   --   -lgnat
--  END Object file/option list   

end plantuml_parsermain;
