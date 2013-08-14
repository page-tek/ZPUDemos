-- ZPU
--
-- Copyright 2004-2008 oharboe - �yvind Harboe - oyvind.harboe@zylin.com
-- Modified by Alastair M. Robinson for the ZPUFlex project.
--
-- The FreeBSD license
-- 
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions
-- are met:
-- 
-- 1. Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimer.
-- 2. Redistributions in binary form must reproduce the above
--    copyright notice, this list of conditions and the following
--    disclaimer in the documentation and/or other materials
--    provided with the distribution.
-- 
-- THIS SOFTWARE IS PROVIDED BY THE ZPU PROJECT ``AS IS'' AND ANY
-- EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
-- PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
-- ZPU PROJECT OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
-- INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
-- OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
-- HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
-- STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
-- ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
-- The views and conclusions contained in the software and documentation
-- are those of the authors and should not be interpreted as representing
-- official policies, either expressed or implied, of the ZPU Project.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library work;
use work.zpu_config.all;
use work.zpupkg.all;

entity Dhrystone_fast_ROM is
generic
	(
		maxAddrBit : integer := maxAddrBitBRAMLimit -- Specify your actual ROM size to save LEs and unnecessary block RAM usage.
	);
port (
	clk : in std_logic;
	areset : in std_logic := '0';
	from_zpu : in ZPU_ToROM;
	to_zpu : out ZPU_FromROM
);
end Dhrystone_fast_ROM;

architecture arch of Dhrystone_fast_ROM is

type ram_type is array(natural range 0 to ((2**(maxAddrBit+1))/4)-1) of std_logic_vector(wordSize-1 downto 0);

