create or replace package test_ora_codecop authid definer as

  --%suite(TEST_ORA_CODECOP)

  --%test(Verify the rule DESCRIPTION_FOR_ALL_DATA_OBJECTS (OCC-30010).)
  procedure rule_check_occ_30010;

  --%test(Verify the rule PARAMETER_NAMING_RULE (OCC-40010).)
  procedure rule_check_occ_40010;

  --%test(Verify the rule MAX_LINE_SIZE (OCC-40020).)
  procedure rule_check_occ_40020;

  --%test(Verify the rule TABLE_COMMENT (OCC-79010).)
  procedure rule_check_occ_79010;

  --%test(Verify the rule READONLY_CONSTRAINTS_FOR_VIEWS (OCC-80010).)
  procedure rule_check_occ_80010;

end test_ora_codecop;
/

