pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__test_main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__test_main.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is

   E011 : Short_Integer; pragma Import (Ada, E011, "ada__exceptions_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E024 : Short_Integer; pragma Import (Ada, E024, "system__exception_table_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exceptions_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__soft_links__initialize_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "ada__io_exceptions_E");
   E054 : Short_Integer; pragma Import (Ada, E054, "ada__strings_E");
   E056 : Short_Integer; pragma Import (Ada, E056, "ada__strings__utf_encoding_E");
   E176 : Short_Integer; pragma Import (Ada, E176, "gnat_E");
   E092 : Short_Integer; pragma Import (Ada, E092, "interfaces__c_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "system__os_lib_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "ada__tags_E");
   E053 : Short_Integer; pragma Import (Ada, E053, "ada__strings__text_buffers_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "ada__streams_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "system__file_control_block_E");
   E152 : Short_Integer; pragma Import (Ada, E152, "system__finalization_root_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "ada__finalization_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "system__file_io_E");
   E175 : Short_Integer; pragma Import (Ada, E175, "system__storage_pools_E");
   E182 : Short_Integer; pragma Import (Ada, E182, "system__storage_pools__subpools_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "ada__calendar_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "ada__text_io_E");
   E108 : Short_Integer; pragma Import (Ada, E108, "ada__strings__maps_E");
   E190 : Short_Integer; pragma Import (Ada, E190, "ada__strings__unbounded_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "system__pool_global_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "aunit_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "aunit__memory_E");
   E087 : Short_Integer; pragma Import (Ada, E087, "aunit__memory__utils_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "ada_containers__aunit_lists_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "aunit__tests_E");
   E104 : Short_Integer; pragma Import (Ada, E104, "aunit__time_measure_E");
   E102 : Short_Integer; pragma Import (Ada, E102, "aunit__test_results_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "aunit__assertions_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "aunit__test_filters_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "aunit__simple_test_cases_E");
   E220 : Short_Integer; pragma Import (Ada, E220, "aunit__reporter_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "aunit__reporter__text_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "aunit__test_cases_E");
   E082 : Short_Integer; pragma Import (Ada, E082, "aunit__test_suites_E");
   E227 : Short_Integer; pragma Import (Ada, E227, "aunit__run_E");
   E188 : Short_Integer; pragma Import (Ada, E188, "test_classes_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "test_states_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "test_tokens_E");
   E076 : Short_Integer; pragma Import (Ada, E076, "all_tests_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E216 := E216 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "test_tokens__finalize_spec");
      begin
         if E216 = 0 then
            F1;
         end if;
      end;
      E210 := E210 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "test_states__finalize_spec");
      begin
         if E210 = 0 then
            F2;
         end if;
      end;
      E188 := E188 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "test_classes__finalize_spec");
      begin
         if E188 = 0 then
            F3;
         end if;
      end;
      E082 := E082 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "aunit__test_suites__finalize_spec");
      begin
         if E082 = 0 then
            F4;
         end if;
      end;
      E202 := E202 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "aunit__test_cases__finalize_spec");
      begin
         if E202 = 0 then
            F5;
         end if;
      end;
      E222 := E222 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "aunit__reporter__text__finalize_spec");
      begin
         if E222 = 0 then
            F6;
         end if;
      end;
      E096 := E096 - 1;
      E098 := E098 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "aunit__simple_test_cases__finalize_spec");
      begin
         if E098 = 0 then
            F7;
         end if;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "aunit__test_filters__finalize_spec");
      begin
         if E096 = 0 then
            F8;
         end if;
      end;
      E100 := E100 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "aunit__assertions__finalize_spec");
      begin
         if E100 = 0 then
            F9;
         end if;
      end;
      E102 := E102 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "aunit__test_results__finalize_spec");
      begin
         if E102 = 0 then
            F10;
         end if;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "aunit__tests__finalize_spec");
      begin
         E169 := E169 - 1;
         if E169 = 0 then
            F11;
         end if;
      end;
      E171 := E171 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "system__pool_global__finalize_spec");
      begin
         if E171 = 0 then
            F12;
         end if;
      end;
      E190 := E190 - 1;
      declare
         procedure F13;
         pragma Import (Ada, F13, "ada__strings__unbounded__finalize_spec");
      begin
         if E190 = 0 then
            F13;
         end if;
      end;
      E138 := E138 - 1;
      declare
         procedure F14;
         pragma Import (Ada, F14, "ada__text_io__finalize_spec");
      begin
         if E138 = 0 then
            F14;
         end if;
      end;
      E182 := E182 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "system__storage_pools__subpools__finalize_spec");
      begin
         if E182 = 0 then
            F15;
         end if;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "system__file_io__finalize_body");
      begin
         E149 := E149 - 1;
         if E149 = 0 then
            F16;
         end if;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
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

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      if E011 = 0 then
         Ada.Exceptions'Elab_Spec;
      end if;
      if E015 = 0 then
         System.Soft_Links'Elab_Spec;
      end if;
      if E024 = 0 then
         System.Exception_Table'Elab_Body;
      end if;
      E024 := E024 + 1;
      if E025 = 0 then
         System.Exceptions'Elab_Spec;
      end if;
      E025 := E025 + 1;
      if E017 = 0 then
         System.Soft_Links.Initialize'Elab_Body;
      end if;
      E017 := E017 + 1;
      E015 := E015 + 1;
      E011 := E011 + 1;
      if E141 = 0 then
         Ada.Io_Exceptions'Elab_Spec;
      end if;
      E141 := E141 + 1;
      if E054 = 0 then
         Ada.Strings'Elab_Spec;
      end if;
      E054 := E054 + 1;
      if E056 = 0 then
         Ada.Strings.Utf_Encoding'Elab_Spec;
      end if;
      E056 := E056 + 1;
      if E176 = 0 then
         Gnat'Elab_Spec;
      end if;
      E176 := E176 + 1;
      if E092 = 0 then
         Interfaces.C'Elab_Spec;
      end if;
      E092 := E092 + 1;
      if E118 = 0 then
         System.Os_Lib'Elab_Body;
      end if;
      E118 := E118 + 1;
      if E064 = 0 then
         Ada.Tags'Elab_Spec;
      end if;
      if E064 = 0 then
         Ada.Tags'Elab_Body;
      end if;
      E064 := E064 + 1;
      if E053 = 0 then
         Ada.Strings.Text_Buffers'Elab_Spec;
      end if;
      E053 := E053 + 1;
      if E140 = 0 then
         Ada.Streams'Elab_Spec;
      end if;
      E140 := E140 + 1;
      if E153 = 0 then
         System.File_Control_Block'Elab_Spec;
      end if;
      E153 := E153 + 1;
      if E152 = 0 then
         System.Finalization_Root'Elab_Spec;
      end if;
      E152 := E152 + 1;
      if E150 = 0 then
         Ada.Finalization'Elab_Spec;
      end if;
      E150 := E150 + 1;
      if E149 = 0 then
         System.File_Io'Elab_Body;
      end if;
      E149 := E149 + 1;
      if E175 = 0 then
         System.Storage_Pools'Elab_Spec;
      end if;
      E175 := E175 + 1;
      if E182 = 0 then
         System.Storage_Pools.Subpools'Elab_Spec;
      end if;
      E182 := E182 + 1;
      if E116 = 0 then
         Ada.Calendar'Elab_Spec;
      end if;
      if E116 = 0 then
         Ada.Calendar'Elab_Body;
      end if;
      E116 := E116 + 1;
      if E138 = 0 then
         Ada.Text_Io'Elab_Spec;
      end if;
      if E138 = 0 then
         Ada.Text_Io'Elab_Body;
      end if;
      E138 := E138 + 1;
      if E108 = 0 then
         Ada.Strings.Maps'Elab_Spec;
      end if;
      E108 := E108 + 1;
      if E190 = 0 then
         Ada.Strings.Unbounded'Elab_Spec;
      end if;
      E190 := E190 + 1;
      if E171 = 0 then
         System.Pool_Global'Elab_Spec;
      end if;
      E171 := E171 + 1;
      E080 := E080 + 1;
      E078 := E078 + 1;
      E087 := E087 + 1;
      E084 := E084 + 1;
      if E169 = 0 then
         Aunit.Tests'Elab_Spec;
      end if;
      E169 := E169 + 1;
      if E104 = 0 then
         Aunit.Time_Measure'Elab_Spec;
      end if;
      E104 := E104 + 1;
      if E102 = 0 then
         Aunit.Test_Results'Elab_Spec;
      end if;
      E102 := E102 + 1;
      if E100 = 0 then
         Aunit.Assertions'Elab_Spec;
      end if;
      if E100 = 0 then
         Aunit.Assertions'Elab_Body;
      end if;
      E100 := E100 + 1;
      if E096 = 0 then
         Aunit.Test_Filters'Elab_Spec;
      end if;
      if E098 = 0 then
         Aunit.Simple_Test_Cases'Elab_Spec;
      end if;
      E098 := E098 + 1;
      E096 := E096 + 1;
      if E220 = 0 then
         Aunit.Reporter'Elab_Spec;
      end if;
      E220 := E220 + 1;
      if E222 = 0 then
         Aunit.Reporter.Text'Elab_Spec;
      end if;
      E222 := E222 + 1;
      if E202 = 0 then
         Aunit.Test_Cases'Elab_Spec;
      end if;
      E202 := E202 + 1;
      if E082 = 0 then
         Aunit.Test_Suites'Elab_Spec;
      end if;
      E082 := E082 + 1;
      E227 := E227 + 1;
      if E188 = 0 then
         Test_Classes'Elab_Spec;
      end if;
      if E188 = 0 then
         Test_Classes'Elab_Body;
      end if;
      E188 := E188 + 1;
      if E210 = 0 then
         Test_States'Elab_Spec;
      end if;
      if E210 = 0 then
         Test_States'Elab_Body;
      end if;
      E210 := E210 + 1;
      if E216 = 0 then
         Test_Tokens'Elab_Spec;
      end if;
      if E216 = 0 then
         Test_Tokens'Elab_Body;
      end if;
      E216 := E216 + 1;
      E076 := E076 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_test_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/tests/test_classes.o
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/tests/test_states.o
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/tests/test_tokens.o
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/tests/all_tests.o
   --   /Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/tests/test_main.o
   --   -L/Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/tests/
   --   -L/Users/manuelbarros/Projects/ai-generated/plantuml_parser/obj/tests/
   --   -L/Users/manuelbarros/.local/share/alire/builds/aunit_23.0.0_84ce7d0b/c7d2d3946a9f4db393078f76bdd765207c7ecb1cb4501e646254fd6d2ff8f3f3/lib/aunit/native-full/
   --   -L/Users/manuelbarros/Projects/ai-generated/plantuml_parser/lib/
   --   -L/users/manuelbarros/.local/share/alire/toolchains/gnat_native_16.1.0_657cf254/lib/gcc/aarch64-apple-darwin24.6.0/16.1.0/adalib/
   --   -static
   --   -lgnat
--  END Object file/option list   

end ada_main;
