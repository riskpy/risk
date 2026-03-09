create or replace package body test_ora_codecop as

  procedure rule_check_occ_30010 is
    l_number_of_failures pls_integer;
  begin
    select count(*) into l_number_of_failures from occ.api.verification_result(i_rule_id_or_code => 'OCC-30010');
    ut.expect( a_actual => l_number_of_failures ).to_equal( a_expected => 0);
  end rule_check_occ_30010;

  procedure rule_check_occ_40010 is
    l_number_of_failures pls_integer;
  begin
    select count(*) into l_number_of_failures from occ.api.verification_result(i_rule_id_or_code => 'OCC-40010');
    ut.expect( a_actual => l_number_of_failures ).to_equal( a_expected => 0);
  end rule_check_occ_40010;

  procedure rule_check_occ_40020 is
    l_number_of_failures pls_integer;
  begin
    select count(*) into l_number_of_failures from occ.api.verification_result(i_rule_id_or_code => 'OCC-40020');
    ut.expect( a_actual => l_number_of_failures ).to_equal( a_expected => 0);
  end rule_check_occ_40020;

  procedure rule_check_occ_79010 is
    l_number_of_failures pls_integer;
  begin
    select count(*) into l_number_of_failures from occ.api.verification_result(i_rule_id_or_code => 'OCC-79010');
    ut.expect( a_actual => l_number_of_failures ).to_equal( a_expected => 0);
  end rule_check_occ_79010;

  procedure rule_check_occ_80010 is
    l_number_of_failures pls_integer;
  begin
    select count(*) into l_number_of_failures from occ.api.verification_result(i_rule_id_or_code => 'OCC-80010');
    ut.expect( a_actual => l_number_of_failures ).to_equal( a_expected => 0);
  end rule_check_occ_80010;

end test_ora_codecop;
/

