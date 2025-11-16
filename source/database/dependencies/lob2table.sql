/*
* LOB2Table v1.2.4
* Copyright (c) 2015 - 2019, Michael Schmid. All rights reserved.
*
* This program is part of LOB2Table.
*
* LOB2Table is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* LOB2Table is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with LOB2Table. If not, see <http://www.gnu.org/licenses/>.
*/
create or replace type lob_row force as object(
  row_no    number(28),
  column1   varchar2(4000 byte),
  column2   varchar2(4000 byte),
  column3   varchar2(4000 byte),
  column4   varchar2(4000 byte),
  column5   varchar2(4000 byte),
  column6   varchar2(4000 byte),
  column7   varchar2(4000 byte),
  column8   varchar2(4000 byte),
  column9   varchar2(4000 byte),
  column10  varchar2(4000 byte),
  column11  varchar2(4000 byte),
  column12  varchar2(4000 byte),
  column13  varchar2(4000 byte),
  column14  varchar2(4000 byte),
  column15  varchar2(4000 byte),
  column16  varchar2(4000 byte),
  column17  varchar2(4000 byte),
  column18  varchar2(4000 byte),
  column19  varchar2(4000 byte),
  column20  varchar2(4000 byte),
  column21  varchar2(4000 byte),
  column22  varchar2(4000 byte),
  column23  varchar2(4000 byte),
  column24  varchar2(4000 byte),
  column25  varchar2(4000 byte),
  column26  varchar2(4000 byte),
  column27  varchar2(4000 byte),
  column28  varchar2(4000 byte),
  column29  varchar2(4000 byte),
  column30  varchar2(4000 byte),
  column31  varchar2(4000 byte),
  column32  varchar2(4000 byte),
  column33  varchar2(4000 byte),
  column34  varchar2(4000 byte),
  column35  varchar2(4000 byte),
  column36  varchar2(4000 byte),
  column37  varchar2(4000 byte),
  column38  varchar2(4000 byte),
  column39  varchar2(4000 byte),
  column40  varchar2(4000 byte),
  column41  varchar2(4000 byte),
  column42  varchar2(4000 byte),
  column43  varchar2(4000 byte),
  column44  varchar2(4000 byte),
  column45  varchar2(4000 byte),
  column46  varchar2(4000 byte),
  column47  varchar2(4000 byte),
  column48  varchar2(4000 byte),
  column49  varchar2(4000 byte),
  column50  varchar2(4000 byte),
  column51  varchar2(4000 byte),
  column52  varchar2(4000 byte),
  column53  varchar2(4000 byte),
  column54  varchar2(4000 byte),
  column55  varchar2(4000 byte),
  column56  varchar2(4000 byte),
  column57  varchar2(4000 byte),
  column58  varchar2(4000 byte),
  column59  varchar2(4000 byte),
  column60  varchar2(4000 byte),
  column61  varchar2(4000 byte),
  column62  varchar2(4000 byte),
  column63  varchar2(4000 byte),
  column64  varchar2(4000 byte),
  column65  varchar2(4000 byte),
  column66  varchar2(4000 byte),
  column67  varchar2(4000 byte),
  column68  varchar2(4000 byte),
  column69  varchar2(4000 byte),
  column70  varchar2(4000 byte),
  column71  varchar2(4000 byte),
  column72  varchar2(4000 byte),
  column73  varchar2(4000 byte),
  column74  varchar2(4000 byte),
  column75  varchar2(4000 byte),
  column76  varchar2(4000 byte),
  column77  varchar2(4000 byte),
  column78  varchar2(4000 byte),
  column79  varchar2(4000 byte),
  column80  varchar2(4000 byte),
  column81  varchar2(4000 byte),
  column82  varchar2(4000 byte),
  column83  varchar2(4000 byte),
  column84  varchar2(4000 byte),
  column85  varchar2(4000 byte),
  column86  varchar2(4000 byte),
  column87  varchar2(4000 byte),
  column88  varchar2(4000 byte),
  column89  varchar2(4000 byte),
  column90  varchar2(4000 byte),
  column91  varchar2(4000 byte),
  column92  varchar2(4000 byte),
  column93  varchar2(4000 byte),
  column94  varchar2(4000 byte),
  column95  varchar2(4000 byte),
  column96  varchar2(4000 byte),
  column97  varchar2(4000 byte),
  column98  varchar2(4000 byte),
  column99  varchar2(4000 byte),
  column100 varchar2(4000 byte),
  column101 varchar2(4000 byte),
  column102 varchar2(4000 byte),
  column103 varchar2(4000 byte),
  column104 varchar2(4000 byte),
  column105 varchar2(4000 byte),
  column106 varchar2(4000 byte),
  column107 varchar2(4000 byte),
  column108 varchar2(4000 byte),
  column109 varchar2(4000 byte),
  column110 varchar2(4000 byte),
  column111 varchar2(4000 byte),
  column112 varchar2(4000 byte),
  column113 varchar2(4000 byte),
  column114 varchar2(4000 byte),
  column115 varchar2(4000 byte),
  column116 varchar2(4000 byte),
  column117 varchar2(4000 byte),
  column118 varchar2(4000 byte),
  column119 varchar2(4000 byte),
  column120 varchar2(4000 byte),
  column121 varchar2(4000 byte),
  column122 varchar2(4000 byte),
  column123 varchar2(4000 byte),
  column124 varchar2(4000 byte),
  column125 varchar2(4000 byte),
  column126 varchar2(4000 byte),
  column127 varchar2(4000 byte),
  column128 varchar2(4000 byte),
  column129 varchar2(4000 byte),
  column130 varchar2(4000 byte),
  column131 varchar2(4000 byte),
  column132 varchar2(4000 byte),
  column133 varchar2(4000 byte),
  column134 varchar2(4000 byte),
  column135 varchar2(4000 byte),
  column136 varchar2(4000 byte),
  column137 varchar2(4000 byte),
  column138 varchar2(4000 byte),
  column139 varchar2(4000 byte),
  column140 varchar2(4000 byte),
  column141 varchar2(4000 byte),
  column142 varchar2(4000 byte),
  column143 varchar2(4000 byte),
  column144 varchar2(4000 byte),
  column145 varchar2(4000 byte),
  column146 varchar2(4000 byte),
  column147 varchar2(4000 byte),
  column148 varchar2(4000 byte),
  column149 varchar2(4000 byte),
  column150 varchar2(4000 byte),
  column151 varchar2(4000 byte),
  column152 varchar2(4000 byte),
  column153 varchar2(4000 byte),
  column154 varchar2(4000 byte),
  column155 varchar2(4000 byte),
  column156 varchar2(4000 byte),
  column157 varchar2(4000 byte),
  column158 varchar2(4000 byte),
  column159 varchar2(4000 byte),
  column160 varchar2(4000 byte),
  column161 varchar2(4000 byte),
  column162 varchar2(4000 byte),
  column163 varchar2(4000 byte),
  column164 varchar2(4000 byte),
  column165 varchar2(4000 byte),
  column166 varchar2(4000 byte),
  column167 varchar2(4000 byte),
  column168 varchar2(4000 byte),
  column169 varchar2(4000 byte),
  column170 varchar2(4000 byte),
  column171 varchar2(4000 byte),
  column172 varchar2(4000 byte),
  column173 varchar2(4000 byte),
  column174 varchar2(4000 byte),
  column175 varchar2(4000 byte),
  column176 varchar2(4000 byte),
  column177 varchar2(4000 byte),
  column178 varchar2(4000 byte),
  column179 varchar2(4000 byte),
  column180 varchar2(4000 byte),
  column181 varchar2(4000 byte),
  column182 varchar2(4000 byte),
  column183 varchar2(4000 byte),
  column184 varchar2(4000 byte),
  column185 varchar2(4000 byte),
  column186 varchar2(4000 byte),
  column187 varchar2(4000 byte),
  column188 varchar2(4000 byte),
  column189 varchar2(4000 byte),
  column190 varchar2(4000 byte),
  column191 varchar2(4000 byte),
  column192 varchar2(4000 byte),
  column193 varchar2(4000 byte),
  column194 varchar2(4000 byte),
  column195 varchar2(4000 byte),
  column196 varchar2(4000 byte),
  column197 varchar2(4000 byte),
  column198 varchar2(4000 byte),
  column199 varchar2(4000 byte),
  column200 varchar2(4000 byte),
  constructor function lob_row(p_row_no number) return self as result,
  member function get_column(p_column_no pls_integer) return varchar2,
  member function get_column_count return number
)
/
show errors;
create or replace type lob_rows is table of lob_row
/
show errors;
create or replace type lob_column force as object(
  offset number(5),
  width  number(5)
)
/
show errors;
create or replace type lob_columns is varray(100) of lob_column
/
show errors;
create or replace package lob2table
is
  invalid_charset exception;
  pragma exception_init(invalid_charset, -20000);
  --
  row_error exception;
  pragma exception_init(row_error, -20001);
  --
  column_error exception;
  pragma exception_init(column_error, -20002);
  --
  function separatedcolumns(p_blob             blob,
                            p_row_separator    varchar2,
                            p_column_separator varchar2 := null,
                            p_character_set    varchar2 := null,
                            p_delimiter        varchar2 := null,
                            p_truncate_columns number := 0)
    return lob_rows pipelined;
  function separatedcolumns2(p_blob             blob,
                             p_row_separator    varchar2,
                             p_column_separator varchar2 := null,
                             p_character_set    varchar2 := null,
                             p_delimiter        varchar2 := null,
                             p_truncate_columns number := 0)
    return lob_rows;
  --
  function fixedcolumns(p_blob             blob,
                        p_row_separator    varchar2,
                        p_fixed_columns    lob_columns := null,
                        p_character_set    varchar2 := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined;
  function fixedcolumns2(p_blob             blob,
                         p_row_separator    varchar2,
                         p_fixed_columns    lob_columns := null,
                         p_character_set    varchar2 := null,
                         p_truncate_columns number := 0)
    return lob_rows;
  --
  function fixedcolumns(p_blob             blob,
                        p_row_width        number,
                        p_fixed_columns    lob_columns := null,
                        p_character_set    varchar2 := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined;
  function fixedcolumns2(p_blob             blob,
                         p_row_width        number,
                         p_fixed_columns    lob_columns := null,
                         p_character_set    varchar2 := null,
                         p_truncate_columns number := 0)
    return lob_rows;
  --
  function separatedcolumns(p_bfile bfile,
                            p_row_separator    varchar2,
                            p_column_separator varchar2 := null,
                            p_character_set    varchar2 := null,
                            p_delimiter        varchar2 := null,
                            p_truncate_columns number := 0)
    return lob_rows pipelined;
  function separatedcolumns2(p_bfile bfile,
                             p_row_separator    varchar2,
                             p_column_separator varchar2 := null,
                             p_character_set    varchar2 := null,
                             p_delimiter        varchar2 := null,
                             p_truncate_columns number := 0)
    return lob_rows;
  --
  function fixedcolumns(p_bfile            bfile,
                        p_row_separator    varchar2,
                        p_fixed_columns    lob_columns := null,
                        p_character_set    varchar2 := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined;
  function fixedcolumns2(p_bfile            bfile,
                         p_row_separator    varchar2,
                         p_fixed_columns    lob_columns := null,
                         p_character_set    varchar2 := null,
                         p_truncate_columns number := 0)
    return lob_rows;
  --
  function fixedcolumns(p_bfile            bfile,
                        p_row_width        number,
                        p_fixed_columns    lob_columns := null,
                        p_character_set    varchar2 := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined;
  function fixedcolumns2(p_bfile            bfile,
                         p_row_width        number,
                         p_fixed_columns    lob_columns := null,
                         p_character_set    varchar2 := null,
                         p_truncate_columns number := 0)
    return lob_rows;
  --
  function separatedcolumns(p_clob             clob,
                            p_row_separator    varchar2,
                            p_column_separator varchar2 := null,
                            p_delimiter        varchar2 := null,
                            p_truncate_columns number := 0)
    return lob_rows pipelined;
  function separatedcolumns2(p_clob             clob,
                             p_row_separator    varchar2,
                             p_column_separator varchar2 := null,
                             p_delimiter        varchar2 := null,
                             p_truncate_columns number := 0)
    return lob_rows;
  --
  function fixedcolumns(p_clob             clob,
                        p_row_separator    varchar2,
                        p_fixed_columns    lob_columns := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined;
  function fixedcolumns2(p_clob             clob,
                         p_row_separator    varchar2,
                         p_fixed_columns    lob_columns := null,
                         p_truncate_columns number := 0)
    return lob_rows;
  --
  function fixedcolumns(p_clob             clob,
                        p_row_width        number,
                        p_fixed_columns    lob_columns := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined;
  function fixedcolumns2(p_clob             clob,
                         p_row_width        number,
                         p_fixed_columns    lob_columns := null,
                         p_truncate_columns number := 0)
    return lob_rows;
  --
  function separatedcolumns(p_string           varchar2,
                            p_row_separator    varchar2,
                            p_column_separator varchar2 := null,
                            p_delimiter        varchar2 := null,
                            p_truncate_columns number := 0)
    return lob_rows pipelined;
  function separatedcolumns2(p_string           varchar2,
                             p_row_separator    varchar2,
                             p_column_separator varchar2 := null,
                             p_delimiter        varchar2 := null,
                             p_truncate_columns number := 0)
    return lob_rows;
  --
  function fixedcolumns(p_string           varchar2,
                        p_row_separator    varchar2,
                        p_fixed_columns    lob_columns := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined;
  function fixedcolumns2(p_string           varchar2,
                         p_row_separator    varchar2,
                         p_fixed_columns    lob_columns := null,
                         p_truncate_columns number := 0)
    return lob_rows;
  --
  function fixedcolumns(p_string           varchar2,
                        p_row_width        number,
                        p_fixed_columns    lob_columns := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined;
  function fixedcolumns2(p_string           varchar2,
                         p_row_width        number,
                         p_fixed_columns    lob_columns := null,
                         p_truncate_columns number := 0)
    return lob_rows;
  --
  function get_number(p_string   varchar2,
                      p_on_error number := null,
                      p_format   varchar2 := null,
                      p_nls      varchar2 := null,
                      p_format2  varchar2 := null,
                      p_nls2     varchar2 := null,
                      p_format3  varchar2 := null,
                      p_nls3     varchar2 := null)
    return number;
  --
  function get_date(p_string   varchar2,
                    p_on_error date := null,
                    p_format   varchar2 := null,
                    p_nls      varchar2 := null,
                    p_format2  varchar2 := null,
                    p_nls2     varchar2 := null,
                    p_format3  varchar2 := null,
                    p_nls3     varchar2 := null)
    return date;
  --
  function get_timestamp(p_string   varchar2,
                         p_on_error timestamp_unconstrained := null,
                         p_format   varchar2 := null,
                         p_nls      varchar2 := null,
                         p_format2  varchar2 := null,
                         p_nls2     varchar2 := null,
                         p_format3  varchar2 := null,
                         p_nls3     varchar2 := null)
    return timestamp_unconstrained;
  --
  function get_timestamp_tz(p_string   varchar2,
                            p_on_error timestamp_tz_unconstrained := null,
                            p_format   varchar2 := null,
                            p_nls      varchar2 := null,
                            p_format2  varchar2 := null,
                            p_nls2     varchar2 := null,
                            p_format3  varchar2 := null,
                            p_nls3     varchar2 := null)
    return timestamp_tz_unconstrained;
  --
  function get_dsinterval(p_string   varchar2,
                          p_on_error dsinterval_unconstrained := null)
    return dsinterval_unconstrained;
  --
  function get_yminterval(p_string   varchar2,
                          p_on_error yminterval_unconstrained := null)
    return yminterval_unconstrained;
  --
  function string_to_hex(p_string varchar2) return varchar2;
  --
  function hex_to_string(p_hex varchar2) return varchar2;
end lob2table;
/
show errors;
create or replace type body lob_row
as
  constructor function lob_row(p_row_no number)
    return self as result
  as
  begin
    self.row_no := p_row_no;
    return;
  end lob_row;
  --
  member function get_column(p_column_no pls_integer) return varchar2
  as
  begin
    return case p_column_no
             when   1 then self.column1
             when   2 then self.column2
             when   3 then self.column3
             when   4 then self.column4
             when   5 then self.column5
             when   6 then self.column6
             when   7 then self.column7
             when   8 then self.column8
             when   9 then self.column9
             when  10 then self.column10
             when  11 then self.column11
             when  12 then self.column12
             when  13 then self.column13
             when  14 then self.column14
             when  15 then self.column15
             when  16 then self.column16
             when  17 then self.column17
             when  18 then self.column18
             when  19 then self.column19
             when  20 then self.column20
             when  21 then self.column21
             when  22 then self.column22
             when  23 then self.column23
             when  24 then self.column24
             when  25 then self.column25
             when  26 then self.column26
             when  27 then self.column27
             when  28 then self.column28
             when  29 then self.column29
             when  30 then self.column30
             when  31 then self.column31
             when  32 then self.column32
             when  33 then self.column33
             when  34 then self.column34
             when  35 then self.column35
             when  36 then self.column36
             when  37 then self.column37
             when  38 then self.column38
             when  39 then self.column39
             when  40 then self.column40
             when  41 then self.column41
             when  42 then self.column42
             when  43 then self.column43
             when  44 then self.column44
             when  45 then self.column45
             when  46 then self.column46
             when  47 then self.column47
             when  48 then self.column48
             when  49 then self.column49
             when  50 then self.column50
             when  51 then self.column51
             when  52 then self.column52
             when  53 then self.column53
             when  54 then self.column54
             when  55 then self.column55
             when  56 then self.column56
             when  57 then self.column57
             when  58 then self.column58
             when  59 then self.column59
             when  60 then self.column60
             when  61 then self.column61
             when  62 then self.column62
             when  63 then self.column63
             when  64 then self.column64
             when  65 then self.column65
             when  66 then self.column66
             when  67 then self.column67
             when  68 then self.column68
             when  69 then self.column69
             when  70 then self.column70
             when  71 then self.column71
             when  72 then self.column72
             when  73 then self.column73
             when  74 then self.column74
             when  75 then self.column75
             when  76 then self.column76
             when  77 then self.column77
             when  78 then self.column78
             when  79 then self.column79
             when  80 then self.column80
             when  81 then self.column81
             when  82 then self.column82
             when  83 then self.column83
             when  84 then self.column84
             when  85 then self.column85
             when  86 then self.column86
             when  87 then self.column87
             when  88 then self.column88
             when  89 then self.column89
             when  90 then self.column90
             when  91 then self.column91
             when  92 then self.column92
             when  93 then self.column93
             when  94 then self.column94
             when  95 then self.column95
             when  96 then self.column96
             when  97 then self.column97
             when  98 then self.column98
             when  99 then self.column99
             when 100 then self.column100
             when 101 then self.column101
             when 102 then self.column102
             when 103 then self.column103
             when 104 then self.column104
             when 105 then self.column105
             when 106 then self.column106
             when 107 then self.column107
             when 108 then self.column108
             when 109 then self.column109
             when 110 then self.column110
             when 111 then self.column111
             when 112 then self.column112
             when 113 then self.column113
             when 114 then self.column114
             when 115 then self.column115
             when 116 then self.column116
             when 117 then self.column117
             when 118 then self.column118
             when 119 then self.column119
             when 120 then self.column120
             when 121 then self.column121
             when 122 then self.column122
             when 123 then self.column123
             when 124 then self.column124
             when 125 then self.column125
             when 126 then self.column126
             when 127 then self.column127
             when 128 then self.column128
             when 129 then self.column129
             when 130 then self.column130
             when 131 then self.column131
             when 132 then self.column132
             when 133 then self.column133
             when 134 then self.column134
             when 135 then self.column135
             when 136 then self.column136
             when 137 then self.column137
             when 138 then self.column138
             when 139 then self.column139
             when 140 then self.column140
             when 141 then self.column141
             when 142 then self.column142
             when 143 then self.column143
             when 144 then self.column144
             when 145 then self.column145
             when 146 then self.column146
             when 147 then self.column147
             when 148 then self.column148
             when 149 then self.column149
             when 150 then self.column150
             when 151 then self.column151
             when 152 then self.column152
             when 153 then self.column153
             when 154 then self.column154
             when 155 then self.column155
             when 156 then self.column156
             when 157 then self.column157
             when 158 then self.column158
             when 159 then self.column159
             when 160 then self.column160
             when 161 then self.column161
             when 162 then self.column162
             when 163 then self.column163
             when 164 then self.column164
             when 165 then self.column165
             when 166 then self.column166
             when 167 then self.column167
             when 168 then self.column168
             when 169 then self.column169
             when 170 then self.column170
             when 171 then self.column171
             when 172 then self.column172
             when 173 then self.column173
             when 174 then self.column174
             when 175 then self.column175
             when 176 then self.column176
             when 177 then self.column177
             when 178 then self.column178
             when 179 then self.column179
             when 180 then self.column180
             when 181 then self.column181
             when 182 then self.column182
             when 183 then self.column183
             when 184 then self.column184
             when 185 then self.column185
             when 186 then self.column186
             when 187 then self.column187
             when 188 then self.column188
             when 189 then self.column189
             when 190 then self.column190
             when 191 then self.column191
             when 192 then self.column192
             when 193 then self.column193
             when 194 then self.column194
             when 195 then self.column195
             when 196 then self.column196
             when 197 then self.column197
             when 198 then self.column198
             when 199 then self.column199
             when 200 then self.column200
           end;
  end get_column;
  --
  member function get_column_count return number
  as
  begin
    return case
             when self.column200 is not null then 200
             when self.column199 is not null then 199
             when self.column198 is not null then 198
             when self.column197 is not null then 197
             when self.column196 is not null then 196
             when self.column195 is not null then 195
             when self.column194 is not null then 194
             when self.column193 is not null then 193
             when self.column192 is not null then 192
             when self.column191 is not null then 191
             when self.column190 is not null then 190
             when self.column189 is not null then 189
             when self.column188 is not null then 188
             when self.column187 is not null then 187
             when self.column186 is not null then 186
             when self.column185 is not null then 185
             when self.column184 is not null then 184
             when self.column183 is not null then 183
             when self.column182 is not null then 182
             when self.column181 is not null then 181
             when self.column180 is not null then 180
             when self.column179 is not null then 179
             when self.column178 is not null then 178
             when self.column177 is not null then 177
             when self.column176 is not null then 176
             when self.column175 is not null then 175
             when self.column174 is not null then 174
             when self.column173 is not null then 173
             when self.column172 is not null then 172
             when self.column171 is not null then 171
             when self.column170 is not null then 170
             when self.column169 is not null then 169
             when self.column168 is not null then 168
             when self.column167 is not null then 167
             when self.column166 is not null then 166
             when self.column165 is not null then 165
             when self.column164 is not null then 164
             when self.column163 is not null then 163
             when self.column162 is not null then 162
             when self.column161 is not null then 161
             when self.column160 is not null then 160
             when self.column159 is not null then 159
             when self.column158 is not null then 158
             when self.column157 is not null then 157
             when self.column156 is not null then 156
             when self.column155 is not null then 155
             when self.column154 is not null then 154
             when self.column153 is not null then 153
             when self.column152 is not null then 152
             when self.column151 is not null then 151
             when self.column150 is not null then 150
             when self.column149 is not null then 149
             when self.column148 is not null then 148
             when self.column147 is not null then 147
             when self.column146 is not null then 146
             when self.column145 is not null then 145
             when self.column144 is not null then 144
             when self.column143 is not null then 143
             when self.column142 is not null then 142
             when self.column141 is not null then 141
             when self.column140 is not null then 140
             when self.column139 is not null then 139
             when self.column138 is not null then 138
             when self.column137 is not null then 137
             when self.column136 is not null then 136
             when self.column135 is not null then 135
             when self.column134 is not null then 134
             when self.column133 is not null then 133
             when self.column132 is not null then 132
             when self.column131 is not null then 131
             when self.column130 is not null then 130
             when self.column129 is not null then 129
             when self.column128 is not null then 128
             when self.column127 is not null then 127
             when self.column126 is not null then 126
             when self.column125 is not null then 125
             when self.column124 is not null then 124
             when self.column123 is not null then 123
             when self.column122 is not null then 122
             when self.column121 is not null then 121
             when self.column120 is not null then 120
             when self.column119 is not null then 119
             when self.column118 is not null then 118
             when self.column117 is not null then 117
             when self.column116 is not null then 116
             when self.column115 is not null then 115
             when self.column114 is not null then 114
             when self.column113 is not null then 113
             when self.column112 is not null then 112
             when self.column111 is not null then 111
             when self.column110 is not null then 110
             when self.column109 is not null then 109
             when self.column108 is not null then 108
             when self.column107 is not null then 107
             when self.column106 is not null then 106
             when self.column105 is not null then 105
             when self.column104 is not null then 104
             when self.column103 is not null then 103
             when self.column102 is not null then 102
             when self.column101 is not null then 101
             when self.column100 is not null then 100
             when self.column99  is not null then 99
             when self.column98  is not null then 98
             when self.column97  is not null then 97
             when self.column96  is not null then 96
             when self.column95  is not null then 95
             when self.column94  is not null then 94
             when self.column93  is not null then 93
             when self.column92  is not null then 92
             when self.column91  is not null then 91
             when self.column90  is not null then 90
             when self.column89  is not null then 89
             when self.column88  is not null then 88
             when self.column87  is not null then 87
             when self.column86  is not null then 86
             when self.column85  is not null then 85
             when self.column84  is not null then 84
             when self.column83  is not null then 83
             when self.column82  is not null then 82
             when self.column81  is not null then 81
             when self.column80  is not null then 80
             when self.column79  is not null then 79
             when self.column78  is not null then 78
             when self.column77  is not null then 77
             when self.column76  is not null then 76
             when self.column75  is not null then 75
             when self.column74  is not null then 74
             when self.column73  is not null then 73
             when self.column72  is not null then 72
             when self.column71  is not null then 71
             when self.column70  is not null then 70
             when self.column69  is not null then 69
             when self.column68  is not null then 68
             when self.column67  is not null then 67
             when self.column66  is not null then 66
             when self.column65  is not null then 65
             when self.column64  is not null then 64
             when self.column63  is not null then 63
             when self.column62  is not null then 62
             when self.column61  is not null then 61
             when self.column60  is not null then 60
             when self.column59  is not null then 59
             when self.column58  is not null then 58
             when self.column57  is not null then 57
             when self.column56  is not null then 56
             when self.column55  is not null then 55
             when self.column54  is not null then 54
             when self.column53  is not null then 53
             when self.column52  is not null then 52
             when self.column51  is not null then 51
             when self.column50  is not null then 50
             when self.column49  is not null then 49
             when self.column48  is not null then 48
             when self.column47  is not null then 47
             when self.column46  is not null then 46
             when self.column45  is not null then 45
             when self.column44  is not null then 44
             when self.column43  is not null then 43
             when self.column42  is not null then 42
             when self.column41  is not null then 41
             when self.column40  is not null then 40
             when self.column39  is not null then 39
             when self.column38  is not null then 38
             when self.column37  is not null then 37
             when self.column36  is not null then 36
             when self.column35  is not null then 35
             when self.column34  is not null then 34
             when self.column33  is not null then 33
             when self.column32  is not null then 32
             when self.column31  is not null then 31
             when self.column30  is not null then 30
             when self.column29  is not null then 29
             when self.column28  is not null then 28
             when self.column27  is not null then 27
             when self.column26  is not null then 26
             when self.column25  is not null then 25
             when self.column24  is not null then 24
             when self.column23  is not null then 23
             when self.column22  is not null then 22
             when self.column21  is not null then 21
             when self.column20  is not null then 20
             when self.column19  is not null then 19
             when self.column18  is not null then 18
             when self.column17  is not null then 17
             when self.column16  is not null then 16
             when self.column15  is not null then 15
             when self.column14  is not null then 14
             when self.column13  is not null then 13
             when self.column12  is not null then 12
             when self.column11  is not null then 11
             when self.column10  is not null then 10
             when self.column9   is not null then 9
             when self.column8   is not null then 8
             when self.column7   is not null then 7
             when self.column6   is not null then 6
             when self.column5   is not null then 5
             when self.column4   is not null then 4
             when self.column3   is not null then 3
             when self.column2   is not null then 2
             when self.column1   is not null then 1
             else 0
           end;
  end get_column_count;
end;
/
show errors;
create or replace package body lob2table
is
  subtype lvarchar2 is varchar2(32767 byte);
  subtype lraw is raw(32767);
  --
  e_finished exception;
  e_failed   exception;
  --
  bom constant varchar2(1 char) := unistr('\feff');
  --
  procedure free(p_clob in out nocopy clob) as
  begin
    if p_clob is not null and dbms_lob.istemporary(p_clob) = 1
    then
      dbms_lob.freetemporary(p_clob);
    end if;
  end free;
  --
  function get_clob(p_clob clob)
    return clob
  as
    l_clob clob;
  begin
    dbms_lob.createtemporary(l_clob, true, dbms_lob.call);
    dbms_lob.copy(
      dest_lob => l_clob,
      src_lob  => p_clob,
      amount   => dbms_lob.lobmaxsize);
    return l_clob;
  end get_clob;
  --
  function get_charset_name(p_charset_name varchar2) return varchar2
  as
    l_charset_id constant number :=
      nls_charset_id(nvl(upper(trim(p_charset_name)), 'CHAR_CS'));
  begin
    if l_charset_id is null
    then
      raise_application_error(-20000, 'Invalid charset ' || p_charset_name);
    else
      return upper(nls_charset_name(l_charset_id));
    end if;
  end get_charset_name;
  --
  function to_boolean(p_number number) return boolean
  as
  begin
    return(p_number != 0);
  end to_boolean;
  --
  function get_clob(p_blob blob, p_charset_name varchar2)
    return clob
  as
    l_charset_name constant lvarchar2 := get_charset_name(p_charset_name);
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_lang_context integer := dbms_lob.default_lang_ctx;
    l_warning      integer;
    l_clob         clob;
  begin
    dbms_lob.createtemporary(l_clob, true, dbms_lob.call);
    dbms_lob.converttoclob(
      dest_lob     => l_clob,
      src_blob     => p_blob,
      amount       => dbms_lob.lobmaxsize,
      dest_offset  => l_dest_offset,
      src_offset   => l_src_offset,
      blob_csid    => nls_charset_id(l_charset_name),
      lang_context => l_lang_context,
      warning      => l_warning);
    return l_clob;
  end get_clob;
  --
  function get_clob(p_bfile bfile, p_charset_name varchar2)
    return clob
  as
    l_charset_name lvarchar2;
    l_bfile        bfile := p_bfile;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_lang_context integer := dbms_lob.default_lang_ctx;
    l_warning      integer;
    l_clob         clob;
    procedure finally is
    begin
      if l_bfile is not null and dbms_lob.isopen(l_bfile) = 1
      then
        dbms_lob.close(l_bfile);
      end if;
    end;
  begin
    l_charset_name := get_charset_name(p_charset_name);
    dbms_lob.createtemporary(l_clob, true, dbms_lob.call);
    dbms_lob.open(l_bfile);
    dbms_lob.loadclobfromfile(
      dest_lob       => l_clob,
      src_bfile      => l_bfile,
      amount         => dbms_lob.lobmaxsize,
      dest_offset    => l_dest_offset,
      src_offset     => l_src_offset,
      bfile_csid     => nls_charset_id(l_charset_name),
      lang_context   => l_lang_context,
      warning        => l_warning);
    finally();
    return l_clob;
  exception
    when others then finally(); raise;
  end get_clob;
  --
  function get_offset(p_string varchar2) return integer as
  begin
    return case when substr(p_string, 1, 1) = bom then 2 else 1 end;
  end get_offset;
  --
  function get_offset(p_clob clob) return integer as
  begin
    return case when dbms_lob.substr(p_clob, 1) = bom then 2 else 1 end;
  end get_offset;
  --
  function in_delimiter(p_string varchar2, p_delimiter varchar2)
    return boolean
  as
  begin
    return
      case
        when p_string is null or p_delimiter is null then false
        else mod((length(p_string) -
                    nvl(length(replace(p_string, p_delimiter, null)), 0))
                  / length(p_delimiter), 2) = 1
      end;
  end in_delimiter;
  --
  function get_chunk(p_clob clob, p_separator varchar2, p_delimiter varchar2,
                     p_offset in out integer)
    return varchar2
  as
    l_offset integer := p_offset;
    l_buffer lvarchar2;
    l_amount integer;
  begin
    loop
      l_offset := dbms_lob.instr(lob_loc => p_clob, pattern => p_separator,
                                 offset => l_offset);
      l_amount := case l_offset
                    when 0 then dbms_lob.getlength(p_clob) - p_offset + 1
                    else l_offset - p_offset
                  end;
      if l_amount >= 1
      then
        begin
          dbms_lob.read(lob_loc => p_clob, amount => l_amount,
                        offset => p_offset, buffer => l_buffer);
        exception
          when value_error or dbms_lob.invalid_argval then
            raise_application_error(
              -20001, 'Row error at offset = ' || p_offset || ', ' ||
                                   'amount = ' || l_amount);
        end;
      else
        l_buffer := null;
      end if;
      if l_offset = 0
      then
        p_offset := 0;
        exit;
      elsif in_delimiter(l_buffer, p_delimiter)
      then
        l_offset := l_offset + length(p_separator);
      else
        p_offset := l_offset + length(p_separator);
        exit;
      end if;
    end loop;
    return l_buffer;
  end get_chunk;
  --
  function get_chunk(p_string varchar2, p_separator varchar2, p_delimiter varchar2,
                     p_offset in out integer)
    return varchar2
  as
    l_offset integer := p_offset;
    l_buffer lvarchar2;
  begin
    loop
      l_offset := instr(p_string, p_separator, l_offset);
      l_buffer := case l_offset
                    when 0 then substr(p_string, p_offset)
                    else substr(p_string, p_offset, l_offset - p_offset)
                  end;
      if l_offset = 0
      then
        p_offset := 0;
        exit;
      elsif in_delimiter(l_buffer, p_delimiter)
      then
        l_offset := l_offset + length(p_separator);
      else
        p_offset := l_offset + length(p_separator);
        exit;
      end if;
    end loop;
    return l_buffer;
  end get_chunk;
  --
  function get_chunk(p_clob clob, p_width integer, p_offset in out integer)
    return varchar2
  as
    l_amount integer := p_width;
    l_buffer lvarchar2;
  begin
    begin
      dbms_lob.read(lob_loc => p_clob, amount => l_amount,
                    offset => p_offset, buffer => l_buffer);
    exception
      when value_error or dbms_lob.invalid_argval then
        raise_application_error(
          -20001, 'Row error at offset = ' || p_offset || ', ' ||
                               'amount = ' || l_amount);
    end;
    p_offset := case when l_amount < p_width then 0
                     else p_offset + l_amount end;
    return l_buffer;
  end get_chunk;
  --
  function get_chunk(p_string varchar2, p_width integer, p_offset in out integer)
    return varchar2
  as
    l_buffer lvarchar2;
  begin
    l_buffer := substr(p_string, p_offset, p_width);
    p_offset := case when length(p_string) < p_offset + p_width then 0
                     else p_offset + p_width end;
    return l_buffer;
  end get_chunk;
  --
  function remove_delimiter(p_string varchar2, p_delimiter varchar2)
    return varchar2
  as
    l_delimited    boolean := false;
    l_start_offset pls_integer := 1;
    l_next_offset  pls_integer;
    l_string       lvarchar2;
  begin
    loop
      l_next_offset := instr(p_string, p_delimiter, l_start_offset);
      if l_next_offset is null or l_next_offset = 0
      then
        l_string := l_string || substr(p_string, l_start_offset);
        exit;
      else
        l_string := l_string || substr(p_string, l_start_offset,
                                       l_next_offset - l_start_offset);
        if l_delimited and
           substr(p_string, l_next_offset + length(p_delimiter),
                  length(p_delimiter)) = p_delimiter
        then
          l_string := l_string || p_delimiter;
          l_start_offset := l_next_offset + 2 * length(p_delimiter);
        else
          l_delimited := not l_delimited;
          l_start_offset := l_next_offset + length(p_delimiter);
        end if;
      end if;
    end loop;
    return l_string;
  end remove_delimiter;
  --
  function truncate_string(p_string varchar2, p_bytes pls_integer := 4000)
    return varchar2
  as
    l_string lvarchar2 := substr(p_string, 1, p_bytes);
    l_count  pls_integer := length(l_string);
  begin
    while lengthb(l_string) > p_bytes
    loop
      l_count := l_count - 1;
      l_string := substr(p_string, 1, l_count);
    end loop;
    return l_string;
  end truncate_string;
  --
  function get_column(p_chunk varchar2, p_separator varchar2,
                      p_delimiter varchar2, p_truncate boolean,
                      p_offset in out pls_integer)
    return varchar2
  as
    l_offset pls_integer := p_offset;
    l_string lvarchar2;
  begin
    if p_offset > 0
    then
      if p_separator is null
      then
        l_string := p_chunk;
        p_offset := 0;
      else
        loop
          l_offset := instr(p_chunk, p_separator, l_offset);
          if l_offset = 0
          then
            l_string := substr(p_chunk, p_offset);
            p_offset := 0;
            exit;
          else
            l_string := substr(p_chunk, p_offset, l_offset - p_offset);
            if in_delimiter(l_string, p_delimiter)
            then
              l_offset := l_offset + length(p_separator);
            else
              p_offset := l_offset + length(p_separator);
              exit;
            end if;
          end if;
        end loop;
      end if;
      l_string := remove_delimiter(l_string, p_delimiter);
      if p_truncate then l_string := truncate_string(l_string); end if;
      return l_string;
    else
      raise e_finished;
    end if;
  end get_column;
  --
  function get_column(p_chunk varchar2, p_columns lob_columns,
                      p_truncate boolean, p_column in out pls_integer)
    return varchar2
  as
    l_offset pls_integer;
    l_width  pls_integer;
    l_string lvarchar2;
  begin
    if (p_column = 1 and p_columns is null) or p_columns.exists(p_column)
    then
      if p_column = 1 and p_columns is null
      then
        l_string := p_chunk;
      else
        l_offset := nvl(p_columns(p_column).offset, 1);
        l_width := p_columns(p_column).width;
        l_string := case
                      when l_width is null then substr(p_chunk, l_offset)
                      else substr(p_chunk, l_offset, l_width)
                    end;
      end if;
      if p_truncate then l_string := truncate_string(l_string); end if;
      p_column := p_column + 1;
      return l_string;
    else
      raise e_finished;
    end if;
  end get_column;
  --
  function get_row(p_row_no number, p_chunk varchar2, p_separator varchar2,
                   p_delimiter varchar2, p_truncate number := 0)
    return lob_row
  as
    l_trunc  constant boolean := to_boolean(p_truncate);
    l_row    lob_row := lob_row(p_row_no);
    l_offset pls_integer := 1;
  begin
    begin
      l_row.column1   := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column2   := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column3   := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column4   := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column5   := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column6   := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column7   := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column8   := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column9   := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column10  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column11  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column12  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column13  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column14  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column15  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column16  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column17  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column18  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column19  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column20  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column21  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column22  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column23  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column24  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column25  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column26  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column27  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column28  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column29  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column30  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column31  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column32  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column33  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column34  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column35  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column36  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column37  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column38  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column39  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column40  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column41  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column42  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column43  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column44  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column45  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column46  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column47  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column48  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column49  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column50  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column51  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column52  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column53  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column54  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column55  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column56  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column57  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column58  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column59  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column60  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column61  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column62  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column63  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column64  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column65  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column66  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column67  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column68  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column69  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column70  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column71  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column72  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column73  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column74  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column75  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column76  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column77  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column78  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column79  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column80  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column81  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column82  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column83  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column84  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column85  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column86  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column87  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column88  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column89  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column90  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column91  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column92  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column93  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column94  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column95  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column96  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column97  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column98  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column99  := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column100 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column101 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column102 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column103 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column104 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column105 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column106 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column107 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column108 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column109 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column110 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column111 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column112 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column113 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column114 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column115 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column116 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column117 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column118 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column119 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column120 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column121 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column122 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column123 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column124 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column125 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column126 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column127 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column128 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column129 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column130 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column131 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column132 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column133 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column134 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column135 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column136 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column137 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column138 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column139 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column140 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column141 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column142 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column143 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column144 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column145 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column146 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column147 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column148 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column149 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column150 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column151 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column152 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column153 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column154 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column155 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column156 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column157 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column158 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column159 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column160 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column161 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column162 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column163 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column164 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column165 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column166 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column167 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column168 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column169 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column170 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column171 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column172 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column173 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column174 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column175 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column176 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column177 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column178 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column179 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column180 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column181 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column182 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column183 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column184 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column185 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column186 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column187 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column188 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column189 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column190 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column191 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column192 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column193 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column194 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column195 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column196 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column197 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column198 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column199 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
      l_row.column200 := get_column(p_chunk, p_separator, p_delimiter, l_trunc, l_offset);
    exception
      when e_finished then null;
      when value_error then raise_application_error(-20002, 'Column error');
    end;
    return l_row;
  end get_row;
  --
  function get_row(p_row_no number, p_chunk varchar2, p_columns lob_columns,
                   p_truncate number := 0)
    return lob_row
  as
    l_trunc   constant boolean := to_boolean(p_truncate);
    l_row     lob_row := lob_row(p_row_no);
    l_column  pls_integer := 1;
  begin
    begin
      l_row.column1   := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column2   := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column3   := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column4   := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column5   := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column6   := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column7   := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column8   := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column9   := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column10  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column11  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column12  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column13  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column14  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column15  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column16  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column17  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column18  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column19  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column20  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column21  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column22  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column23  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column24  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column25  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column26  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column27  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column28  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column29  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column30  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column31  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column32  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column33  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column34  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column35  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column36  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column37  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column38  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column39  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column40  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column41  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column42  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column43  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column44  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column45  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column46  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column47  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column48  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column49  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column50  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column51  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column52  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column53  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column54  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column55  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column56  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column57  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column58  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column59  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column60  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column61  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column62  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column63  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column64  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column65  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column66  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column67  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column68  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column69  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column70  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column71  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column72  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column73  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column74  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column75  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column76  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column77  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column78  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column79  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column80  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column81  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column82  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column83  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column84  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column85  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column86  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column87  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column88  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column89  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column90  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column91  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column92  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column93  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column94  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column95  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column96  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column97  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column98  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column99  := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column100 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column101 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column102 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column103 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column104 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column105 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column106 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column107 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column108 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column109 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column110 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column111 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column112 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column113 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column114 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column115 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column116 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column117 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column118 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column119 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column120 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column121 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column122 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column123 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column124 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column125 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column126 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column127 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column128 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column129 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column130 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column131 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column132 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column133 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column134 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column135 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column136 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column137 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column138 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column139 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column140 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column141 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column142 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column143 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column144 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column145 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column146 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column147 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column148 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column149 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column150 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column151 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column152 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column153 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column154 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column155 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column156 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column157 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column158 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column159 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column160 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column161 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column162 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column163 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column164 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column165 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column166 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column167 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column168 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column169 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column170 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column171 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column172 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column173 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column174 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column175 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column176 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column177 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column178 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column179 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column180 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column181 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column182 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column183 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column184 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column185 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column186 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column187 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column188 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column189 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column190 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column191 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column192 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column193 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column194 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column195 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column196 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column197 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column198 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column199 := get_column(p_chunk, p_columns, l_trunc, l_column);
      l_row.column200 := get_column(p_chunk, p_columns, l_trunc, l_column);
    exception
      when e_finished then null;
      when value_error then raise_application_error(-20002, 'Column error');
    end;
    return l_row;
  end get_row;
  --
  function separatedcolumns(p_blob             blob,
                            p_row_separator    varchar2,
                            p_column_separator varchar2 := null,
                            p_character_set    varchar2 := null,
                            p_delimiter        varchar2 := null,
                            p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_clob   clob;
    l_chunk  lvarchar2;
    procedure finally is begin free(l_clob); end;
  begin
    if p_blob is not null and dbms_lob.getlength(p_blob) > 0
    then
      l_clob := get_clob(p_blob, p_character_set);
      l_offset := get_offset(l_clob);
      loop
        l_chunk := get_chunk(l_clob, p_row_separator, p_delimiter, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_column_separator, p_delimiter,
                           p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    finally();
    return;
  exception
    when no_data_needed then finally(); return;
    when others then finally(); raise;
  end separatedcolumns;
  --
  function separatedcolumns2(p_blob             blob,
                             p_row_separator    varchar2,
                             p_column_separator varchar2 := null,
                             p_character_set    varchar2 := null,
                             p_delimiter        varchar2 := null,
                             p_truncate_columns number := 0)
    return lob_rows
  as
    l_rows lob_rows;
  begin
    select value(d) bulk collect into l_rows
    from   table(separatedcolumns(p_blob, p_row_separator, p_column_separator,
                                  p_character_set, p_delimiter,
                                  p_truncate_columns)) d;
    return l_rows;
  end separatedcolumns2;
  --
  function fixedcolumns(p_blob             blob,
                        p_row_separator    varchar2,
                        p_fixed_columns    lob_columns := null,
                        p_character_set    varchar2 := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_clob   clob;
    l_chunk  lvarchar2;
    procedure finally is begin free(l_clob); end;
  begin
    if p_blob is not null and dbms_lob.getlength(p_blob) > 0
    then
      l_clob := get_clob(p_blob, p_character_set);
      l_offset := get_offset(l_clob);
      loop
        l_chunk := get_chunk(l_clob, p_row_separator, null, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_fixed_columns,
                           p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    finally();
    return;
  exception
    when no_data_needed then finally(); return;
    when others then finally(); raise;
  end fixedcolumns;
  --
  function fixedcolumns2(p_blob             blob,
                         p_row_separator    varchar2,
                         p_fixed_columns    lob_columns := null,
                         p_character_set    varchar2 := null,
                         p_truncate_columns number := 0)
    return lob_rows
  as
    l_rows lob_rows;
  begin
    select value(d) bulk collect into l_rows
    from   table(fixedcolumns(p_blob, p_row_separator, p_fixed_columns,
                              p_character_set, p_truncate_columns)) d;
    return l_rows;
  end fixedcolumns2;
  --
  function fixedcolumns(p_blob             blob,
                        p_row_width        number,
                        p_fixed_columns    lob_columns := null,
                        p_character_set    varchar2 := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_clob   clob;
    l_chunk  lvarchar2;
    procedure finally is begin free(l_clob); end;
  begin
    if p_blob is not null and dbms_lob.getlength(p_blob) > 0
    then
      l_clob := get_clob(p_blob, p_character_set);
      l_offset := get_offset(l_clob);
      loop
        l_chunk := get_chunk(l_clob, p_row_width, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_fixed_columns,
                           p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    finally();
    return;
  exception
    when no_data_needed then finally(); return;
    when others then finally(); raise;
  end fixedcolumns;
  --
  function fixedcolumns2(p_blob             blob,
                         p_row_width        number,
                         p_fixed_columns    lob_columns := null,
                         p_character_set    varchar2 := null,
                         p_truncate_columns number := 0)
    return lob_rows
  as
    l_rows lob_rows;
  begin
    select value(d) bulk collect into l_rows
    from   table(fixedcolumns(p_blob, p_row_width, p_fixed_columns,
                              p_character_set, p_truncate_columns)) d;
    return l_rows;
  end fixedcolumns2;
  --
  function separatedcolumns(p_bfile            bfile,
                            p_row_separator    varchar2,
                            p_column_separator varchar2 := null,
                            p_character_set    varchar2 := null,
                            p_delimiter        varchar2 := null,
                            p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_bfile  bfile := p_bfile;
    l_clob   clob;
    l_chunk  lvarchar2;
    procedure finally is begin free(l_clob); end;
  begin
    if l_bfile is not null and dbms_lob.getlength(l_bfile) > 0
    then
      dbms_lob.open(l_bfile);
      l_clob := get_clob(l_bfile, p_character_set);
      l_offset := get_offset(l_clob);
      loop
        l_chunk := get_chunk(l_clob, p_row_separator, p_delimiter, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_column_separator, p_delimiter,
                           p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    finally();
    return;
  exception
    when no_data_needed then finally(); return;
    when others then finally(); raise;
  end separatedcolumns;
  --
  function separatedcolumns2(p_bfile            bfile,
                             p_row_separator    varchar2,
                             p_column_separator varchar2 := null,
                             p_character_set    varchar2 := null,
                             p_delimiter        varchar2 := null,
                             p_truncate_columns number := 0)
    return lob_rows
  as
    l_rows lob_rows;
  begin
    select value(d) bulk collect into l_rows
    from   table(separatedcolumns(p_bfile, p_row_separator, p_column_separator,
                                  p_character_set, p_delimiter,
                                  p_truncate_columns)) d;
    return l_rows;
  end separatedcolumns2;
  --
  function fixedcolumns(p_bfile            bfile,
                        p_row_separator    varchar2,
                        p_fixed_columns    lob_columns := null,
                        p_character_set    varchar2 := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_clob   clob;
    l_chunk  lvarchar2;
    procedure finally is begin free(l_clob); end;
  begin
    if p_bfile is not null and dbms_lob.getlength(p_bfile) > 0
    then
      l_clob := get_clob(p_bfile, p_character_set);
      l_offset := get_offset(l_clob);
      loop
        l_chunk := get_chunk(l_clob, p_row_separator, null, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_fixed_columns,
                           p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    finally();
    return;
  exception
    when no_data_needed then finally(); return;
    when others then finally(); raise;
  end fixedcolumns;
  --
  function fixedcolumns2(p_bfile            bfile,
                         p_row_separator    varchar2,
                         p_fixed_columns    lob_columns := null,
                         p_character_set    varchar2 := null,
                         p_truncate_columns number := 0)
    return lob_rows
  as
  l_rows lob_rows;
  begin
    select value(d) bulk collect into l_rows
    from   table(fixedcolumns(p_bfile, p_row_separator, p_fixed_columns,
                              p_character_set, p_truncate_columns)) d;
    return l_rows;
  end fixedcolumns2;
  --
  function fixedcolumns(p_bfile            bfile,
                        p_row_width        number,
                        p_fixed_columns    lob_columns := null,
                        p_character_set    varchar2 := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_clob   clob;
    l_chunk  lvarchar2;
    procedure finally is begin free(l_clob); end;
  begin
    if p_bfile is not null and dbms_lob.getlength(p_bfile) > 0
    then
      l_clob := get_clob(p_bfile, p_character_set);
      l_offset := get_offset(l_clob);
      loop
        l_chunk := get_chunk(l_clob, p_row_width, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_fixed_columns,
                           p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    finally();
    return;
  exception
    when no_data_needed then finally(); return;
    when others then finally(); raise;
  end fixedcolumns;
  --
  function fixedcolumns2(p_bfile            bfile,
                         p_row_width        number,
                         p_fixed_columns    lob_columns := null,
                         p_character_set    varchar2 := null,
                         p_truncate_columns number := 0)
    return lob_rows
  as
  l_rows lob_rows;
  begin
    select value(d) bulk collect into l_rows
    from   table(fixedcolumns(p_bfile, p_row_width, p_fixed_columns,
                              p_character_set, p_truncate_columns)) d;
    return l_rows;
  end fixedcolumns2;
  --
  function separatedcolumns(p_clob             clob,
                            p_row_separator    varchar2,
                            p_column_separator varchar2 := null,
                            p_delimiter        varchar2 := null,
                            p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_clob   clob;
    l_chunk  lvarchar2;
    procedure finally is begin free(l_clob); end;
  begin
    if p_clob is not null and dbms_lob.getlength(p_clob) > 0
    then
      l_clob := get_clob(p_clob);
      l_offset := get_offset(l_clob);
      loop
        l_chunk := get_chunk(l_clob, p_row_separator, p_delimiter, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_column_separator,
                           p_delimiter, p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    finally();
    return;
  exception
    when no_data_needed then finally(); return;
    when others then finally(); raise;
  end separatedcolumns;
  --
  function separatedcolumns2(p_clob             clob,
                             p_row_separator    varchar2,
                             p_column_separator varchar2 := null,
                             p_delimiter        varchar2 := null,
                             p_truncate_columns number := 0)
    return lob_rows
  as
    l_rows lob_rows;
  begin
    select value(d) bulk collect into l_rows
    from   table(separatedcolumns(p_clob, p_row_separator, p_column_separator,
                                  p_delimiter, p_truncate_columns)) d;
    return l_rows;
  end separatedcolumns2;
  --
  function fixedcolumns(p_clob             clob,
                        p_row_separator    varchar2,
                        p_fixed_columns    lob_columns := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_clob   clob;
    l_chunk  lvarchar2;
    procedure finally is begin free(l_clob); end;
  begin
    if p_clob is not null and dbms_lob.getlength(p_clob) > 0
    then
      l_clob := get_clob(p_clob);
      l_offset := get_offset(l_clob);
      loop
        l_chunk := get_chunk(l_clob, p_row_separator, null, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_fixed_columns,
                           p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    return;
  exception
    when no_data_needed then finally(); return;
    when others then finally(); raise;
  end fixedcolumns;
  --
  function fixedcolumns2(p_clob             clob,
                         p_row_separator    varchar2,
                         p_fixed_columns    lob_columns := null,
                         p_truncate_columns number := 0)
    return lob_rows
  as
    l_rows lob_rows;
  begin
    select value(d) bulk collect into l_rows
    from   table(fixedcolumns(p_clob, p_row_separator, p_fixed_columns,
                              p_truncate_columns)) d;
    return l_rows;
  end fixedcolumns2;
  --
  function fixedcolumns(p_clob             clob,
                        p_row_width        number,
                        p_fixed_columns    lob_columns := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_clob   clob;
    l_chunk  lvarchar2;
    procedure finally is begin free(l_clob); end;
  begin
    if p_clob is not null and dbms_lob.getlength(p_clob) > 0
    then
      l_clob := get_clob(p_clob);
      l_offset := get_offset(l_clob);
      loop
        l_chunk := get_chunk(l_clob, p_row_width, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_fixed_columns,
                           p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    return;
  exception
    when no_data_needed then finally(); return;
    when others then finally(); raise;
  end fixedcolumns;
  --
  function fixedcolumns2(p_clob             clob,
                         p_row_width        number,
                         p_fixed_columns    lob_columns := null,
                         p_truncate_columns number := 0)
    return lob_rows
  as
    l_rows lob_rows;
  begin
    select value(d) bulk collect into l_rows
    from   table(fixedcolumns(p_clob, p_row_width, p_fixed_columns,
                              p_truncate_columns)) d;
    return l_rows;
  end fixedcolumns2;
  --
  function separatedcolumns(p_string           varchar2,
                            p_row_separator    varchar2,
                            p_column_separator varchar2 := null,
                            p_delimiter        varchar2 := null,
                            p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_chunk  lvarchar2;
  begin
    if p_string is not null
    then
      l_offset := get_offset(p_string);
      loop
        l_chunk := get_chunk(p_string, p_row_separator, p_delimiter, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_column_separator,
                           p_delimiter, p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    return;
  exception
    when no_data_needed then return;
  end separatedcolumns;
  --
  function separatedcolumns2(p_string           varchar2,
                             p_row_separator    varchar2,
                             p_column_separator varchar2 := null,
                             p_delimiter        varchar2 := null,
                             p_truncate_columns number := 0)
    return lob_rows
  as
    l_rows   lob_rows := lob_rows();
    l_offset integer;
    l_chunk  lvarchar2;
  begin
    if p_string is not null
    then
      l_offset := get_offset(p_string);
      loop
        l_chunk := get_chunk(p_string, p_row_separator, p_delimiter, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          l_rows.extend;
          l_rows(l_rows.last) := get_row(l_rows.last, l_chunk, p_column_separator,
                                         p_delimiter, p_truncate_columns);
        end if;
        exit when l_offset = 0;
      end loop;
    end if;
    return l_rows;
  end separatedcolumns2;
  --
  function fixedcolumns(p_string           varchar2,
                        p_row_separator    varchar2,
                        p_fixed_columns    lob_columns := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_chunk  lvarchar2;
  begin
    if p_string is not null
    then
      l_offset := get_offset(p_string);
      loop
        l_chunk := get_chunk(p_string, p_row_separator, null, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_fixed_columns,
                           p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    return;
  exception
    when no_data_needed then return;
  end fixedcolumns;
  --
  function fixedcolumns2(p_string           varchar2,
                         p_row_separator    varchar2,
                         p_fixed_columns    lob_columns := null,
                         p_truncate_columns number := 0)
    return lob_rows
  as
    l_rows   lob_rows := lob_rows();
    l_offset integer;
    l_chunk  lvarchar2;
  begin
    if p_string is not null
    then
      l_offset := get_offset(p_string);
      loop
        l_chunk := get_chunk(p_string, p_row_separator, null, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          l_rows.extend;
          l_rows(l_rows.last) := get_row(l_rows.last, l_chunk, p_fixed_columns,
                                         p_truncate_columns);
        end if;
        exit when l_offset = 0;
      end loop;
    end if;
    return l_rows;
  end fixedcolumns2;
  --
  function fixedcolumns(p_string           varchar2,
                        p_row_width        number,
                        p_fixed_columns    lob_columns := null,
                        p_truncate_columns number := 0)
    return lob_rows pipelined
  as
    l_row_no integer := 1;
    l_offset integer;
    l_chunk  lvarchar2;
  begin
    if p_string is not null
    then
      l_offset := get_offset(p_string);
      loop
        l_chunk := get_chunk(p_string, p_row_width, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          pipe row(get_row(l_row_no, l_chunk, p_fixed_columns,
                           p_truncate_columns));
        end if;
        exit when l_offset = 0;
        l_row_no := l_row_no + 1;
      end loop;
    end if;
    return;
  exception
    when no_data_needed then return;
  end fixedcolumns;
  --
  function fixedcolumns2(p_string           varchar2,
                         p_row_width        number,
                         p_fixed_columns    lob_columns := null,
                         p_truncate_columns number := 0)
    return lob_rows
  as
    l_rows   lob_rows := lob_rows();
    l_offset integer;
    l_chunk  lvarchar2;
  begin
    if p_string is not null
    then
      l_offset := get_offset(p_string);
      loop
        l_chunk := get_chunk(p_string, p_row_width, l_offset);
        if l_offset != 0 or l_chunk is not null
        then
          l_rows.extend;
          l_rows(l_rows.last) := get_row(l_rows.last, l_chunk, p_fixed_columns,
                                         p_truncate_columns);
        end if;
        exit when l_offset = 0;
      end loop;
    end if;
    return l_rows;
  end fixedcolumns2;
  --
  function get_number_internal(p_string varchar2, p_format varchar2 := null, p_nls varchar2 := null)
    return number
  as
  begin
    return case when p_format is not null and p_nls is not null then to_number(p_string, p_format, p_nls)
                when p_format is not null then to_number(p_string, p_format)
                else to_number(p_string)
           end;
  exception
    when others then
      if sqlcode in(-6502, -1722, -1426) then raise e_failed; else raise; end if;
  end get_number_internal;
  --
  function get_number(p_string   varchar2,
                      p_on_error number := null,
                      p_format   varchar2 := null,
                      p_nls      varchar2 := null,
                      p_format2  varchar2 := null,
                      p_nls2     varchar2 := null,
                      p_format3  varchar2 := null,
                      p_nls3     varchar2 := null)
    return number
  as
  begin
    begin
      if p_format is not null then return get_number_internal(p_string, p_format, p_nls); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format2 is not null then return get_number_internal(p_string, p_format2, p_nls2); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format2 is not null then return get_number_internal(p_string, p_format3, p_nls3); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format is null and p_format2 is null and p_format3 is null then return get_number_internal(p_string); end if;
    exception
      when e_failed then null;
    end;
    return p_on_error;
  end get_number;
  --
  function get_date_internal(p_string varchar2, p_format varchar2 := null, p_nls varchar2 := null)
    return date
  as
  begin
    return case when p_format is not null and p_nls is not null then to_date(p_string, p_format, p_nls)
                when p_format is not null then to_date(p_string, p_format)
                else to_date(p_string)
           end;
  exception
    when others then
      if sqlcode between -1865 and -1830 then raise e_failed; else raise; end if;
  end get_date_internal;
  --
  function get_date(p_string   varchar2,
                    p_on_error date := null,
                    p_format   varchar2 := null,
                    p_nls      varchar2 := null,
                    p_format2  varchar2 := null,
                    p_nls2     varchar2 := null,
                    p_format3  varchar2 := null,
                    p_nls3     varchar2 := null)
    return date
  as
  begin
    begin
      if p_format is not null then return get_date_internal(p_string, p_format, p_nls); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format2 is not null then return get_date_internal(p_string, p_format2, p_nls2); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format2 is not null then return get_date_internal(p_string, p_format3, p_nls3); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format is null and p_format2 is null and p_format3 is null then return get_date_internal(p_string); end if;
    exception
      when e_failed then null;
    end;
    return p_on_error;
  end get_date;
  --
  function get_timestamp_internal(p_string varchar2, p_format varchar2 := null, p_nls varchar2 := null)
    return timestamp_unconstrained
  as
  begin
    return case when p_format is not null and p_nls is not null then to_timestamp(p_string, p_format, p_nls)
                when p_format is not null then to_timestamp(p_string, p_format)
                else to_timestamp(p_string)
           end;
  exception
    when others then
      if sqlcode between -1865 and -1830 or sqlcode in(-1880, -1879) then raise e_failed; else raise; end if;
  end get_timestamp_internal;
  
  --
  function get_timestamp(p_string   varchar2,
                         p_on_error timestamp_unconstrained := null,
                         p_format   varchar2 := null,
                         p_nls      varchar2 := null,
                         p_format2  varchar2 := null,
                         p_nls2     varchar2 := null,
                         p_format3  varchar2 := null,
                         p_nls3     varchar2 := null)
    return timestamp_unconstrained
  as
  begin
    begin
      if p_format is not null then return get_timestamp_internal(p_string, p_format, p_nls); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format2 is not null then return get_timestamp_internal(p_string, p_format2, p_nls2); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format2 is not null then return get_timestamp_internal(p_string, p_format3, p_nls3); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format is null and p_format2 is null and p_format3 is null then return get_timestamp_internal(p_string); end if;
    exception
      when e_failed then null;
    end;
    return p_on_error;
  end get_timestamp;
  --
  function get_timestamp_tz_internal(p_string varchar2, p_format varchar2 := null, p_nls varchar2 := null)
    return timestamp_tz_unconstrained
  as
  begin
    return case when p_format is not null and p_nls is not null then to_timestamp_tz(p_string, p_format, p_nls)
                when p_format is not null then to_timestamp_tz(p_string, p_format)
                else to_timestamp_tz(p_string)
           end;
  exception
    when others then
      if sqlcode between -1865 and -1830 or sqlcode in(-1882, -1880, -1879, -1875, -1874, -1857)
      then raise e_failed;
      else raise;
      end if;
  end get_timestamp_tz_internal;
  --
  function get_timestamp_tz(p_string   varchar2,
                            p_on_error timestamp_tz_unconstrained := null,
                            p_format   varchar2 := null,
                            p_nls      varchar2 := null,
                            p_format2  varchar2 := null,
                            p_nls2     varchar2 := null,
                            p_format3  varchar2 := null,
                            p_nls3     varchar2 := null)
    return timestamp_tz_unconstrained
  as
  begin
    begin
      if p_format is not null then return get_timestamp_tz_internal(p_string, p_format, p_nls); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format2 is not null then return get_timestamp_tz_internal(p_string, p_format2, p_nls2); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format2 is not null then return get_timestamp_tz_internal(p_string, p_format3, p_nls3); end if;
    exception
      when e_failed then null;
    end;
    begin
      if p_format is null and p_format2 is null and p_format3 is null then return get_timestamp_tz_internal(p_string); end if;
    exception
      when e_failed then null;
    end;
    return p_on_error;
  end get_timestamp_tz;
  --
  function get_dsinterval(p_string   varchar2,
                          p_on_error dsinterval_unconstrained := null)
    return dsinterval_unconstrained
  as
  begin
    return to_dsinterval(p_string);
  exception
    when others then
      if sqlcode in(-1873, -1867, -1852, -1851, -1850) then return p_on_error; else raise; end if;
  end get_dsinterval;
  --
  function get_yminterval(p_string   varchar2,
                          p_on_error yminterval_unconstrained := null)
    return yminterval_unconstrained
  as
  begin
    return to_yminterval(p_string);
  exception
    when others then
      if sqlcode in(-1873, -1867, -1843) then return p_on_error; else raise; end if;
  end get_yminterval;
  --
  function string_to_hex(p_string varchar2) return varchar2 as
  begin
    return rawtohex(utl_i18n.string_to_raw(p_string, 'AL32UTF8'));
  end;
  --
  function hex_to_string(p_hex varchar2) return varchar2 as
  begin
    return utl_i18n.raw_to_char(hextoraw(p_hex), 'AL32UTF8');
  end;
end lob2table;
/
show errors;