shared variable ram : ram_type :=
(
     0 => x"0b0b0b88",
     1 => x"dd040000",
     2 => x"00000000",
     3 => x"00000000",
     4 => x"00000000",
     5 => x"00000000",
     6 => x"00000000",
     7 => x"00000000",
     8 => x"04000000",
     9 => x"00000000",
    10 => x"00000000",
    11 => x"00000000",
    12 => x"00000000",
    13 => x"00000000",
    14 => x"00000000",
    15 => x"00000000",
    16 => x"71fd0608",
    17 => x"72830609",
    18 => x"81058205",
    19 => x"832b2a83",
    20 => x"ffff0652",
    21 => x"04000000",
    22 => x"00000000",
    23 => x"00000000",
    24 => x"71fd0608",
    25 => x"83ffff73",
    26 => x"83060981",
    27 => x"05820583",
    28 => x"2b2b0906",
    29 => x"7383ffff",
    30 => x"0b0b0b0b",
    31 => x"83a50400",
    32 => x"72098105",
    33 => x"72057373",
    34 => x"09060906",
    35 => x"73097306",
    36 => x"070a8106",
    37 => x"53510400",
    38 => x"00000000",
    39 => x"00000000",
    40 => x"72722473",
    41 => x"732e0753",
    42 => x"51040000",
    43 => x"00000000",
    44 => x"00000000",
    45 => x"00000000",
    46 => x"00000000",
    47 => x"00000000",
    48 => x"71737109",
    49 => x"71068106",
    50 => x"09810572",
    51 => x"0a100a72",
    52 => x"0a100a31",
    53 => x"050a8106",
    54 => x"51515351",
    55 => x"04000000",
    56 => x"72722673",
    57 => x"732e0753",
    58 => x"51040000",
    59 => x"00000000",
    60 => x"00000000",
    61 => x"00000000",
    62 => x"00000000",
    63 => x"00000000",
    64 => x"00000000",
    65 => x"00000000",
    66 => x"00000000",
    67 => x"00000000",
    68 => x"00000000",
    69 => x"00000000",
    70 => x"00000000",
    71 => x"00000000",
    72 => x"0b0b0b88",
    73 => x"ba040000",
    74 => x"00000000",
    75 => x"00000000",
    76 => x"00000000",
    77 => x"00000000",
    78 => x"00000000",
    79 => x"00000000",
    80 => x"720a722b",
    81 => x"0a535104",
    82 => x"00000000",
    83 => x"00000000",
    84 => x"00000000",
    85 => x"00000000",
    86 => x"00000000",
    87 => x"00000000",
    88 => x"72729f06",
    89 => x"0981050b",
    90 => x"0b0b889f",
    91 => x"05040000",
    92 => x"00000000",
    93 => x"00000000",
    94 => x"00000000",
    95 => x"00000000",
    96 => x"72722aff",
    97 => x"739f062a",
    98 => x"0974090a",
    99 => x"8106ff05",
   100 => x"06075351",
   101 => x"04000000",
   102 => x"00000000",
   103 => x"00000000",
   104 => x"71715351",
   105 => x"04067383",
   106 => x"06098105",
   107 => x"8205832b",
   108 => x"0b2b0772",
   109 => x"fc060c51",
   110 => x"51040000",
   111 => x"00000000",
   112 => x"72098105",
   113 => x"72050970",
   114 => x"81050906",
   115 => x"0a810653",
   116 => x"51040000",
   117 => x"00000000",
   118 => x"00000000",
   119 => x"00000000",
   120 => x"72098105",
   121 => x"72050970",
   122 => x"81050906",
   123 => x"0a098106",
   124 => x"53510400",
   125 => x"00000000",
   126 => x"00000000",
   127 => x"00000000",
   128 => x"71098105",
   129 => x"52040000",
   130 => x"00000000",
   131 => x"00000000",
   132 => x"00000000",
   133 => x"00000000",
   134 => x"00000000",
   135 => x"00000000",
   136 => x"72720981",
   137 => x"05055351",
   138 => x"04000000",
   139 => x"00000000",
   140 => x"00000000",
   141 => x"00000000",
   142 => x"00000000",
   143 => x"00000000",
   144 => x"72097206",
   145 => x"73730906",
   146 => x"07535104",
   147 => x"00000000",
   148 => x"00000000",
   149 => x"00000000",
   150 => x"00000000",
   151 => x"00000000",
   152 => x"71fc0608",
   153 => x"72830609",
   154 => x"81058305",
   155 => x"1010102a",
   156 => x"81ff0652",
   157 => x"04000000",
   158 => x"00000000",
   159 => x"00000000",
   160 => x"71fc0608",
   161 => x"0b0b0ba1",
   162 => x"88738306",
   163 => x"10100508",
   164 => x"060b0b0b",
   165 => x"88a20400",
   166 => x"00000000",
   167 => x"00000000",
   168 => x"88088c08",
   169 => x"90087575",
   170 => x"0b0b0b99",
   171 => x"fb2d5050",
   172 => x"88085690",
   173 => x"0c8c0c88",
   174 => x"0c510400",
   175 => x"00000000",
   176 => x"88088c08",
   177 => x"90087575",
   178 => x"0b0b0b9b",
   179 => x"ad2d5050",
   180 => x"88085690",
   181 => x"0c8c0c88",
   182 => x"0c510400",
   183 => x"00000000",
   184 => x"72097081",
   185 => x"0509060a",
   186 => x"8106ff05",
   187 => x"70547106",
   188 => x"73097274",
   189 => x"05ff0506",
   190 => x"07515151",
   191 => x"04000000",
   192 => x"72097081",
   193 => x"0509060a",
   194 => x"098106ff",
   195 => x"05705471",
   196 => x"06730972",
   197 => x"7405ff05",
   198 => x"06075151",
   199 => x"51040000",
   200 => x"05ff0504",
   201 => x"00000000",
   202 => x"00000000",
   203 => x"00000000",
   204 => x"00000000",
   205 => x"00000000",
   206 => x"00000000",
   207 => x"00000000",
   208 => x"04000000",
   209 => x"00000000",
   210 => x"00000000",
   211 => x"00000000",
   212 => x"00000000",
   213 => x"00000000",
   214 => x"00000000",
   215 => x"00000000",
   216 => x"71810552",
   217 => x"04000000",
   218 => x"00000000",
   219 => x"00000000",
   220 => x"00000000",
   221 => x"00000000",
   222 => x"00000000",
   223 => x"00000000",
   224 => x"00000000",
   225 => x"00000000",
   226 => x"00000000",
   227 => x"00000000",
   228 => x"00000000",
   229 => x"00000000",
   230 => x"00000000",
   231 => x"00000000",
   232 => x"02840572",
   233 => x"10100552",
   234 => x"04000000",
   235 => x"00000000",
   236 => x"00000000",
   237 => x"00000000",
   238 => x"00000000",
   239 => x"00000000",
   240 => x"00000000",
   241 => x"00000000",
   242 => x"00000000",
   243 => x"00000000",
   244 => x"00000000",
   245 => x"00000000",
   246 => x"00000000",
   247 => x"00000000",
   248 => x"717105ff",
   249 => x"05715351",
   250 => x"020d0400",
   251 => x"00000000",
   252 => x"00000000",
   253 => x"00000000",
   254 => x"00000000",
   255 => x"00000000",
   256 => x"10101010",
   257 => x"10101010",
   258 => x"10101010",
   259 => x"10101010",
   260 => x"10101010",
   261 => x"10101010",
   262 => x"10101010",
   263 => x"10101053",
   264 => x"51047381",
   265 => x"ff067383",
   266 => x"06098105",
   267 => x"83051010",
   268 => x"102b0772",
   269 => x"fc060c51",
   270 => x"51047272",
   271 => x"80728106",
   272 => x"ff050972",
   273 => x"06057110",
   274 => x"52720a10",
   275 => x"0a5372ed",
   276 => x"38515153",
   277 => x"51040000",
   278 => x"800488da",
   279 => x"0488da0b",
   280 => x"8fa90402",
   281 => x"c0050d02",
   282 => x"80c4050b",
   283 => x"0b0ba6b0",
   284 => x"5a5c807c",
   285 => x"7084055e",
   286 => x"08715f5f",
   287 => x"577d7084",
   288 => x"055f0856",
   289 => x"80587598",
   290 => x"2a76882b",
   291 => x"57557480",
   292 => x"2e82d038",
   293 => x"7c802eb9",
   294 => x"38805d74",
   295 => x"80e42e81",
   296 => x"9f387480",
   297 => x"e42680dc",
   298 => x"387480e3",
   299 => x"2eba38a5",
   300 => x"518bec2d",
   301 => x"74518bec",
   302 => x"2d821757",
   303 => x"81185883",
   304 => x"7825c338",
   305 => x"74ffb638",
   306 => x"7e880c02",
   307 => x"80c0050d",
   308 => x"0474a52e",
   309 => x"09810698",
   310 => x"38810b81",
   311 => x"19595d83",
   312 => x"7825ffa2",
   313 => x"3889c404",
   314 => x"7b841d71",
   315 => x"08575d5a",
   316 => x"74518bec",
   317 => x"2d811781",
   318 => x"19595783",
   319 => x"7825ff86",
   320 => x"3889c404",
   321 => x"7480f32e",
   322 => x"098106ff",
   323 => x"a2387b84",
   324 => x"1d710870",
   325 => x"545b5d54",
   326 => x"8c8f2d80",
   327 => x"0bff1155",
   328 => x"53807325",
   329 => x"ff963878",
   330 => x"7081055a",
   331 => x"84e02d70",
   332 => x"52558bec",
   333 => x"2d811774",
   334 => x"ff165654",
   335 => x"578aa104",
   336 => x"7b841d71",
   337 => x"080b0b0b",
   338 => x"a6b00b0b",
   339 => x"0b0ba5e0",
   340 => x"615f585e",
   341 => x"525d5372",
   342 => x"ba38b00b",
   343 => x"0b0b0ba5",
   344 => x"e00b8580",
   345 => x"2d811454",
   346 => x"ff145473",
   347 => x"84e02d7b",
   348 => x"7081055d",
   349 => x"85802d81",
   350 => x"1a5a730b",
   351 => x"0b0ba5e0",
   352 => x"2e098106",
   353 => x"e338807b",
   354 => x"85802d79",
   355 => x"ff115553",
   356 => x"8aa1048a",
   357 => x"52725199",
   358 => x"d62d8808",
   359 => x"0b0b0ba1",
   360 => x"980584e0",
   361 => x"2d747081",
   362 => x"05568580",
   363 => x"2d8a5272",
   364 => x"5199b12d",
   365 => x"88085388",
   366 => x"08d93873",
   367 => x"0b0b0ba5",
   368 => x"e02ec338",
   369 => x"ff145473",
   370 => x"84e02d7b",
   371 => x"7081055d",
   372 => x"85802d81",
   373 => x"1a5a730b",
   374 => x"0b0ba5e0",
   375 => x"2effa738",
   376 => x"8ae80476",
   377 => x"880c0280",
   378 => x"c0050d04",
   379 => x"02f8050d",
   380 => x"7352ff84",
   381 => x"0870882a",
   382 => x"70810651",
   383 => x"51517080",
   384 => x"2ef03871",
   385 => x"ff840c71",
   386 => x"880c0288",
   387 => x"050d0402",
   388 => x"f0050d75",
   389 => x"53807384",
   390 => x"e02d5254",
   391 => x"70742ea6",
   392 => x"38705281",
   393 => x"1353ff84",
   394 => x"0870882a",
   395 => x"70810651",
   396 => x"51517080",
   397 => x"2ef03871",
   398 => x"ff840c81",
   399 => x"147384e0",
   400 => x"2d535471",
   401 => x"de387388",
   402 => x"0c029005",
   403 => x"0d04c808",
   404 => x"880c0402",
   405 => x"fc050d80",
   406 => x"c10b80f5",
   407 => x"fc0b8580",
   408 => x"2d800b80",
   409 => x"f8940c70",
   410 => x"880c0284",
   411 => x"050d0402",
   412 => x"f8050d80",
   413 => x"0b80f5fc",
   414 => x"0b84e02d",
   415 => x"52527080",
   416 => x"c12e9d38",
   417 => x"7180f894",
   418 => x"080780f8",
   419 => x"940c80c2",
   420 => x"0b80f680",
   421 => x"0b85802d",
   422 => x"70880c02",
   423 => x"88050d04",
   424 => x"810b80f8",
   425 => x"94080780",
   426 => x"f8940c80",
   427 => x"c20b80f6",
   428 => x"800b8580",
   429 => x"2d70880c",
   430 => x"0288050d",
   431 => x"0402f005",
   432 => x"0d757008",
   433 => x"8a055353",
   434 => x"80f5fc0b",
   435 => x"84e02d51",
   436 => x"7080c12e",
   437 => x"8c3873f0",
   438 => x"3870880c",
   439 => x"0290050d",
   440 => x"04ff1270",
   441 => x"80f5f808",
   442 => x"31740c88",
   443 => x"0c029005",
   444 => x"0d0402ec",
   445 => x"050d80f6",
   446 => x"a4085574",
   447 => x"802e8c38",
   448 => x"76750871",
   449 => x"0c80f6a4",
   450 => x"0856548c",
   451 => x"155380f5",
   452 => x"f808528a",
   453 => x"5197872d",
   454 => x"73880c02",
   455 => x"94050d04",
   456 => x"02e8050d",
   457 => x"77700856",
   458 => x"56b05380",
   459 => x"f6a40852",
   460 => x"74519ed9",
   461 => x"2d850b8c",
   462 => x"170c850b",
   463 => x"8c160c75",
   464 => x"08750c80",
   465 => x"f6a40854",
   466 => x"73802e8a",
   467 => x"38730875",
   468 => x"0c80f6a4",
   469 => x"08548c14",
   470 => x"5380f5f8",
   471 => x"08528a51",
   472 => x"97872d84",
   473 => x"1508ae38",
   474 => x"860b8c16",
   475 => x"0c881552",
   476 => x"88160851",
   477 => x"96a12d80",
   478 => x"f6a40870",
   479 => x"08760c54",
   480 => x"8c157054",
   481 => x"548a5273",
   482 => x"08519787",
   483 => x"2d73880c",
   484 => x"0298050d",
   485 => x"04750854",
   486 => x"b0537352",
   487 => x"75519ed9",
   488 => x"2d73880c",
   489 => x"0298050d",
   490 => x"0402c805",
   491 => x"0d80f590",
   492 => x"0b80f5c4",
   493 => x"0c80f5c8",
   494 => x"0b80f6a4",
   495 => x"0c80f590",
   496 => x"0b80f5c8",
   497 => x"0c800b80",
   498 => x"f5c80b84",
   499 => x"050c820b",
   500 => x"80f5c80b",
   501 => x"88050ca8",
   502 => x"0b80f5c8",
   503 => x"0b8c050c",
   504 => x"9f53a1ac",
   505 => x"5280f5d8",
   506 => x"519ed92d",
   507 => x"9f53a1cc",
   508 => x"5280f7f4",
   509 => x"519ed92d",
   510 => x"8a0bb3dc",
   511 => x"0ca4ac51",
   512 => x"88e32da1",
   513 => x"ec5188e3",
   514 => x"2da4ac51",
   515 => x"88e32da5",
   516 => x"dc08802e",
   517 => x"849138a2",
   518 => x"9c5188e3",
   519 => x"2da4ac51",
   520 => x"88e32da5",
   521 => x"d80852a2",
   522 => x"c85188e3",
   523 => x"2dc80870",
   524 => x"a6fc0c56",
   525 => x"8158800b",
   526 => x"a5d80825",
   527 => x"82dc3802",
   528 => x"ac055b80",
   529 => x"c10b80f5",
   530 => x"fc0b8580",
   531 => x"2d810b80",
   532 => x"f8940c80",
   533 => x"c20b80f6",
   534 => x"800b8580",
   535 => x"2d825c83",
   536 => x"5a9f53a2",
   537 => x"f85280f6",
   538 => x"84519ed9",
   539 => x"2d815d80",
   540 => x"0b80f684",
   541 => x"5380f7f4",
   542 => x"525598b9",
   543 => x"2d880875",
   544 => x"2e098106",
   545 => x"83388155",
   546 => x"7480f894",
   547 => x"0c7b7057",
   548 => x"55748325",
   549 => x"a1387410",
   550 => x"1015fd05",
   551 => x"5e02b805",
   552 => x"fc055383",
   553 => x"52755197",
   554 => x"872d811c",
   555 => x"705d7057",
   556 => x"55837524",
   557 => x"e1387d54",
   558 => x"7453a780",
   559 => x"5280f6ac",
   560 => x"5197992d",
   561 => x"80f6a408",
   562 => x"70085757",
   563 => x"b0537652",
   564 => x"75519ed9",
   565 => x"2d850b8c",
   566 => x"180c850b",
   567 => x"8c170c76",
   568 => x"08760c80",
   569 => x"f6a40855",
   570 => x"74802e8a",
   571 => x"38740876",
   572 => x"0c80f6a4",
   573 => x"08558c15",
   574 => x"5380f5f8",
   575 => x"08528a51",
   576 => x"97872d84",
   577 => x"160883d8",
   578 => x"38860b8c",
   579 => x"170c8816",
   580 => x"52881708",
   581 => x"5196a12d",
   582 => x"80f6a408",
   583 => x"7008770c",
   584 => x"578c1670",
   585 => x"54558a52",
   586 => x"74085197",
   587 => x"872d80c1",
   588 => x"0b80f680",
   589 => x"0b84e02d",
   590 => x"56567575",
   591 => x"26a53880",
   592 => x"c3527551",
   593 => x"98852d88",
   594 => x"087d2e82",
   595 => x"e2388116",
   596 => x"7081ff06",
   597 => x"80f6800b",
   598 => x"84e02d52",
   599 => x"57557476",
   600 => x"27dd3879",
   601 => x"7c297e53",
   602 => x"5199fb2d",
   603 => x"88085c88",
   604 => x"088a0580",
   605 => x"f5fc0b84",
   606 => x"e02d80f5",
   607 => x"f8085957",
   608 => x"557580c1",
   609 => x"2e82f438",
   610 => x"78f73881",
   611 => x"1858a5d8",
   612 => x"087825fd",
   613 => x"ae38a6fc",
   614 => x"0856c808",
   615 => x"7080f5c0",
   616 => x"0c707731",
   617 => x"70a6f80c",
   618 => x"53a39852",
   619 => x"5b88e32d",
   620 => x"a6f80856",
   621 => x"80f77625",
   622 => x"80f338a5",
   623 => x"d8087053",
   624 => x"7687e829",
   625 => x"525a99fb",
   626 => x"2d8808a6",
   627 => x"f00c7552",
   628 => x"7987e829",
   629 => x"5199fb2d",
   630 => x"8808a6f4",
   631 => x"0c755279",
   632 => x"84b92951",
   633 => x"99fb2d88",
   634 => x"0880f6a8",
   635 => x"0ca3a851",
   636 => x"88e32da6",
   637 => x"f00852a3",
   638 => x"d85188e3",
   639 => x"2da3e051",
   640 => x"88e32da6",
   641 => x"f40852a3",
   642 => x"d85188e3",
   643 => x"2d80f6a8",
   644 => x"0852a490",
   645 => x"5188e32d",
   646 => x"a4ac5188",
   647 => x"e32d800b",
   648 => x"880c02b8",
   649 => x"050d04a4",
   650 => x"b051909a",
   651 => x"04a4e051",
   652 => x"88e32da5",
   653 => x"985188e3",
   654 => x"2da4ac51",
   655 => x"88e32da6",
   656 => x"f808a5d8",
   657 => x"08705471",
   658 => x"87e82953",
   659 => x"5b5699fb",
   660 => x"2d8808a6",
   661 => x"f00c7552",
   662 => x"7987e829",
   663 => x"5199fb2d",
   664 => x"8808a6f4",
   665 => x"0c755279",
   666 => x"84b92951",
   667 => x"99fb2d88",
   668 => x"0880f6a8",
   669 => x"0ca3a851",
   670 => x"88e32da6",
   671 => x"f00852a3",
   672 => x"d85188e3",
   673 => x"2da3e051",
   674 => x"88e32da6",
   675 => x"f40852a3",
   676 => x"d85188e3",
   677 => x"2d80f6a8",
   678 => x"0852a490",
   679 => x"5188e32d",
   680 => x"a4ac5188",
   681 => x"e32d800b",
   682 => x"880c02b8",
   683 => x"050d0402",
   684 => x"b805f805",
   685 => x"52805196",
   686 => x"a12d9f53",
   687 => x"a5b85280",
   688 => x"f684519e",
   689 => x"d92d7778",
   690 => x"80f5f80c",
   691 => x"81177081",
   692 => x"ff0680f6",
   693 => x"800b84e0",
   694 => x"2d525856",
   695 => x"5a92de04",
   696 => x"760856b0",
   697 => x"53755276",
   698 => x"519ed92d",
   699 => x"80c10b80",
   700 => x"f6800b84",
   701 => x"e02d5656",
   702 => x"92ba04ff",
   703 => x"15707831",
   704 => x"7c0c5980",
   705 => x"59938b04",
   706 => x"02f8050d",
   707 => x"73823270",
   708 => x"09810570",
   709 => x"72078025",
   710 => x"880c5252",
   711 => x"0288050d",
   712 => x"0402f405",
   713 => x"0d747671",
   714 => x"53545271",
   715 => x"822e8338",
   716 => x"83517181",
   717 => x"2e9b3881",
   718 => x"7226a038",
   719 => x"71822ebc",
   720 => x"3871842e",
   721 => x"ac387073",
   722 => x"0c70880c",
   723 => x"028c050d",
   724 => x"0480e40b",
   725 => x"80f5f808",
   726 => x"258c3880",
   727 => x"730c7088",
   728 => x"0c028c05",
   729 => x"0d048373",
   730 => x"0c70880c",
   731 => x"028c050d",
   732 => x"0482730c",
   733 => x"70880c02",
   734 => x"8c050d04",
   735 => x"81730c70",
   736 => x"880c028c",
   737 => x"050d0402",
   738 => x"fc050d74",
   739 => x"74148205",
   740 => x"710c880c",
   741 => x"0284050d",
   742 => x"0402d805",
   743 => x"0d7b7d7f",
   744 => x"61851270",
   745 => x"822b7511",
   746 => x"70747170",
   747 => x"8405530c",
   748 => x"5a5a5d5b",
   749 => x"760c7980",
   750 => x"f8180c79",
   751 => x"86125257",
   752 => x"585a5a76",
   753 => x"76249938",
   754 => x"76b32982",
   755 => x"2b791151",
   756 => x"53767370",
   757 => x"8405550c",
   758 => x"81145475",
   759 => x"7425f238",
   760 => x"7681cc29",
   761 => x"19fc1108",
   762 => x"8105fc12",
   763 => x"0c7a1970",
   764 => x"089fa013",
   765 => x"0c585685",
   766 => x"0b80f5f8",
   767 => x"0c75880c",
   768 => x"02a8050d",
   769 => x"0402f405",
   770 => x"0d029305",
   771 => x"84e02d51",
   772 => x"80028405",
   773 => x"970584e0",
   774 => x"2d545270",
   775 => x"732e8938",
   776 => x"71880c02",
   777 => x"8c050d04",
   778 => x"7080f5fc",
   779 => x"0b85802d",
   780 => x"810b880c",
   781 => x"028c050d",
   782 => x"0402dc05",
   783 => x"0d7a7c59",
   784 => x"56820b83",
   785 => x"19555574",
   786 => x"167084e0",
   787 => x"2d7584e0",
   788 => x"2d5b5153",
   789 => x"72792e80",
   790 => x"c73880c1",
   791 => x"0b811681",
   792 => x"16565657",
   793 => x"827525df",
   794 => x"38ffa917",
   795 => x"7081ff06",
   796 => x"55597382",
   797 => x"26833887",
   798 => x"55815376",
   799 => x"80d22e98",
   800 => x"38775275",
   801 => x"519ff22d",
   802 => x"80537288",
   803 => x"08258938",
   804 => x"871580f5",
   805 => x"f80c8153",
   806 => x"72880c02",
   807 => x"a4050d04",
   808 => x"7280f5fc",
   809 => x"0b85802d",
   810 => x"827525ff",
   811 => x"9a3898e9",
   812 => x"04940802",
   813 => x"940cfd3d",
   814 => x"0d805394",
   815 => x"088c0508",
   816 => x"52940888",
   817 => x"05085182",
   818 => x"de3f8808",
   819 => x"70880c54",
   820 => x"853d0d94",
   821 => x"0c049408",
   822 => x"02940cfd",
   823 => x"3d0d8153",
   824 => x"94088c05",
   825 => x"08529408",
   826 => x"88050851",
   827 => x"82b93f88",
   828 => x"0870880c",
   829 => x"54853d0d",
   830 => x"940c0494",
   831 => x"0802940c",
   832 => x"f93d0d80",
   833 => x"0b9408fc",
   834 => x"050c9408",
   835 => x"88050880",
   836 => x"25ab3894",
   837 => x"08880508",
   838 => x"30940888",
   839 => x"050c800b",
   840 => x"9408f405",
   841 => x"0c9408fc",
   842 => x"05088838",
   843 => x"810b9408",
   844 => x"f4050c94",
   845 => x"08f40508",
   846 => x"9408fc05",
   847 => x"0c94088c",
   848 => x"05088025",
   849 => x"ab389408",
   850 => x"8c050830",
   851 => x"94088c05",
   852 => x"0c800b94",
   853 => x"08f0050c",
   854 => x"9408fc05",
   855 => x"08883881",
   856 => x"0b9408f0",
   857 => x"050c9408",
   858 => x"f0050894",
   859 => x"08fc050c",
   860 => x"80539408",
   861 => x"8c050852",
   862 => x"94088805",
   863 => x"085181a7",
   864 => x"3f880870",
   865 => x"9408f805",
   866 => x"0c549408",
   867 => x"fc050880",
   868 => x"2e8c3894",
   869 => x"08f80508",
   870 => x"309408f8",
   871 => x"050c9408",
   872 => x"f8050870",
   873 => x"880c5489",
   874 => x"3d0d940c",
   875 => x"04940802",
   876 => x"940cfb3d",
   877 => x"0d800b94",
   878 => x"08fc050c",
   879 => x"94088805",
   880 => x"08802593",
   881 => x"38940888",
   882 => x"05083094",
   883 => x"0888050c",
   884 => x"810b9408",
   885 => x"fc050c94",
   886 => x"088c0508",
   887 => x"80258c38",
   888 => x"94088c05",
   889 => x"08309408",
   890 => x"8c050c81",
   891 => x"5394088c",
   892 => x"05085294",
   893 => x"08880508",
   894 => x"51ad3f88",
   895 => x"08709408",
   896 => x"f8050c54",
   897 => x"9408fc05",
   898 => x"08802e8c",
   899 => x"389408f8",
   900 => x"05083094",
   901 => x"08f8050c",
   902 => x"9408f805",
   903 => x"0870880c",
   904 => x"54873d0d",
   905 => x"940c0494",
   906 => x"0802940c",
   907 => x"fd3d0d81",
   908 => x"0b9408fc",
   909 => x"050c800b",
   910 => x"9408f805",
   911 => x"0c94088c",
   912 => x"05089408",
   913 => x"88050827",
   914 => x"ac389408",
   915 => x"fc050880",
   916 => x"2ea33880",
   917 => x"0b94088c",
   918 => x"05082499",
   919 => x"3894088c",
   920 => x"05081094",
   921 => x"088c050c",
   922 => x"9408fc05",
   923 => x"08109408",
   924 => x"fc050cc9",
   925 => x"399408fc",
   926 => x"0508802e",
   927 => x"80c93894",
   928 => x"088c0508",
   929 => x"94088805",
   930 => x"0826a138",
   931 => x"94088805",
   932 => x"0894088c",
   933 => x"05083194",
   934 => x"0888050c",
   935 => x"9408f805",
   936 => x"089408fc",
   937 => x"05080794",
   938 => x"08f8050c",
   939 => x"9408fc05",
   940 => x"08812a94",
   941 => x"08fc050c",
   942 => x"94088c05",
   943 => x"08812a94",
   944 => x"088c050c",
   945 => x"ffaf3994",
   946 => x"08900508",
   947 => x"802e8f38",
   948 => x"94088805",
   949 => x"08709408",
   950 => x"f4050c51",
   951 => x"8d399408",
   952 => x"f8050870",
   953 => x"9408f405",
   954 => x"0c519408",
   955 => x"f4050888",
   956 => x"0c853d0d",
   957 => x"940c0494",
   958 => x"0802940c",
   959 => x"ff3d0d80",
   960 => x"0b9408fc",
   961 => x"050c9408",
   962 => x"88050881",
   963 => x"06ff1170",
   964 => x"09709408",
   965 => x"8c050806",
   966 => x"9408fc05",
   967 => x"08119408",
   968 => x"fc050c94",
   969 => x"08880508",
   970 => x"812a9408",
   971 => x"88050c94",
   972 => x"088c0508",
   973 => x"1094088c",
   974 => x"050c5151",
   975 => x"51519408",
   976 => x"88050880",
   977 => x"2e8438ff",
   978 => x"bd399408",
   979 => x"fc050870",
   980 => x"880c5183",
   981 => x"3d0d940c",
   982 => x"04fc3d0d",
   983 => x"7670797b",
   984 => x"55555555",
   985 => x"8f72278c",
   986 => x"38727507",
   987 => x"83065170",
   988 => x"802ea738",
   989 => x"ff125271",
   990 => x"ff2e9838",
   991 => x"72708105",
   992 => x"54337470",
   993 => x"81055634",
   994 => x"ff125271",
   995 => x"ff2e0981",
   996 => x"06ea3874",
   997 => x"880c863d",
   998 => x"0d047451",
   999 => x"72708405",
  1000 => x"54087170",
  1001 => x"8405530c",
  1002 => x"72708405",
  1003 => x"54087170",
  1004 => x"8405530c",
  1005 => x"72708405",
  1006 => x"54087170",
  1007 => x"8405530c",
  1008 => x"72708405",
  1009 => x"54087170",
  1010 => x"8405530c",
  1011 => x"f0125271",
  1012 => x"8f26c938",
  1013 => x"83722795",
  1014 => x"38727084",
  1015 => x"05540871",
  1016 => x"70840553",
  1017 => x"0cfc1252",
  1018 => x"718326ed",
  1019 => x"387054ff",
  1020 => x"8339fb3d",
  1021 => x"0d777970",
  1022 => x"72078306",
  1023 => x"53545270",
  1024 => x"93387173",
  1025 => x"73085456",
  1026 => x"54717308",
  1027 => x"2e80c438",
  1028 => x"73755452",
  1029 => x"71337081",
  1030 => x"ff065254",
  1031 => x"70802e9d",
  1032 => x"38723355",
  1033 => x"70752e09",
  1034 => x"81069538",
  1035 => x"81128114",
  1036 => x"71337081",
  1037 => x"ff065456",
  1038 => x"545270e5",
  1039 => x"38723355",
  1040 => x"7381ff06",
  1041 => x"7581ff06",
  1042 => x"71713188",
  1043 => x"0c525287",
  1044 => x"3d0d0471",
  1045 => x"0970f7fb",
  1046 => x"fdff1406",
  1047 => x"70f88482",
  1048 => x"81800651",
  1049 => x"51517097",
  1050 => x"38841484",
  1051 => x"16710854",
  1052 => x"56547175",
  1053 => x"082edc38",
  1054 => x"73755452",
  1055 => x"ff963980",
  1056 => x"0b880c87",
  1057 => x"3d0d0400",
  1058 => x"00ffffff",
  1059 => x"ff00ffff",
  1060 => x"ffff00ff",
  1061 => x"ffffff00",
  1062 => x"30313233",
  1063 => x"34353637",
  1064 => x"38394142",
  1065 => x"43444546",
  1066 => x"00000000",
  1067 => x"44485259",
  1068 => x"53544f4e",
  1069 => x"45205052",
  1070 => x"4f475241",
  1071 => x"4d2c2053",
  1072 => x"4f4d4520",
  1073 => x"53545249",
  1074 => x"4e470000",
  1075 => x"44485259",
  1076 => x"53544f4e",
  1077 => x"45205052",
  1078 => x"4f475241",
  1079 => x"4d2c2031",
  1080 => x"27535420",
  1081 => x"53545249",
  1082 => x"4e470000",
  1083 => x"44687279",
  1084 => x"73746f6e",
  1085 => x"65204265",
  1086 => x"6e63686d",
  1087 => x"61726b2c",
  1088 => x"20566572",
  1089 => x"73696f6e",
  1090 => x"20322e31",
  1091 => x"20284c61",
  1092 => x"6e677561",
  1093 => x"67653a20",
  1094 => x"43290a00",
  1095 => x"50726f67",
  1096 => x"72616d20",
  1097 => x"636f6d70",
  1098 => x"696c6564",
  1099 => x"20776974",
  1100 => x"68202772",
  1101 => x"65676973",
  1102 => x"74657227",
  1103 => x"20617474",
  1104 => x"72696275",
  1105 => x"74650a00",
  1106 => x"45786563",
  1107 => x"7574696f",
  1108 => x"6e207374",
  1109 => x"61727473",
  1110 => x"2c202564",
  1111 => x"2072756e",
  1112 => x"73207468",
  1113 => x"726f7567",
  1114 => x"68204468",
  1115 => x"72797374",
  1116 => x"6f6e650a",
  1117 => x"00000000",
  1118 => x"44485259",
  1119 => x"53544f4e",
  1120 => x"45205052",
  1121 => x"4f475241",
  1122 => x"4d2c2032",
  1123 => x"274e4420",
  1124 => x"53545249",
  1125 => x"4e470000",
  1126 => x"55736572",
  1127 => x"2074696d",
  1128 => x"653a2025",
  1129 => x"640a0000",
  1130 => x"4d696372",
  1131 => x"6f736563",
  1132 => x"6f6e6473",
  1133 => x"20666f72",
  1134 => x"206f6e65",
  1135 => x"2072756e",
  1136 => x"20746872",
  1137 => x"6f756768",
  1138 => x"20446872",
  1139 => x"7973746f",
  1140 => x"6e653a20",
  1141 => x"00000000",
  1142 => x"2564200a",
  1143 => x"00000000",
  1144 => x"44687279",
  1145 => x"73746f6e",
  1146 => x"65732070",
  1147 => x"65722053",
  1148 => x"65636f6e",
  1149 => x"643a2020",
  1150 => x"20202020",
  1151 => x"20202020",
  1152 => x"20202020",
  1153 => x"20202020",
  1154 => x"20202020",
  1155 => x"00000000",
  1156 => x"56415820",
  1157 => x"4d495053",
  1158 => x"20726174",
  1159 => x"696e6720",
  1160 => x"2a203130",
  1161 => x"3030203d",
  1162 => x"20256420",
  1163 => x"0a000000",
  1164 => x"50726f67",
  1165 => x"72616d20",
  1166 => x"636f6d70",
  1167 => x"696c6564",
  1168 => x"20776974",
  1169 => x"686f7574",
  1170 => x"20277265",
  1171 => x"67697374",
  1172 => x"65722720",
  1173 => x"61747472",
  1174 => x"69627574",
  1175 => x"650a0000",
  1176 => x"4d656173",
  1177 => x"75726564",
  1178 => x"2074696d",
  1179 => x"6520746f",
  1180 => x"6f20736d",
  1181 => x"616c6c20",
  1182 => x"746f206f",
  1183 => x"62746169",
  1184 => x"6e206d65",
  1185 => x"616e696e",
  1186 => x"6766756c",
  1187 => x"20726573",
  1188 => x"756c7473",
  1189 => x"0a000000",
  1190 => x"506c6561",
  1191 => x"73652069",
  1192 => x"6e637265",
  1193 => x"61736520",
  1194 => x"6e756d62",
  1195 => x"6572206f",
  1196 => x"66207275",
  1197 => x"6e730a00",
  1198 => x"44485259",
  1199 => x"53544f4e",
  1200 => x"45205052",
  1201 => x"4f475241",
  1202 => x"4d2c2033",
  1203 => x"27524420",
  1204 => x"53545249",
  1205 => x"4e470000",
  1206 => x"000061a8",
  1207 => x"00000000",
	others => x"00000000"
);

