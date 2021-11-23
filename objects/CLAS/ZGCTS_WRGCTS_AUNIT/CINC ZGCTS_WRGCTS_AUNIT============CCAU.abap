*"* use this source file for your ABAP unit test classes
CLASS lcl_Wrgcts_Aunit_Test DEFINITION DEFERRED.
CLASS zgcts_Wrgcts_Aunit DEFINITION LOCAL FRIENDS lcl_Wrgcts_Aunit_Test.

CLASS lcl_Wrgcts_Aunit_Test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>lcl_Wrgcts_Aunit_Test
*?</TEST_CLASS>
*?<TEST_MEMBER>f_Cut
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>ZGCTS_WRGCTS_AUNIT
*?</OBJECT_UNDER_TEST>
*?<OBJECT_IS_LOCAL/>
*?<GENERATE_FIXTURE/>
*?<GENERATE_CLASS_FIXTURE/>
*?<GENERATE_INVOCATION/>
*?<GENERATE_ASSERT_EQUAL>X
*?</GENERATE_ASSERT_EQUAL>
*?</TESTCLASS_OPTIONS>
*?</asx:values>
*?</asx:abap>
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO zgcts_Wrgcts_Aunit.  "class under test

    METHODS: sum FOR TESTING.
ENDCLASS.       "lcl_Wrgcts_Aunit_Test


CLASS lcl_Wrgcts_Aunit_Test IMPLEMENTATION.

  METHOD sum.
    DATA: lo_object TYPE REF TO zgcts_wrgcts_aunit,
          lv_result TYPE i.

    CREATE OBJECT lo_object.
    lv_result = lo_object->sum( 3 ).
    cl_Abap_Unit_Assert=>assert_Equals(
      act   = lv_result
      exp   = 6
      msg   = '6 expected, but was not received'
    ).
  ENDMETHOD.




ENDCLASS.