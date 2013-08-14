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

entity Dhrystone_min_ROM is
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
end Dhrystone_min_ROM;

architecture arch of Dhrystone_min_ROM is

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
   161 => x"0b0b0b9f",
   162 => x"e8738306",
   163 => x"10100508",
   164 => x"060b0b0b",
   165 => x"88a20400",
   166 => x"00000000",
   167 => x"00000000",
   168 => x"88088c08",
   169 => x"90087575",
   170 => x"0b0b0b98",
   171 => x"db2d5050",
   172 => x"88085690",
   173 => x"0c8c0c88",
   174 => x"0c510400",
   175 => x"00000000",
   176 => x"88088c08",
   177 => x"90087575",
   178 => x"0b0b0b9a",
   179 => x"8d2d5050",
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
   280 => x"8e8e04f1",
   281 => x"3d0d923d",
   282 => x"0b0b0ba5",
   283 => x"905a5c80",
   284 => x"7c708405",
   285 => x"5e08715f",
   286 => x"5f577d70",
   287 => x"84055f08",
   288 => x"56805875",
   289 => x"982a7688",
   290 => x"2b575574",
   291 => x"802e82b8",
   292 => x"387c802e",
   293 => x"b738805d",
   294 => x"7480e42e",
   295 => x"81983874",
   296 => x"80e42680",
   297 => x"d8387480",
   298 => x"e32eb738",
   299 => x"a5518dff",
   300 => x"3f74518d",
   301 => x"fa3f8217",
   302 => x"57811858",
   303 => x"837825c3",
   304 => x"3874ffb6",
   305 => x"387e880c",
   306 => x"913d0d04",
   307 => x"74a52e09",
   308 => x"81069738",
   309 => x"810b8119",
   310 => x"595d8378",
   311 => x"25ffa438",
   312 => x"e0397b84",
   313 => x"1d710857",
   314 => x"5d5a7451",
   315 => x"8dc13f81",
   316 => x"17811959",
   317 => x"57837825",
   318 => x"ff8938c5",
   319 => x"397480f3",
   320 => x"2e098106",
   321 => x"ffa6387b",
   322 => x"841d7108",
   323 => x"70545b5d",
   324 => x"548dbb3f",
   325 => x"800bff11",
   326 => x"55538073",
   327 => x"25ff9a38",
   328 => x"78708105",
   329 => x"5a337052",
   330 => x"558d843f",
   331 => x"811774ff",
   332 => x"16565457",
   333 => x"e5397b84",
   334 => x"1d71080b",
   335 => x"0b0ba590",
   336 => x"0b0b0b0b",
   337 => x"a4c0615f",
   338 => x"585e525d",
   339 => x"5372b138",
   340 => x"b00b0b0b",
   341 => x"0ba4c034",
   342 => x"811454ff",
   343 => x"14547333",
   344 => x"7b708105",
   345 => x"5d34811a",
   346 => x"5a730b0b",
   347 => x"0ba4c02e",
   348 => x"098106e7",
   349 => x"38807b34",
   350 => x"79ff1155",
   351 => x"53ff9b39",
   352 => x"8a527251",
   353 => x"8db03f88",
   354 => x"080b0b0b",
   355 => x"9ff80533",
   356 => x"74708105",
   357 => x"56348a52",
   358 => x"72518cf5",
   359 => x"3f880853",
   360 => x"8808dd38",
   361 => x"730b0b0b",
   362 => x"a4c02ec9",
   363 => x"38ff1454",
   364 => x"73337b70",
   365 => x"81055d34",
   366 => x"811a5a73",
   367 => x"0b0b0ba4",
   368 => x"c02effb1",
   369 => x"38ff9439",
   370 => x"76880c91",
   371 => x"3d0d04c8",
   372 => x"08880c04",
   373 => x"803d0d80",
   374 => x"c10b80f4",
   375 => x"dc34800b",
   376 => x"80f6f40c",
   377 => x"70880c82",
   378 => x"3d0d04ff",
   379 => x"3d0d800b",
   380 => x"80f4dc33",
   381 => x"52527080",
   382 => x"c12e9938",
   383 => x"7180f6f4",
   384 => x"080780f6",
   385 => x"f40c80c2",
   386 => x"0b80f4e0",
   387 => x"3470880c",
   388 => x"833d0d04",
   389 => x"810b80f6",
   390 => x"f4080780",
   391 => x"f6f40c80",
   392 => x"c20b80f4",
   393 => x"e0347088",
   394 => x"0c833d0d",
   395 => x"04fd3d0d",
   396 => x"7570088a",
   397 => x"05535380",
   398 => x"f4dc3351",
   399 => x"7080c12e",
   400 => x"8b3873f3",
   401 => x"3870880c",
   402 => x"853d0d04",
   403 => x"ff127080",
   404 => x"f4d80831",
   405 => x"740c880c",
   406 => x"853d0d04",
   407 => x"fc3d0d80",
   408 => x"f5840855",
   409 => x"74802e8c",
   410 => x"38767508",
   411 => x"710c80f5",
   412 => x"84085654",
   413 => x"8c155380",
   414 => x"f4d80852",
   415 => x"8a51889c",
   416 => x"3f73880c",
   417 => x"863d0d04",
   418 => x"fb3d0d77",
   419 => x"70085656",
   420 => x"b05380f5",
   421 => x"84085274",
   422 => x"51909e3f",
   423 => x"850b8c17",
   424 => x"0c850b8c",
   425 => x"160c7508",
   426 => x"750c80f5",
   427 => x"84085473",
   428 => x"802e8a38",
   429 => x"7308750c",
   430 => x"80f58408",
   431 => x"548c1453",
   432 => x"80f4d808",
   433 => x"528a5187",
   434 => x"d33f8415",
   435 => x"08ad3886",
   436 => x"0b8c160c",
   437 => x"88155288",
   438 => x"16085186",
   439 => x"df3f80f5",
   440 => x"84087008",
   441 => x"760c548c",
   442 => x"15705454",
   443 => x"8a527308",
   444 => x"5187a93f",
   445 => x"73880c87",
   446 => x"3d0d0475",
   447 => x"0854b053",
   448 => x"73527551",
   449 => x"8fb33f73",
   450 => x"880c873d",
   451 => x"0d04f33d",
   452 => x"0d80f3f0",
   453 => x"0b80f4a4",
   454 => x"0c80f4a8",
   455 => x"0b80f584",
   456 => x"0c80f3f0",
   457 => x"0b80f4a8",
   458 => x"0c800b80",
   459 => x"f4a80b84",
   460 => x"050c820b",
   461 => x"80f4a80b",
   462 => x"88050ca8",
   463 => x"0b80f4a8",
   464 => x"0b8c050c",
   465 => x"9f53a08c",
   466 => x"5280f4b8",
   467 => x"518eea3f",
   468 => x"9f53a0ac",
   469 => x"5280f6d4",
   470 => x"518ede3f",
   471 => x"8a0bb2bc",
   472 => x"0ca38c51",
   473 => x"f9fd3fa0",
   474 => x"cc51f9f7",
   475 => x"3fa38c51",
   476 => x"f9f13fa4",
   477 => x"bc08802e",
   478 => x"83e638a0",
   479 => x"fc51f9e3",
   480 => x"3fa38c51",
   481 => x"f9dd3fa4",
   482 => x"b80852a1",
   483 => x"a851f9d3",
   484 => x"3fc80870",
   485 => x"a5dc0c56",
   486 => x"8158800b",
   487 => x"a4b80825",
   488 => x"82c4388c",
   489 => x"3d5b80c1",
   490 => x"0b80f4dc",
   491 => x"34810b80",
   492 => x"f6f40c80",
   493 => x"c20b80f4",
   494 => x"e034825c",
   495 => x"835a9f53",
   496 => x"a1d85280",
   497 => x"f4e4518d",
   498 => x"f03f815d",
   499 => x"800b80f4",
   500 => x"e45380f6",
   501 => x"d4525586",
   502 => x"e73f8808",
   503 => x"752e0981",
   504 => x"06833881",
   505 => x"557480f6",
   506 => x"f40c7b70",
   507 => x"57557483",
   508 => x"25a03874",
   509 => x"101015fd",
   510 => x"055e8f3d",
   511 => x"fc055383",
   512 => x"52755185",
   513 => x"973f811c",
   514 => x"705d7057",
   515 => x"55837524",
   516 => x"e2387d54",
   517 => x"7453a5e0",
   518 => x"5280f58c",
   519 => x"51858d3f",
   520 => x"80f58408",
   521 => x"70085757",
   522 => x"b0537652",
   523 => x"75518d89",
   524 => x"3f850b8c",
   525 => x"180c850b",
   526 => x"8c170c76",
   527 => x"08760c80",
   528 => x"f5840855",
   529 => x"74802e8a",
   530 => x"38740876",
   531 => x"0c80f584",
   532 => x"08558c15",
   533 => x"5380f4d8",
   534 => x"08528a51",
   535 => x"84be3f84",
   536 => x"1608839e",
   537 => x"38860b8c",
   538 => x"170c8816",
   539 => x"52881708",
   540 => x"5183c93f",
   541 => x"80f58408",
   542 => x"7008770c",
   543 => x"578c1670",
   544 => x"54558a52",
   545 => x"74085184",
   546 => x"933f80c1",
   547 => x"0b80f4e0",
   548 => x"33565675",
   549 => x"7526a238",
   550 => x"80c35275",
   551 => x"5184f73f",
   552 => x"88087d2e",
   553 => x"82af3881",
   554 => x"167081ff",
   555 => x"0680f4e0",
   556 => x"33525755",
   557 => x"747627e0",
   558 => x"387d7a7d",
   559 => x"2935705d",
   560 => x"8a0580f4",
   561 => x"dc3380f4",
   562 => x"d8085957",
   563 => x"557580c1",
   564 => x"2e82c738",
   565 => x"78f73881",
   566 => x"1858a4b8",
   567 => x"087825fd",
   568 => x"c538a5dc",
   569 => x"0856c808",
   570 => x"7080f4a0",
   571 => x"0c707731",
   572 => x"70a5d80c",
   573 => x"53a1f852",
   574 => x"5bf6e83f",
   575 => x"a5d80856",
   576 => x"80f77625",
   577 => x"80e038a4",
   578 => x"b8087077",
   579 => x"87e82935",
   580 => x"a5d00c76",
   581 => x"7187e829",
   582 => x"35a5d40c",
   583 => x"767184b9",
   584 => x"293580f5",
   585 => x"880c5aa2",
   586 => x"8851f6b7",
   587 => x"3fa5d008",
   588 => x"52a2b851",
   589 => x"f6ad3fa2",
   590 => x"c051f6a7",
   591 => x"3fa5d408",
   592 => x"52a2b851",
   593 => x"f69d3f80",
   594 => x"f5880852",
   595 => x"a2f051f6",
   596 => x"923fa38c",
   597 => x"51f68c3f",
   598 => x"800b880c",
   599 => x"8f3d0d04",
   600 => x"a39051fc",
   601 => x"9939a3c0",
   602 => x"51f5f83f",
   603 => x"a3f851f5",
   604 => x"f23fa38c",
   605 => x"51f5ec3f",
   606 => x"a5d808a4",
   607 => x"b8087072",
   608 => x"87e82935",
   609 => x"a5d00c71",
   610 => x"7187e829",
   611 => x"35a5d40c",
   612 => x"717184b9",
   613 => x"293580f5",
   614 => x"880c5b56",
   615 => x"a28851f5",
   616 => x"c23fa5d0",
   617 => x"0852a2b8",
   618 => x"51f5b83f",
   619 => x"a2c051f5",
   620 => x"b23fa5d4",
   621 => x"0852a2b8",
   622 => x"51f5a83f",
   623 => x"80f58808",
   624 => x"52a2f051",
   625 => x"f59d3fa3",
   626 => x"8c51f597",
   627 => x"3f800b88",
   628 => x"0c8f3d0d",
   629 => x"048f3df8",
   630 => x"05528051",
   631 => x"80de3f9f",
   632 => x"53a49852",
   633 => x"80f4e451",
   634 => x"89cf3f77",
   635 => x"7880f4d8",
   636 => x"0c811770",
   637 => x"81ff0680",
   638 => x"f4e03352",
   639 => x"58565afd",
   640 => x"b3397608",
   641 => x"56b05375",
   642 => x"52765189",
   643 => x"ac3f80c1",
   644 => x"0b80f4e0",
   645 => x"335656fc",
   646 => x"fa39ff15",
   647 => x"7078317c",
   648 => x"0c598059",
   649 => x"fdb139ff",
   650 => x"3d0d7382",
   651 => x"32703070",
   652 => x"72078025",
   653 => x"880c5252",
   654 => x"833d0d04",
   655 => x"fe3d0d74",
   656 => x"76715354",
   657 => x"5271822e",
   658 => x"83388351",
   659 => x"71812e9a",
   660 => x"38817226",
   661 => x"9f387182",
   662 => x"2eb83871",
   663 => x"842ea938",
   664 => x"70730c70",
   665 => x"880c843d",
   666 => x"0d0480e4",
   667 => x"0b80f4d8",
   668 => x"08258b38",
   669 => x"80730c70",
   670 => x"880c843d",
   671 => x"0d048373",
   672 => x"0c70880c",
   673 => x"843d0d04",
   674 => x"82730c70",
   675 => x"880c843d",
   676 => x"0d048173",
   677 => x"0c70880c",
   678 => x"843d0d04",
   679 => x"803d0d74",
   680 => x"74148205",
   681 => x"710c880c",
   682 => x"823d0d04",
   683 => x"f73d0d7b",
   684 => x"7d7f6185",
   685 => x"1270822b",
   686 => x"75117074",
   687 => x"71708405",
   688 => x"530c5a5a",
   689 => x"5d5b760c",
   690 => x"7980f818",
   691 => x"0c798612",
   692 => x"5257585a",
   693 => x"5a767624",
   694 => x"993876b3",
   695 => x"29822b79",
   696 => x"11515376",
   697 => x"73708405",
   698 => x"550c8114",
   699 => x"54757425",
   700 => x"f2387681",
   701 => x"cc2919fc",
   702 => x"11088105",
   703 => x"fc120c7a",
   704 => x"1970089f",
   705 => x"a0130c58",
   706 => x"56850b80",
   707 => x"f4d80c75",
   708 => x"880c8b3d",
   709 => x"0d04fe3d",
   710 => x"0d029305",
   711 => x"33518002",
   712 => x"84059705",
   713 => x"33545270",
   714 => x"732e8838",
   715 => x"71880c84",
   716 => x"3d0d0470",
   717 => x"80f4dc34",
   718 => x"810b880c",
   719 => x"843d0d04",
   720 => x"f83d0d7a",
   721 => x"7c595682",
   722 => x"0b831955",
   723 => x"55741670",
   724 => x"3375335b",
   725 => x"51537279",
   726 => x"2e80c638",
   727 => x"80c10b81",
   728 => x"16811656",
   729 => x"56578275",
   730 => x"25e338ff",
   731 => x"a9177081",
   732 => x"ff065559",
   733 => x"73822683",
   734 => x"38875581",
   735 => x"537680d2",
   736 => x"2e983877",
   737 => x"52755187",
   738 => x"c93f8053",
   739 => x"72880825",
   740 => x"89388715",
   741 => x"80f4d80c",
   742 => x"81537288",
   743 => x"0c8a3d0d",
   744 => x"047280f4",
   745 => x"dc348275",
   746 => x"25ffa238",
   747 => x"ffbd39ff",
   748 => x"3d0d7352",
   749 => x"c0087088",
   750 => x"2a708106",
   751 => x"51515170",
   752 => x"802ef138",
   753 => x"71c00c71",
   754 => x"880c833d",
   755 => x"0d04fb3d",
   756 => x"0d775675",
   757 => x"70840557",
   758 => x"08538054",
   759 => x"72982a73",
   760 => x"882b5452",
   761 => x"71802ea2",
   762 => x"38c00870",
   763 => x"882a7081",
   764 => x"06515151",
   765 => x"70802ef1",
   766 => x"3871c00c",
   767 => x"81158115",
   768 => x"55558374",
   769 => x"25d63871",
   770 => x"ca387488",
   771 => x"0c873d0d",
   772 => x"04940802",
   773 => x"940cfd3d",
   774 => x"0d805394",
   775 => x"088c0508",
   776 => x"52940888",
   777 => x"05085182",
   778 => x"de3f8808",
   779 => x"70880c54",
   780 => x"853d0d94",
   781 => x"0c049408",
   782 => x"02940cfd",
   783 => x"3d0d8153",
   784 => x"94088c05",
   785 => x"08529408",
   786 => x"88050851",
   787 => x"82b93f88",
   788 => x"0870880c",
   789 => x"54853d0d",
   790 => x"940c0494",
   791 => x"0802940c",
   792 => x"f93d0d80",
   793 => x"0b9408fc",
   794 => x"050c9408",
   795 => x"88050880",
   796 => x"25ab3894",
   797 => x"08880508",
   798 => x"30940888",
   799 => x"050c800b",
   800 => x"9408f405",
   801 => x"0c9408fc",
   802 => x"05088838",
   803 => x"810b9408",
   804 => x"f4050c94",
   805 => x"08f40508",
   806 => x"9408fc05",
   807 => x"0c94088c",
   808 => x"05088025",
   809 => x"ab389408",
   810 => x"8c050830",
   811 => x"94088c05",
   812 => x"0c800b94",
   813 => x"08f0050c",
   814 => x"9408fc05",
   815 => x"08883881",
   816 => x"0b9408f0",
   817 => x"050c9408",
   818 => x"f0050894",
   819 => x"08fc050c",
   820 => x"80539408",
   821 => x"8c050852",
   822 => x"94088805",
   823 => x"085181a7",
   824 => x"3f880870",
   825 => x"9408f805",
   826 => x"0c549408",
   827 => x"fc050880",
   828 => x"2e8c3894",
   829 => x"08f80508",
   830 => x"309408f8",
   831 => x"050c9408",
   832 => x"f8050870",
   833 => x"880c5489",
   834 => x"3d0d940c",
   835 => x"04940802",
   836 => x"940cfb3d",
   837 => x"0d800b94",
   838 => x"08fc050c",
   839 => x"94088805",
   840 => x"08802593",
   841 => x"38940888",
   842 => x"05083094",
   843 => x"0888050c",
   844 => x"810b9408",
   845 => x"fc050c94",
   846 => x"088c0508",
   847 => x"80258c38",
   848 => x"94088c05",
   849 => x"08309408",
   850 => x"8c050c81",
   851 => x"5394088c",
   852 => x"05085294",
   853 => x"08880508",
   854 => x"51ad3f88",
   855 => x"08709408",
   856 => x"f8050c54",
   857 => x"9408fc05",
   858 => x"08802e8c",
   859 => x"389408f8",
   860 => x"05083094",
   861 => x"08f8050c",
   862 => x"9408f805",
   863 => x"0870880c",
   864 => x"54873d0d",
   865 => x"940c0494",
   866 => x"0802940c",
   867 => x"fd3d0d81",
   868 => x"0b9408fc",
   869 => x"050c800b",
   870 => x"9408f805",
   871 => x"0c94088c",
   872 => x"05089408",
   873 => x"88050827",
   874 => x"ac389408",
   875 => x"fc050880",
   876 => x"2ea33880",
   877 => x"0b94088c",
   878 => x"05082499",
   879 => x"3894088c",
   880 => x"05081094",
   881 => x"088c050c",
   882 => x"9408fc05",
   883 => x"08109408",
   884 => x"fc050cc9",
   885 => x"399408fc",
   886 => x"0508802e",
   887 => x"80c93894",
   888 => x"088c0508",
   889 => x"94088805",
   890 => x"0826a138",
   891 => x"94088805",
   892 => x"0894088c",
   893 => x"05083194",
   894 => x"0888050c",
   895 => x"9408f805",
   896 => x"089408fc",
   897 => x"05080794",
   898 => x"08f8050c",
   899 => x"9408fc05",
   900 => x"08812a94",
   901 => x"08fc050c",
   902 => x"94088c05",
   903 => x"08812a94",
   904 => x"088c050c",
   905 => x"ffaf3994",
   906 => x"08900508",
   907 => x"802e8f38",
   908 => x"94088805",
   909 => x"08709408",
   910 => x"f4050c51",
   911 => x"8d399408",
   912 => x"f8050870",
   913 => x"9408f405",
   914 => x"0c519408",
   915 => x"f4050888",
   916 => x"0c853d0d",
   917 => x"940c0494",
   918 => x"0802940c",
   919 => x"ff3d0d80",
   920 => x"0b9408fc",
   921 => x"050c9408",
   922 => x"88050881",
   923 => x"06ff1170",
   924 => x"09709408",
   925 => x"8c050806",
   926 => x"9408fc05",
   927 => x"08119408",
   928 => x"fc050c94",
   929 => x"08880508",
   930 => x"812a9408",
   931 => x"88050c94",
   932 => x"088c0508",
   933 => x"1094088c",
   934 => x"050c5151",
   935 => x"51519408",
   936 => x"88050880",
   937 => x"2e8438ff",
   938 => x"bd399408",
   939 => x"fc050870",
   940 => x"880c5183",
   941 => x"3d0d940c",
   942 => x"04fc3d0d",
   943 => x"7670797b",
   944 => x"55555555",
   945 => x"8f72278c",
   946 => x"38727507",
   947 => x"83065170",
   948 => x"802ea738",
   949 => x"ff125271",
   950 => x"ff2e9838",
   951 => x"72708105",
   952 => x"54337470",
   953 => x"81055634",
   954 => x"ff125271",
   955 => x"ff2e0981",
   956 => x"06ea3874",
   957 => x"880c863d",
   958 => x"0d047451",
   959 => x"72708405",
   960 => x"54087170",
   961 => x"8405530c",
   962 => x"72708405",
   963 => x"54087170",
   964 => x"8405530c",
   965 => x"72708405",
   966 => x"54087170",
   967 => x"8405530c",
   968 => x"72708405",
   969 => x"54087170",
   970 => x"8405530c",
   971 => x"f0125271",
   972 => x"8f26c938",
   973 => x"83722795",
   974 => x"38727084",
   975 => x"05540871",
   976 => x"70840553",
   977 => x"0cfc1252",
   978 => x"718326ed",
   979 => x"387054ff",
   980 => x"8339fb3d",
   981 => x"0d777970",
   982 => x"72078306",
   983 => x"53545270",
   984 => x"93387173",
   985 => x"73085456",
   986 => x"54717308",
   987 => x"2e80c438",
   988 => x"73755452",
   989 => x"71337081",
   990 => x"ff065254",
   991 => x"70802e9d",
   992 => x"38723355",
   993 => x"70752e09",
   994 => x"81069538",
   995 => x"81128114",
   996 => x"71337081",
   997 => x"ff065456",
   998 => x"545270e5",
   999 => x"38723355",
  1000 => x"7381ff06",
  1001 => x"7581ff06",
  1002 => x"71713188",
  1003 => x"0c525287",
  1004 => x"3d0d0471",
  1005 => x"0970f7fb",
  1006 => x"fdff1406",
  1007 => x"70f88482",
  1008 => x"81800651",
  1009 => x"51517097",
  1010 => x"38841484",
  1011 => x"16710854",
  1012 => x"56547175",
  1013 => x"082edc38",
  1014 => x"73755452",
  1015 => x"ff963980",
  1016 => x"0b880c87",
  1017 => x"3d0d0400",
  1018 => x"00ffffff",
  1019 => x"ff00ffff",
  1020 => x"ffff00ff",
  1021 => x"ffffff00",
  1022 => x"30313233",
  1023 => x"34353637",
  1024 => x"38394142",
  1025 => x"43444546",
  1026 => x"00000000",
  1027 => x"44485259",
  1028 => x"53544f4e",
  1029 => x"45205052",
  1030 => x"4f475241",
  1031 => x"4d2c2053",
  1032 => x"4f4d4520",
  1033 => x"53545249",
  1034 => x"4e470000",
  1035 => x"44485259",
  1036 => x"53544f4e",
  1037 => x"45205052",
  1038 => x"4f475241",
  1039 => x"4d2c2031",
  1040 => x"27535420",
  1041 => x"53545249",
  1042 => x"4e470000",
  1043 => x"44687279",
  1044 => x"73746f6e",
  1045 => x"65204265",
  1046 => x"6e63686d",
  1047 => x"61726b2c",
  1048 => x"20566572",
  1049 => x"73696f6e",
  1050 => x"20322e31",
  1051 => x"20284c61",
  1052 => x"6e677561",
  1053 => x"67653a20",
  1054 => x"43290a00",
  1055 => x"50726f67",
  1056 => x"72616d20",
  1057 => x"636f6d70",
  1058 => x"696c6564",
  1059 => x"20776974",
  1060 => x"68202772",
  1061 => x"65676973",
  1062 => x"74657227",
  1063 => x"20617474",
  1064 => x"72696275",
  1065 => x"74650a00",
  1066 => x"45786563",
  1067 => x"7574696f",
  1068 => x"6e207374",
  1069 => x"61727473",
  1070 => x"2c202564",
  1071 => x"2072756e",
  1072 => x"73207468",
  1073 => x"726f7567",
  1074 => x"68204468",
  1075 => x"72797374",
  1076 => x"6f6e650a",
  1077 => x"00000000",
  1078 => x"44485259",
  1079 => x"53544f4e",
  1080 => x"45205052",
  1081 => x"4f475241",
  1082 => x"4d2c2032",
  1083 => x"274e4420",
  1084 => x"53545249",
  1085 => x"4e470000",
  1086 => x"55736572",
  1087 => x"2074696d",
  1088 => x"653a2025",
  1089 => x"640a0000",
  1090 => x"4d696372",
  1091 => x"6f736563",
  1092 => x"6f6e6473",
  1093 => x"20666f72",
  1094 => x"206f6e65",
  1095 => x"2072756e",
  1096 => x"20746872",
  1097 => x"6f756768",
  1098 => x"20446872",
  1099 => x"7973746f",
  1100 => x"6e653a20",
  1101 => x"00000000",
  1102 => x"2564200a",
  1103 => x"00000000",
  1104 => x"44687279",
  1105 => x"73746f6e",
  1106 => x"65732070",
  1107 => x"65722053",
  1108 => x"65636f6e",
  1109 => x"643a2020",
  1110 => x"20202020",
  1111 => x"20202020",
  1112 => x"20202020",
  1113 => x"20202020",
  1114 => x"20202020",
  1115 => x"00000000",
  1116 => x"56415820",
  1117 => x"4d495053",
  1118 => x"20726174",
  1119 => x"696e6720",
  1120 => x"2a203130",
  1121 => x"3030203d",
  1122 => x"20256420",
  1123 => x"0a000000",
  1124 => x"50726f67",
  1125 => x"72616d20",
  1126 => x"636f6d70",
  1127 => x"696c6564",
  1128 => x"20776974",
  1129 => x"686f7574",
  1130 => x"20277265",
  1131 => x"67697374",
  1132 => x"65722720",
  1133 => x"61747472",
  1134 => x"69627574",
  1135 => x"650a0000",
  1136 => x"4d656173",
  1137 => x"75726564",
  1138 => x"2074696d",
  1139 => x"6520746f",
  1140 => x"6f20736d",
  1141 => x"616c6c20",
  1142 => x"746f206f",
  1143 => x"62746169",
  1144 => x"6e206d65",
  1145 => x"616e696e",
  1146 => x"6766756c",
  1147 => x"20726573",
  1148 => x"756c7473",
  1149 => x"0a000000",
  1150 => x"506c6561",
  1151 => x"73652069",
  1152 => x"6e637265",
  1153 => x"61736520",
  1154 => x"6e756d62",
  1155 => x"6572206f",
  1156 => x"66207275",
  1157 => x"6e730a00",
  1158 => x"44485259",
  1159 => x"53544f4e",
  1160 => x"45205052",
  1161 => x"4f475241",
  1162 => x"4d2c2033",
  1163 => x"27524420",
  1164 => x"53545249",
  1165 => x"4e470000",
  1166 => x"000061a8",
  1167 => x"00000000",
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
