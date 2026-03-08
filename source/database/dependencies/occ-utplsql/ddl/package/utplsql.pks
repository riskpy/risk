create or replace package utplsql authid current_user as

  procedure ut_package(
      i_package_name   in varchar2 default 'UT_ORA_CODECOP',
      i_create_package in boolean  default false,
      i_print_source   in boolean  default true);

end utplsql;
/