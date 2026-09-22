pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package plantuml_parsermain is

   procedure plantuml_parserinit;
   pragma Export (C, plantuml_parserinit, "plantuml_parserinit");
   pragma Linker_Constructor (plantuml_parserinit);

   procedure plantuml_parserfinal;
   pragma Export (C, plantuml_parserfinal, "plantuml_parserfinal");
   pragma Linker_Destructor (plantuml_parserfinal);

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#24a1f41a#;
   pragma Export (C, u00001, "plantuml__classesB");
   u00002 : constant Version_32 := 16#1deab567#;
   pragma Export (C, u00002, "plantuml__classesS");
   u00003 : constant Version_32 := 16#eb13ba86#;
   pragma Export (C, u00003, "plantuml__statesB");
   u00004 : constant Version_32 := 16#844d96cc#;
   pragma Export (C, u00004, "plantuml__statesS");
   u00005 : constant Version_32 := 16#0e50cd1e#;
   pragma Export (C, u00005, "plantuml__to_modelB");
   u00006 : constant Version_32 := 16#b072128f#;
   pragma Export (C, u00006, "plantuml__to_modelS");
   u00007 : constant Version_32 := 16#89935591#;
   pragma Export (C, u00007, "plantuml__tokensB");
   u00008 : constant Version_32 := 16#cafb9d03#;
   pragma Export (C, u00008, "plantuml__tokensS");
   u00009 : constant Version_32 := 16#1a518ed3#;
   pragma Export (C, u00009, "plantumlB");
   u00010 : constant Version_32 := 16#18763fa3#;
   pragma Export (C, u00010, "plantumlS");
   u00011 : constant Version_32 := 16#914d1dd8#;
   pragma Export (C, u00011, "uml__model__queriesB");
   u00012 : constant Version_32 := 16#7870c8bd#;
   pragma Export (C, u00012, "uml__model__queriesS");
   u00013 : constant Version_32 := 16#898cf8d3#;
   pragma Export (C, u00013, "uml__modelS");
   u00014 : constant Version_32 := 16#cfbf3f2c#;
   pragma Export (C, u00014, "umlS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.case_util_nss%s
   --  system.case_util_nss%b
   --  system.io%s
   --  system.io%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  system.crtl%b
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
   --  system.img_int%s
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
   --  ada.assertions%s
   --  ada.assertions%b
   --  ada.containers%s
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
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.atomic_primitives%s
   --  system.atomic_primitives%b
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.fat_flt%s
   --  system.fat_lflt%s
   --  system.fat_llf%s
   --  system.os_constants%s
   --  system.os_locks%s
   --  system.finalization_primitives%s
   --  system.finalization_primitives%b
   --  system.val_util%s
   --  system.val_util%b
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
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  ada.containers.helpers%s
   --  ada.containers.helpers%b
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
   --  system.assertions%s
   --  system.assertions%b
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.maps.constants%s
   --  ada.characters.handling%s
   --  ada.characters.handling%b
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.strings.fixed%s
   --  ada.strings.fixed%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.strings.stream_ops%s
   --  system.strings.stream_ops%b
   --  uml%s
   --  uml.model%s
   --  plantuml%s
   --  plantuml.classes%s
   --  plantuml.states%s
   --  plantuml.to_model%s
   --  plantuml.to_model%b
   --  plantuml.tokens%s
   --  plantuml.tokens%b
   --  plantuml%b
   --  plantuml.classes%b
   --  plantuml.states%b
   --  uml.model.queries%s
   --  uml.model.queries%b
   --  END ELABORATION ORDER

end plantuml_parsermain;