begin

process (clk)
begin
	if (clk'event and clk = '1') then
		if (from_zpu.memAWriteEnable = '1') and (from_zpu.memBWriteEnable = '1') and (from_zpu.memAAddr=from_zpu.memBAddr) and (from_zpu.memAWrite/=from_zpu.memBWrite) then
			report "write collision" severity failure;
		end if;
	
		if (from_zpu.memAWriteEnable = '1') then
			ram(to_integer(unsigned(from_zpu.memAAddr(maxAddrBit downto 2)))) := from_zpu.memAWrite;
			to_zpu.memARead <= from_zpu.memAWrite;
		else
			to_zpu.memARead <= ram(to_integer(unsigned(from_zpu.memAAddr(maxAddrBit downto 2))));
		end if;
	end if;
end process;

process (clk)
begin
	if (clk'event and clk = '1') then
		if (from_zpu.memBWriteEnable = '1') then
			ram(to_integer(unsigned(from_zpu.memBAddr(maxAddrBit downto 2)))) := from_zpu.memBWrite;
			to_zpu.memBRead <= from_zpu.memBWrite;
		else
			to_zpu.memBRead <= ram(to_integer(unsigned(from_zpu.memBAddr(maxAddrBit downto 2))));
		end if;
	end if;
end process;


end arch;
