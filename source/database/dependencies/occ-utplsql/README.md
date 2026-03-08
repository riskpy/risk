# occ-utplsql
[utPLSQL](https://www.utplsql.org/) converter for __ora* CODECOP__ framework. See [OCC](https://github.com/yerba1704/occ) for more information.

## Example usage

The syntax for the procedure `ut_package` in package `utplsql` is:

``````sql
procedure ut_package(
      i_package_name   in varchar2 default 'UT_ORA_CODECOP',
      i_create_package in boolean  default false,
      i_print_source   in boolean  default true);
``````

To see the full package source code for a unit test package containing all rules simple run:

`exec occ.utplsql.ut_package;`

To install a unit test package without the default name and without printing  to DBMS_OUTPUT run:
``````plsql
begin
  occ.utplsql.ut_package(i_package_name => 'OCC_UNIT_TEST',
                         i_create_package => true,
                         i_print_source => false);
end;
``````

Execute the whole suite or a special test as described in the [utPLSQL documentation](https://www.utplsql.org/utPLSQL/latest/userguide/running-unit-tests.html).

![Example](occ-utplsql.gif?raw=true "utPLSQL converter for ora* CODECOP")

## Installation

Before you install the package please verify that [utPLSQL](https://www.utplsql.org/) and [OCC](https://github.com/yerba1704/occ) is successfully installed.

The script `admin_install.sql` will install the package `utplsql` and grant execute permission to public.

To remove the package run the script `admin_uninstall.sql`.

## Version History

November 1, 2023

- public release
