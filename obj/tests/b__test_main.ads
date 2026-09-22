pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: 16.1.0" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   GNAT_Version_Address : constant System.Address := GNAT_Version'Address;
   pragma Export (C, GNAT_Version_Address, "__gnat_version_address");

   Ada_Main_Program_Name : constant String := "_ada_test_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#c0fd487f#;
   pragma Export (C, u00001, "test_mainB");
   u00002 : constant Version_32 := 16#b2cfab41#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#986fbd5a#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#60337ee1#;
   pragma Export (C, u00005, "ada__command_lineB");
   u00006 : constant Version_32 := 16#3cdef8c9#;
   pragma Export (C, u00006, "ada__command_lineS");
   u00007 : constant Version_32 := 16#8a611ac3#;
   pragma Export (C, u00007, "systemS");
   u00008 : constant Version_32 := 16#33935a56#;
   pragma Export (C, u00008, "system__secondary_stackB");
   u00009 : constant Version_32 := 16#b0931c82#;
   pragma Export (C, u00009, "system__secondary_stackS");
   u00010 : constant Version_32 := 16#6ce3be0f#;
   pragma Export (C, u00010, "ada__exceptionsB");
   u00011 : constant Version_32 := 16#0fa7c4bb#;
   pragma Export (C, u00011, "ada__exceptionsS");
   u00012 : constant Version_32 := 16#85bf25f7#;
   pragma Export (C, u00012, "ada__exceptions__last_chance_handlerB");
   u00013 : constant Version_32 := 16#c1262c0b#;
   pragma Export (C, u00013, "ada__exceptions__last_chance_handlerS");
   u00014 : constant Version_32 := 16#7fa0a598#;
   pragma Export (C, u00014, "system__soft_linksB");
   u00015 : constant Version_32 := 16#acdd2381#;
   pragma Export (C, u00015, "system__soft_linksS");
   u00016 : constant Version_32 := 16#0286ce9f#;
   pragma Export (C, u00016, "system__soft_links__initializeB");
   u00017 : constant Version_32 := 16#ac2e8b53#;
   pragma Export (C, u00017, "system__soft_links__initializeS");
   u00018 : constant Version_32 := 16#3007a9ef#;
   pragma Export (C, u00018, "system__parametersB");
   u00019 : constant Version_32 := 16#2bcfb19f#;
   pragma Export (C, u00019, "system__parametersS");
   u00020 : constant Version_32 := 16#8599b27b#;
   pragma Export (C, u00020, "system__stack_checkingB");
   u00021 : constant Version_32 := 16#4d3e0fd5#;
   pragma Export (C, u00021, "system__stack_checkingS");
   u00022 : constant Version_32 := 16#46bfce2b#;
   pragma Export (C, u00022, "system__storage_elementsS");
   u00023 : constant Version_32 := 16#45e1965e#;
   pragma Export (C, u00023, "system__exception_tableB");
   u00024 : constant Version_32 := 16#074a6cda#;
   pragma Export (C, u00024, "system__exception_tableS");
   u00025 : constant Version_32 := 16#b8c4a5f1#;
   pragma Export (C, u00025, "system__exceptionsS");
   u00026 : constant Version_32 := 16#c367aa24#;
   pragma Export (C, u00026, "system__exceptions__machineB");
   u00027 : constant Version_32 := 16#8d1d496c#;
   pragma Export (C, u00027, "system__exceptions__machineS");
   u00028 : constant Version_32 := 16#2f7ce883#;
   pragma Export (C, u00028, "system__exceptions_debugB");
   u00029 : constant Version_32 := 16#ba6f4290#;
   pragma Export (C, u00029, "system__exceptions_debugS");
   u00030 : constant Version_32 := 16#1d4109f1#;
   pragma Export (C, u00030, "system__img_intS");
   u00031 : constant Version_32 := 16#5c7d9c20#;
   pragma Export (C, u00031, "system__tracebackB");
   u00032 : constant Version_32 := 16#0cfbee7e#;
   pragma Export (C, u00032, "system__tracebackS");
   u00033 : constant Version_32 := 16#5f6b6486#;
   pragma Export (C, u00033, "system__traceback_entriesB");
   u00034 : constant Version_32 := 16#427da54f#;
   pragma Export (C, u00034, "system__traceback_entriesS");
   u00035 : constant Version_32 := 16#727e0fa1#;
   pragma Export (C, u00035, "system__traceback__symbolicB");
   u00036 : constant Version_32 := 16#3e2e1203#;
   pragma Export (C, u00036, "system__traceback__symbolicS");
   u00037 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00037, "ada__exceptions__tracebackB");
   u00038 : constant Version_32 := 16#47e3d2a3#;
   pragma Export (C, u00038, "ada__exceptions__tracebackS");
   u00039 : constant Version_32 := 16#f9910acc#;
   pragma Export (C, u00039, "system__address_imageB");
   u00040 : constant Version_32 := 16#2b8d87f9#;
   pragma Export (C, u00040, "system__address_imageS");
   u00041 : constant Version_32 := 16#bfdff066#;
   pragma Export (C, u00041, "system__img_address_32S");
   u00042 : constant Version_32 := 16#9111f9c1#;
   pragma Export (C, u00042, "interfacesS");
   u00043 : constant Version_32 := 16#92ff51e4#;
   pragma Export (C, u00043, "system__img_address_64S");
   u00044 : constant Version_32 := 16#fd158a37#;
   pragma Export (C, u00044, "system__wch_conB");
   u00045 : constant Version_32 := 16#536239a0#;
   pragma Export (C, u00045, "system__wch_conS");
   u00046 : constant Version_32 := 16#5c289972#;
   pragma Export (C, u00046, "system__wch_stwB");
   u00047 : constant Version_32 := 16#7e7315a1#;
   pragma Export (C, u00047, "system__wch_stwS");
   u00048 : constant Version_32 := 16#7cd63de5#;
   pragma Export (C, u00048, "system__wch_cnvB");
   u00049 : constant Version_32 := 16#55a2f3d0#;
   pragma Export (C, u00049, "system__wch_cnvS");
   u00050 : constant Version_32 := 16#e538de43#;
   pragma Export (C, u00050, "system__wch_jisB");
   u00051 : constant Version_32 := 16#e01591fa#;
   pragma Export (C, u00051, "system__wch_jisS");
   u00052 : constant Version_32 := 16#a201b8c5#;
   pragma Export (C, u00052, "ada__strings__text_buffersB");
   u00053 : constant Version_32 := 16#a7cfd09b#;
   pragma Export (C, u00053, "ada__strings__text_buffersS");
   u00054 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00054, "ada__stringsS");
   u00055 : constant Version_32 := 16#8b7604c4#;
   pragma Export (C, u00055, "ada__strings__utf_encodingB");
   u00056 : constant Version_32 := 16#c9e86997#;
   pragma Export (C, u00056, "ada__strings__utf_encodingS");
   u00057 : constant Version_32 := 16#bb780f45#;
   pragma Export (C, u00057, "ada__strings__utf_encoding__stringsB");
   u00058 : constant Version_32 := 16#b85ff4b6#;
   pragma Export (C, u00058, "ada__strings__utf_encoding__stringsS");
   u00059 : constant Version_32 := 16#d1d1ed0b#;
   pragma Export (C, u00059, "ada__strings__utf_encoding__wide_stringsB");
   u00060 : constant Version_32 := 16#5678478f#;
   pragma Export (C, u00060, "ada__strings__utf_encoding__wide_stringsS");
   u00061 : constant Version_32 := 16#c2b98963#;
   pragma Export (C, u00061, "ada__strings__utf_encoding__wide_wide_stringsB");
   u00062 : constant Version_32 := 16#d7af3358#;
   pragma Export (C, u00062, "ada__strings__utf_encoding__wide_wide_stringsS");
   u00063 : constant Version_32 := 16#df45aed8#;
   pragma Export (C, u00063, "ada__tagsB");
   u00064 : constant Version_32 := 16#99822aba#;
   pragma Export (C, u00064, "ada__tagsS");
   u00065 : constant Version_32 := 16#3548d972#;
   pragma Export (C, u00065, "system__htableB");
   u00066 : constant Version_32 := 16#0bb84228#;
   pragma Export (C, u00066, "system__htableS");
   u00067 : constant Version_32 := 16#1f1abe38#;
   pragma Export (C, u00067, "system__string_hashB");
   u00068 : constant Version_32 := 16#acfdc257#;
   pragma Export (C, u00068, "system__string_hashS");
   u00069 : constant Version_32 := 16#704b659a#;
   pragma Export (C, u00069, "system__unsigned_typesS");
   u00070 : constant Version_32 := 16#159aaf05#;
   pragma Export (C, u00070, "system__val_lluS");
   u00071 : constant Version_32 := 16#0d1904b9#;
   pragma Export (C, u00071, "system__val_utilB");
   u00072 : constant Version_32 := 16#66caf8e0#;
   pragma Export (C, u00072, "system__val_utilS");
   u00073 : constant Version_32 := 16#8b956324#;
   pragma Export (C, u00073, "system__case_util_nssB");
   u00074 : constant Version_32 := 16#ef0e9ee9#;
   pragma Export (C, u00074, "system__case_util_nssS");
   u00075 : constant Version_32 := 16#29eb3f2b#;
   pragma Export (C, u00075, "all_testsB");
   u00076 : constant Version_32 := 16#583d7673#;
   pragma Export (C, u00076, "all_testsS");
   u00077 : constant Version_32 := 16#da678b2c#;
   pragma Export (C, u00077, "aunitB");
   u00078 : constant Version_32 := 16#76cdf7c6#;
   pragma Export (C, u00078, "aunitS");
   u00079 : constant Version_32 := 16#b6c145a2#;
   pragma Export (C, u00079, "aunit__memoryB");
   u00080 : constant Version_32 := 16#5c9dbc43#;
   pragma Export (C, u00080, "aunit__memoryS");
   u00081 : constant Version_32 := 16#276e73f2#;
   pragma Export (C, u00081, "aunit__test_suitesB");
   u00082 : constant Version_32 := 16#50924664#;
   pragma Export (C, u00082, "aunit__test_suitesS");
   u00083 : constant Version_32 := 16#41ca688d#;
   pragma Export (C, u00083, "ada_containers__aunit_listsB");
   u00084 : constant Version_32 := 16#c8d9569a#;
   pragma Export (C, u00084, "ada_containers__aunit_listsS");
   u00085 : constant Version_32 := 16#11329e00#;
   pragma Export (C, u00085, "ada_containersS");
   u00086 : constant Version_32 := 16#9b1c7ff2#;
   pragma Export (C, u00086, "aunit__memory__utilsB");
   u00087 : constant Version_32 := 16#fb2f6c57#;
   pragma Export (C, u00087, "aunit__memory__utilsS");
   u00088 : constant Version_32 := 16#8e328749#;
   pragma Export (C, u00088, "system__finalization_primitivesB");
   u00089 : constant Version_32 := 16#a30892a3#;
   pragma Export (C, u00089, "system__finalization_primitivesS");
   u00090 : constant Version_32 := 16#afd63177#;
   pragma Export (C, u00090, "system__os_locksS");
   u00091 : constant Version_32 := 16#b9ada65a#;
   pragma Export (C, u00091, "interfaces__cB");
   u00092 : constant Version_32 := 16#610373b9#;
   pragma Export (C, u00092, "interfaces__cS");
   u00093 : constant Version_32 := 16#1311b8a5#;
   pragma Export (C, u00093, "system__os_constantsS");
   u00094 : constant Version_32 := 16#e99cd447#;
   pragma Export (C, u00094, "aunit__optionsS");
   u00095 : constant Version_32 := 16#e9d6512d#;
   pragma Export (C, u00095, "aunit__test_filtersB");
   u00096 : constant Version_32 := 16#9a67cba8#;
   pragma Export (C, u00096, "aunit__test_filtersS");
   u00097 : constant Version_32 := 16#6e9501f4#;
   pragma Export (C, u00097, "aunit__simple_test_casesB");
   u00098 : constant Version_32 := 16#5a323d45#;
   pragma Export (C, u00098, "aunit__simple_test_casesS");
   u00099 : constant Version_32 := 16#f1db610e#;
   pragma Export (C, u00099, "aunit__assertionsB");
   u00100 : constant Version_32 := 16#f6326ff1#;
   pragma Export (C, u00100, "aunit__assertionsS");
   u00101 : constant Version_32 := 16#b891ec3b#;
   pragma Export (C, u00101, "aunit__test_resultsB");
   u00102 : constant Version_32 := 16#c2a99f30#;
   pragma Export (C, u00102, "aunit__test_resultsS");
   u00103 : constant Version_32 := 16#737bafa8#;
   pragma Export (C, u00103, "aunit__time_measureB");
   u00104 : constant Version_32 := 16#eb2e5d34#;
   pragma Export (C, u00104, "aunit__time_measureS");
   u00105 : constant Version_32 := 16#eab62ba6#;
   pragma Export (C, u00105, "ada__strings__fixedB");
   u00106 : constant Version_32 := 16#f9c1b568#;
   pragma Export (C, u00106, "ada__strings__fixedS");
   u00107 : constant Version_32 := 16#9a8aed35#;
   pragma Export (C, u00107, "ada__strings__mapsB");
   u00108 : constant Version_32 := 16#879d83f1#;
   pragma Export (C, u00108, "ada__strings__mapsS");
   u00109 : constant Version_32 := 16#d55f7fbe#;
   pragma Export (C, u00109, "system__bit_opsB");
   u00110 : constant Version_32 := 16#4792b6ff#;
   pragma Export (C, u00110, "system__bit_opsS");
   u00111 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00111, "ada__charactersS");
   u00112 : constant Version_32 := 16#cde9ea2d#;
   pragma Export (C, u00112, "ada__characters__latin_1S");
   u00113 : constant Version_32 := 16#28efec31#;
   pragma Export (C, u00113, "ada__strings__searchB");
   u00114 : constant Version_32 := 16#7f896bb3#;
   pragma Export (C, u00114, "ada__strings__searchS");
   u00115 : constant Version_32 := 16#9fbfddeb#;
   pragma Export (C, u00115, "ada__calendarB");
   u00116 : constant Version_32 := 16#c907a168#;
   pragma Export (C, u00116, "ada__calendarS");
   u00117 : constant Version_32 := 16#861c956a#;
   pragma Export (C, u00117, "system__os_libB");
   u00118 : constant Version_32 := 16#b4b4641d#;
   pragma Export (C, u00118, "system__os_libS");
   u00119 : constant Version_32 := 16#94d23d25#;
   pragma Export (C, u00119, "system__atomic_operations__test_and_setB");
   u00120 : constant Version_32 := 16#57acee8e#;
   pragma Export (C, u00120, "system__atomic_operations__test_and_setS");
   u00121 : constant Version_32 := 16#4d0260e6#;
   pragma Export (C, u00121, "system__atomic_operationsS");
   u00122 : constant Version_32 := 16#553a519e#;
   pragma Export (C, u00122, "system__atomic_primitivesB");
   u00123 : constant Version_32 := 16#b0203cad#;
   pragma Export (C, u00123, "system__atomic_primitivesS");
   u00124 : constant Version_32 := 16#14fb286b#;
   pragma Export (C, u00124, "system__case_utilB");
   u00125 : constant Version_32 := 16#5499fba9#;
   pragma Export (C, u00125, "system__case_utilS");
   u00126 : constant Version_32 := 16#22b1fb99#;
   pragma Export (C, u00126, "system__crtlB");
   u00127 : constant Version_32 := 16#a9f4d4a9#;
   pragma Export (C, u00127, "system__crtlS");
   u00128 : constant Version_32 := 16#256dbbe5#;
   pragma Export (C, u00128, "system__stringsB");
   u00129 : constant Version_32 := 16#11e31adb#;
   pragma Export (C, u00129, "system__stringsS");
   u00130 : constant Version_32 := 16#fb4ecb85#;
   pragma Export (C, u00130, "system__os_primitivesB");
   u00131 : constant Version_32 := 16#8d9c7f35#;
   pragma Export (C, u00131, "system__os_primitivesS");
   u00132 : constant Version_32 := 16#75266e31#;
   pragma Export (C, u00132, "system__c_timeB");
   u00133 : constant Version_32 := 16#f6136865#;
   pragma Export (C, u00133, "system__c_timeS");
   u00134 : constant Version_32 := 16#4f37e837#;
   pragma Export (C, u00134, "aunit__ioS");
   u00135 : constant Version_32 := 16#f64b89a4#;
   pragma Export (C, u00135, "ada__integer_text_ioB");
   u00136 : constant Version_32 := 16#b4dc53db#;
   pragma Export (C, u00136, "ada__integer_text_ioS");
   u00137 : constant Version_32 := 16#c7620b41#;
   pragma Export (C, u00137, "ada__text_ioB");
   u00138 : constant Version_32 := 16#46a4a696#;
   pragma Export (C, u00138, "ada__text_ioS");
   u00139 : constant Version_32 := 16#6e6e3f5b#;
   pragma Export (C, u00139, "ada__streamsB");
   u00140 : constant Version_32 := 16#bd793559#;
   pragma Export (C, u00140, "ada__streamsS");
   u00141 : constant Version_32 := 16#367911c4#;
   pragma Export (C, u00141, "ada__io_exceptionsS");
   u00142 : constant Version_32 := 16#44f765f3#;
   pragma Export (C, u00142, "system__put_imagesB");
   u00143 : constant Version_32 := 16#9a7e9601#;
   pragma Export (C, u00143, "system__put_imagesS");
   u00144 : constant Version_32 := 16#22b9eb9f#;
   pragma Export (C, u00144, "ada__strings__text_buffers__utilsB");
   u00145 : constant Version_32 := 16#89062ac3#;
   pragma Export (C, u00145, "ada__strings__text_buffers__utilsS");
   u00146 : constant Version_32 := 16#1cacf006#;
   pragma Export (C, u00146, "interfaces__c_streamsB");
   u00147 : constant Version_32 := 16#ecfa876a#;
   pragma Export (C, u00147, "interfaces__c_streamsS");
   u00148 : constant Version_32 := 16#a94e7662#;
   pragma Export (C, u00148, "system__file_ioB");
   u00149 : constant Version_32 := 16#ec2e4f85#;
   pragma Export (C, u00149, "system__file_ioS");
   u00150 : constant Version_32 := 16#7598b591#;
   pragma Export (C, u00150, "ada__finalizationS");
   u00151 : constant Version_32 := 16#d00f339c#;
   pragma Export (C, u00151, "system__finalization_rootB");
   u00152 : constant Version_32 := 16#801d2417#;
   pragma Export (C, u00152, "system__finalization_rootS");
   u00153 : constant Version_32 := 16#e0daad44#;
   pragma Export (C, u00153, "system__file_control_blockS");
   u00154 : constant Version_32 := 16#5e511f79#;
   pragma Export (C, u00154, "ada__text_io__generic_auxB");
   u00155 : constant Version_32 := 16#d2ac8a2d#;
   pragma Export (C, u00155, "ada__text_io__generic_auxS");
   u00156 : constant Version_32 := 16#4396993d#;
   pragma Export (C, u00156, "system__img_biuS");
   u00157 : constant Version_32 := 16#0ec85ee3#;
   pragma Export (C, u00157, "system__img_llbS");
   u00158 : constant Version_32 := 16#b2148485#;
   pragma Export (C, u00158, "system__img_lliS");
   u00159 : constant Version_32 := 16#7939ab91#;
   pragma Export (C, u00159, "system__img_lllbS");
   u00160 : constant Version_32 := 16#3e33b3e2#;
   pragma Export (C, u00160, "system__img_llliS");
   u00161 : constant Version_32 := 16#734db29d#;
   pragma Export (C, u00161, "system__img_lllwS");
   u00162 : constant Version_32 := 16#52fa2be8#;
   pragma Export (C, u00162, "system__img_llwS");
   u00163 : constant Version_32 := 16#7c4c220f#;
   pragma Export (C, u00163, "system__img_wiuS");
   u00164 : constant Version_32 := 16#53662346#;
   pragma Export (C, u00164, "system__val_intS");
   u00165 : constant Version_32 := 16#bfedde8f#;
   pragma Export (C, u00165, "system__val_unsS");
   u00166 : constant Version_32 := 16#d99d7fee#;
   pragma Export (C, u00166, "system__val_lliS");
   u00167 : constant Version_32 := 16#7a326f52#;
   pragma Export (C, u00167, "system__val_llliS");
   u00168 : constant Version_32 := 16#9d47d53b#;
   pragma Export (C, u00168, "system__val_llluS");
   u00169 : constant Version_32 := 16#6b6cea8f#;
   pragma Export (C, u00169, "aunit__testsS");
   u00170 : constant Version_32 := 16#02e43f40#;
   pragma Export (C, u00170, "system__pool_globalB");
   u00171 : constant Version_32 := 16#928ad74c#;
   pragma Export (C, u00171, "system__pool_globalS");
   u00172 : constant Version_32 := 16#a56a70fa#;
   pragma Export (C, u00172, "system__memoryB");
   u00173 : constant Version_32 := 16#92f586d9#;
   pragma Export (C, u00173, "system__memoryS");
   u00174 : constant Version_32 := 16#9969561e#;
   pragma Export (C, u00174, "system__storage_poolsB");
   u00175 : constant Version_32 := 16#0a664c89#;
   pragma Export (C, u00175, "system__storage_poolsS");
   u00176 : constant Version_32 := 16#b5988c27#;
   pragma Export (C, u00176, "gnatS");
   u00177 : constant Version_32 := 16#f299cac9#;
   pragma Export (C, u00177, "gnat__source_infoS");
   u00178 : constant Version_32 := 16#931654a0#;
   pragma Export (C, u00178, "gnat__tracebackB");
   u00179 : constant Version_32 := 16#5a251c57#;
   pragma Export (C, u00179, "gnat__tracebackS");
   u00180 : constant Version_32 := 16#6baa1603#;
   pragma Export (C, u00180, "gnat__traceback__symbolicS");
   u00181 : constant Version_32 := 16#36601f03#;
   pragma Export (C, u00181, "system__storage_pools__subpoolsB");
   u00182 : constant Version_32 := 16#219014ff#;
   pragma Export (C, u00182, "system__storage_pools__subpoolsS");
   u00183 : constant Version_32 := 16#20ec7aa3#;
   pragma Export (C, u00183, "system__ioB");
   u00184 : constant Version_32 := 16#1423ed8c#;
   pragma Export (C, u00184, "system__ioS");
   u00185 : constant Version_32 := 16#3676fd0b#;
   pragma Export (C, u00185, "system__storage_pools__subpools__finalizationB");
   u00186 : constant Version_32 := 16#4c972977#;
   pragma Export (C, u00186, "system__storage_pools__subpools__finalizationS");
   u00187 : constant Version_32 := 16#1701d748#;
   pragma Export (C, u00187, "test_classesB");
   u00188 : constant Version_32 := 16#2e0b7d21#;
   pragma Export (C, u00188, "test_classesS");
   u00189 : constant Version_32 := 16#7e321c90#;
   pragma Export (C, u00189, "ada__strings__unboundedB");
   u00190 : constant Version_32 := 16#d6cc3e91#;
   pragma Export (C, u00190, "ada__strings__unboundedS");
   u00191 : constant Version_32 := 16#49d4c8e0#;
   pragma Export (C, u00191, "system__return_stackS");
   u00192 : constant Version_32 := 16#52627794#;
   pragma Export (C, u00192, "system__atomic_countersB");
   u00193 : constant Version_32 := 16#5679f500#;
   pragma Export (C, u00193, "system__atomic_countersS");
   u00194 : constant Version_32 := 16#72726776#;
   pragma Export (C, u00194, "system__stream_attributesB");
   u00195 : constant Version_32 := 16#3bf21799#;
   pragma Export (C, u00195, "system__stream_attributesS");
   u00196 : constant Version_32 := 16#c027a94e#;
   pragma Export (C, u00196, "system__stream_attributes__xdrB");
   u00197 : constant Version_32 := 16#35ff530d#;
   pragma Export (C, u00197, "system__stream_attributes__xdrS");
   u00198 : constant Version_32 := 16#4953c5af#;
   pragma Export (C, u00198, "system__fat_fltS");
   u00199 : constant Version_32 := 16#6f61cca2#;
   pragma Export (C, u00199, "system__fat_lfltS");
   u00200 : constant Version_32 := 16#15b16248#;
   pragma Export (C, u00200, "system__fat_llfS");
   u00201 : constant Version_32 := 16#4c5eed8b#;
   pragma Export (C, u00201, "aunit__test_casesB");
   u00202 : constant Version_32 := 16#1aa5f28d#;
   pragma Export (C, u00202, "aunit__test_casesS");
   u00203 : constant Version_32 := 16#ca878138#;
   pragma Export (C, u00203, "system__concat_2B");
   u00204 : constant Version_32 := 16#3f9a6934#;
   pragma Export (C, u00204, "system__concat_2S");
   u00205 : constant Version_32 := 16#23ed4b26#;
   pragma Export (C, u00205, "test_statesB");
   u00206 : constant Version_32 := 16#f275de7b#;
   pragma Export (C, u00206, "test_statesS");
   u00207 : constant Version_32 := 16#752a67ed#;
   pragma Export (C, u00207, "system__concat_3B");
   u00208 : constant Version_32 := 16#001b0361#;
   pragma Export (C, u00208, "system__concat_3S");
   u00209 : constant Version_32 := 16#81964754#;
   pragma Export (C, u00209, "test_tokensB");
   u00210 : constant Version_32 := 16#fd755474#;
   pragma Export (C, u00210, "test_tokensS");
   u00211 : constant Version_32 := 16#bd1125e3#;
   pragma Export (C, u00211, "aunit__reporterB");
   u00212 : constant Version_32 := 16#7beb347d#;
   pragma Export (C, u00212, "aunit__reporterS");
   u00213 : constant Version_32 := 16#b61e55fe#;
   pragma Export (C, u00213, "aunit__reporter__textB");
   u00214 : constant Version_32 := 16#1676cc84#;
   pragma Export (C, u00214, "aunit__reporter__textS");
   u00215 : constant Version_32 := 16#27732c71#;
   pragma Export (C, u00215, "system__arith_64B");
   u00216 : constant Version_32 := 16#7b93f0f5#;
   pragma Export (C, u00216, "system__arith_64S");
   u00217 : constant Version_32 := 16#6bdd46b3#;
   pragma Export (C, u00217, "system__exn_intS");
   u00218 : constant Version_32 := 16#4d723195#;
   pragma Export (C, u00218, "aunit__runB");
   u00219 : constant Version_32 := 16#dc46304b#;
   pragma Export (C, u00219, "aunit__runS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.atomic_operations%s
   --  system.case_util_nss%s
   --  system.case_util_nss%b
   --  system.io%s
   --  system.io%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  system.crtl%b
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.storage_elements%s
   --  system.img_address_32%s
   --  system.img_address_64%s
   --  system.return_stack%s
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.unsigned_types%s
   --  system.img_biu%s
   --  system.img_llb%s
   --  system.img_lllb%s
   --  system.img_lllw%s
   --  system.img_llw%s
   --  system.img_wiu%s
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.exn_int%s
   --  system.img_int%s
   --  system.img_lli%s
   --  system.img_llli%s
   --  system.traceback%s
   --  system.traceback%b
   --  system.secondary_stack%s
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.soft_links%s
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  system.address_image%s
   --  system.address_image%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  system.exceptions%s
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  system.memory%s
   --  system.memory%b
   --  system.secondary_stack%b
   --  system.soft_links.initialize%s
   --  system.soft_links.initialize%b
   --  system.soft_links%b
   --  system.standard_library%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  ada.command_line%s
   --  ada.command_line%b
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.strings.utf_encoding%s
   --  ada.strings.utf_encoding%b
   --  ada.strings.utf_encoding.strings%s
   --  ada.strings.utf_encoding.strings%b
   --  ada.strings.utf_encoding.wide_strings%s
   --  ada.strings.utf_encoding.wide_strings%b
   --  ada.strings.utf_encoding.wide_wide_strings%s
   --  ada.strings.utf_encoding.wide_wide_strings%b
   --  gnat%s
   --  gnat.source_info%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.arith_64%s
   --  system.arith_64%b
   --  system.atomic_primitives%s
   --  system.atomic_primitives%b
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.atomic_operations.test_and_set%s
   --  system.atomic_operations.test_and_set%b
   --  system.case_util%s
   --  system.case_util%b
   --  system.fat_flt%s
   --  system.fat_lflt%s
   --  system.fat_llf%s
   --  system.os_constants%s
   --  system.c_time%s
   --  system.c_time%b
   --  system.os_lib%s
   --  system.os_lib%b
   --  system.os_locks%s
   --  system.finalization_primitives%s
   --  system.finalization_primitives%b
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_lllu%s
   --  system.val_llli%s
   --  system.val_llu%s
   --  ada.tags%s
   --  ada.tags%b
   --  ada.strings.text_buffers%s
   --  ada.strings.text_buffers%b
   --  ada.strings.text_buffers.utils%s
   --  ada.strings.text_buffers.utils%b
   --  system.put_images%s
   --  system.put_images%b
   --  ada.streams%s
   --  ada.streams%b
   --  system.file_control_block%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  system.file_io%s
   --  system.file_io%b
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools.finalization%b
   --  system.storage_pools.subpools%b
   --  system.stream_attributes%s
   --  system.stream_attributes.xdr%s
   --  system.stream_attributes.xdr%b
   --  system.stream_attributes%b
   --  system.val_lli%s
   --  system.val_uns%s
   --  system.val_int%s
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  ada.text_io.generic_aux%s
   --  ada.text_io.generic_aux%b
   --  ada.integer_text_io%s
   --  ada.integer_text_io%b
   --  gnat.traceback%s
   --  gnat.traceback%b
   --  gnat.traceback.symbolic%s
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.strings.fixed%s
   --  ada.strings.fixed%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  ada_containers%s
   --  aunit%s
   --  aunit.memory%s
   --  aunit.memory%b
   --  aunit%b
   --  aunit.io%s
   --  aunit.memory.utils%s
   --  aunit.memory.utils%b
   --  ada_containers.aunit_lists%s
   --  ada_containers.aunit_lists%b
   --  aunit.tests%s
   --  aunit.time_measure%s
   --  aunit.time_measure%b
   --  aunit.test_results%s
   --  aunit.test_results%b
   --  aunit.assertions%s
   --  aunit.assertions%b
   --  aunit.test_filters%s
   --  aunit.options%s
   --  aunit.simple_test_cases%s
   --  aunit.simple_test_cases%b
   --  aunit.test_filters%b
   --  aunit.reporter%s
   --  aunit.reporter%b
   --  aunit.reporter.text%s
   --  aunit.reporter.text%b
   --  aunit.test_cases%s
   --  aunit.test_cases%b
   --  aunit.test_suites%s
   --  aunit.test_suites%b
   --  aunit.run%s
   --  aunit.run%b
   --  test_classes%s
   --  test_classes%b
   --  test_states%s
   --  test_states%b
   --  test_tokens%s
   --  test_tokens%b
   --  all_tests%s
   --  all_tests%b
   --  test_main%b
   --  END ELABORATION ORDER

end ada_main;
