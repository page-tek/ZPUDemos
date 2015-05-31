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
use work.zpupkg.all;

entity SDRAMTest_ROM is
generic
	(
		maxAddrBitBRAM : integer := maxAddrBitBRAMLimit -- Specify your actual ROM size to save LEs and unnecessary block RAM usage.
	);
port (
	clk : in std_logic;
	areset : in std_logic := '0';
	from_zpu : in ZPU_ToROM;
	to_zpu : out ZPU_FromROM
);
end SDRAMTest_ROM;

architecture arch of SDRAMTest_ROM is

type ram_type is array(natural range 0 to ((2**(maxAddrBitBRAM+1))/4)-1) of std_logic_vector(wordSize-1 downto 0);

shared variable ram : ram_type :=
(
     0 => x"84808080",
     1 => x"8c0b8480",
     2 => x"8081e004",
     3 => x"00848080",
     4 => x"808c04ff",
     5 => x"0d800404",
     6 => x"40000017",
     7 => x"00000000",
     8 => x"848080ad",
     9 => x"b4088480",
    10 => x"80adb808",
    11 => x"848080ad",
    12 => x"bc088480",
    13 => x"80809808",
    14 => x"2d848080",
    15 => x"adbc0c84",
    16 => x"8080adb8",
    17 => x"0c848080",
    18 => x"adb40c04",
    19 => x"00000000",
    20 => x"00000000",
    21 => x"00000000",
    22 => x"00000000",
    23 => x"00000000",
    24 => x"71fd0608",
    25 => x"72830609",
    26 => x"81058205",
    27 => x"832b2a83",
    28 => x"ffff0652",
    29 => x"0471fc06",
    30 => x"08728306",
    31 => x"09810583",
    32 => x"05101010",
    33 => x"2a81ff06",
    34 => x"520471fd",
    35 => x"060883ff",
    36 => x"ff738306",
    37 => x"09810582",
    38 => x"05832b2b",
    39 => x"09067383",
    40 => x"ffff0673",
    41 => x"83060981",
    42 => x"05820583",
    43 => x"2b0b2b07",
    44 => x"72fc060c",
    45 => x"51510471",
    46 => x"fc060884",
    47 => x"80809cc8",
    48 => x"73830610",
    49 => x"10050806",
    50 => x"7381ff06",
    51 => x"73830609",
    52 => x"81058305",
    53 => x"1010102b",
    54 => x"0772fc06",
    55 => x"0c515104",
    56 => x"848080ad",
    57 => x"b4708480",
    58 => x"80aed427",
    59 => x"8e388071",
    60 => x"70840553",
    61 => x"0c848080",
    62 => x"81e50484",
    63 => x"8080808c",
    64 => x"51848080",
    65 => x"97a70402",
    66 => x"c0050d02",
    67 => x"80c4055b",
    68 => x"80707c70",
    69 => x"84055e08",
    70 => x"725f5f5f",
    71 => x"5a7c7084",
    72 => x"055e0857",
    73 => x"80597698",
    74 => x"2a77882b",
    75 => x"58557480",
    76 => x"2e82e738",
    77 => x"7b802e80",
    78 => x"d338805c",
    79 => x"7480e42e",
    80 => x"81d83874",
    81 => x"80f82e81",
    82 => x"d1387480",
    83 => x"e42e81dc",
    84 => x"387480e4",
    85 => x"2680f138",
    86 => x"7480e32e",
    87 => x"80c838a5",
    88 => x"51848080",
    89 => x"85db2d74",
    90 => x"51848080",
    91 => x"85db2d82",
    92 => x"1a811a5a",
    93 => x"5a837925",
    94 => x"ffac3874",
    95 => x"ff9f387e",
    96 => x"848080ad",
    97 => x"b40c0280",
    98 => x"c0050d04",
    99 => x"74a52e09",
   100 => x"81069b38",
   101 => x"810b811a",
   102 => x"5a5c8379",
   103 => x"25ff8738",
   104 => x"84808082",
   105 => x"fb047a84",
   106 => x"1c710857",
   107 => x"5c547451",
   108 => x"84808085",
   109 => x"db2d811a",
   110 => x"811a5a5a",
   111 => x"837925fe",
   112 => x"e5388480",
   113 => x"8082fb04",
   114 => x"7480f32e",
   115 => x"81d93874",
   116 => x"80f82e09",
   117 => x"8106ff87",
   118 => x"387d5380",
   119 => x"587d782e",
   120 => x"81e23887",
   121 => x"56729c2a",
   122 => x"73842b54",
   123 => x"5271802e",
   124 => x"83388158",
   125 => x"b7125471",
   126 => x"89248438",
   127 => x"b0125477",
   128 => x"80ea38ff",
   129 => x"16567580",
   130 => x"25db3881",
   131 => x"19598379",
   132 => x"25fe9338",
   133 => x"84808082",
   134 => x"fb047a84",
   135 => x"1c710840",
   136 => x"5c527480",
   137 => x"e42e0981",
   138 => x"06fea638",
   139 => x"7d538058",
   140 => x"7d782e81",
   141 => x"8f388756",
   142 => x"729c2a73",
   143 => x"842b5452",
   144 => x"71802e83",
   145 => x"388158b7",
   146 => x"12547189",
   147 => x"248438b0",
   148 => x"125477af",
   149 => x"38ff1656",
   150 => x"758025dc",
   151 => x"38811959",
   152 => x"837925fd",
   153 => x"c1388480",
   154 => x"8082fb04",
   155 => x"73518480",
   156 => x"8085db2d",
   157 => x"ff165675",
   158 => x"8025fee9",
   159 => x"38848080",
   160 => x"848b0473",
   161 => x"51848080",
   162 => x"85db2dff",
   163 => x"16567580",
   164 => x"25ffa538",
   165 => x"84808084",
   166 => x"dd047984",
   167 => x"8080adb4",
   168 => x"0c0280c0",
   169 => x"050d047a",
   170 => x"841c7108",
   171 => x"535c5384",
   172 => x"80808680",
   173 => x"2d811959",
   174 => x"837925fc",
   175 => x"e9388480",
   176 => x"8082fb04",
   177 => x"b0518480",
   178 => x"8085db2d",
   179 => x"81195983",
   180 => x"7925fcd2",
   181 => x"38848080",
   182 => x"82fb0402",
   183 => x"f8050d73",
   184 => x"52c00870",
   185 => x"882a7081",
   186 => x"06515151",
   187 => x"70802ef1",
   188 => x"3871c00c",
   189 => x"71848080",
   190 => x"adb40c02",
   191 => x"88050d04",
   192 => x"02e8050d",
   193 => x"80785755",
   194 => x"75708405",
   195 => x"57085380",
   196 => x"5472982a",
   197 => x"73882b54",
   198 => x"5271802e",
   199 => x"a238c008",
   200 => x"70882a70",
   201 => x"81065151",
   202 => x"5170802e",
   203 => x"f13871c0",
   204 => x"0c811581",
   205 => x"15555583",
   206 => x"7425d638",
   207 => x"71ca3874",
   208 => x"848080ad",
   209 => x"b40c0298",
   210 => x"050d0402",
   211 => x"f4050d74",
   212 => x"76525380",
   213 => x"71259038",
   214 => x"70527270",
   215 => x"84055408",
   216 => x"ff135351",
   217 => x"71f43802",
   218 => x"8c050d04",
   219 => x"02d4050d",
   220 => x"7c7e5c58",
   221 => x"810b8480",
   222 => x"809cd858",
   223 => x"5a835976",
   224 => x"08780c77",
   225 => x"08770856",
   226 => x"5473752e",
   227 => x"94387708",
   228 => x"53745284",
   229 => x"80809ce8",
   230 => x"51848080",
   231 => x"82872d80",
   232 => x"5a775680",
   233 => x"7b259038",
   234 => x"7a557570",
   235 => x"84055708",
   236 => x"ff165654",
   237 => x"74f43877",
   238 => x"08770856",
   239 => x"5675752e",
   240 => x"94387708",
   241 => x"53745284",
   242 => x"80809da8",
   243 => x"51848080",
   244 => x"82872d80",
   245 => x"5aff1984",
   246 => x"18585978",
   247 => x"8025ff9f",
   248 => x"38798480",
   249 => x"80adb40c",
   250 => x"02ac050d",
   251 => x"0402e405",
   252 => x"0d787a55",
   253 => x"56817608",
   254 => x"84180888",
   255 => x"19088c1a",
   256 => x"08515151",
   257 => x"545785aa",
   258 => x"d5aad576",
   259 => x"0cfad5aa",
   260 => x"d5aa0b8c",
   261 => x"170ccc76",
   262 => x"34b30b8f",
   263 => x"17347508",
   264 => x"5372fce2",
   265 => x"d5aad52e",
   266 => x"92387508",
   267 => x"52848080",
   268 => x"9de85184",
   269 => x"80808287",
   270 => x"2d80578c",
   271 => x"16085574",
   272 => x"fad5aad4",
   273 => x"b32e9338",
   274 => x"8c160852",
   275 => x"8480809e",
   276 => x"a4518480",
   277 => x"8082872d",
   278 => x"8057920b",
   279 => x"811734fd",
   280 => x"dc0b8e17",
   281 => x"23750853",
   282 => x"72fce0c9",
   283 => x"aad52e92",
   284 => x"38750852",
   285 => x"8480809e",
   286 => x"e0518480",
   287 => x"8082872d",
   288 => x"80578c16",
   289 => x"085574fa",
   290 => x"d5abfddc",
   291 => x"2e93388c",
   292 => x"16085284",
   293 => x"80809f9c",
   294 => x"51848080",
   295 => x"82872d80",
   296 => x"57755580",
   297 => x"74258e38",
   298 => x"74708405",
   299 => x"5608ff15",
   300 => x"555373f4",
   301 => x"38750854",
   302 => x"73fce0c9",
   303 => x"aad52e92",
   304 => x"38750852",
   305 => x"8480809f",
   306 => x"d8518480",
   307 => x"8082872d",
   308 => x"80578c16",
   309 => x"085372fa",
   310 => x"d5abfddc",
   311 => x"2e93388c",
   312 => x"16085284",
   313 => x"8080a094",
   314 => x"51848080",
   315 => x"82872d80",
   316 => x"578f0b82",
   317 => x"1734f00b",
   318 => x"8d173475",
   319 => x"337081ff",
   320 => x"06565474",
   321 => x"81cc2e97",
   322 => x"38753370",
   323 => x"81ff0653",
   324 => x"57848080",
   325 => x"a0d05184",
   326 => x"80808287",
   327 => x"2d805781",
   328 => x"16337081",
   329 => x"ff065455",
   330 => x"72922e98",
   331 => x"38811633",
   332 => x"7081ff06",
   333 => x"53548480",
   334 => x"80a0f851",
   335 => x"84808082",
   336 => x"872d8057",
   337 => x"82163370",
   338 => x"81ff0654",
   339 => x"55728f2e",
   340 => x"98388216",
   341 => x"337081ff",
   342 => x"06535784",
   343 => x"8080a1a0",
   344 => x"51848080",
   345 => x"82872d80",
   346 => x"57831633",
   347 => x"7081ff06",
   348 => x"55537380",
   349 => x"d52e9838",
   350 => x"83163370",
   351 => x"81ff0653",
   352 => x"55848080",
   353 => x"a1c85184",
   354 => x"80808287",
   355 => x"2d80578c",
   356 => x"16337081",
   357 => x"ff065553",
   358 => x"7381aa2e",
   359 => x"98388c16",
   360 => x"337081ff",
   361 => x"06535784",
   362 => x"8080a1f0",
   363 => x"51848080",
   364 => x"82872d80",
   365 => x"578d1633",
   366 => x"7081ff06",
   367 => x"56547481",
   368 => x"f02e9838",
   369 => x"8d163370",
   370 => x"81ff0653",
   371 => x"53848080",
   372 => x"a29c5184",
   373 => x"80808287",
   374 => x"2d80578e",
   375 => x"16337081",
   376 => x"ff065654",
   377 => x"7481fe2e",
   378 => x"98388e16",
   379 => x"337081ff",
   380 => x"06535784",
   381 => x"8080a2c8",
   382 => x"51848080",
   383 => x"82872d80",
   384 => x"578f1633",
   385 => x"7081ff06",
   386 => x"54557281",
   387 => x"dc2e9838",
   388 => x"8f163370",
   389 => x"81ff0653",
   390 => x"54848080",
   391 => x"a2f45184",
   392 => x"80808287",
   393 => x"2d805775",
   394 => x"227083ff",
   395 => x"ff065455",
   396 => x"72839892",
   397 => x"2e983875",
   398 => x"227083ff",
   399 => x"ff065357",
   400 => x"848080a3",
   401 => x"a0518480",
   402 => x"8082872d",
   403 => x"80578e16",
   404 => x"227083ff",
   405 => x"ff065553",
   406 => x"7383fddc",
   407 => x"2e99388e",
   408 => x"16227083",
   409 => x"ffff0653",
   410 => x"55848080",
   411 => x"a3c85184",
   412 => x"80808287",
   413 => x"2d805776",
   414 => x"848080ad",
   415 => x"b40c029c",
   416 => x"050d0402",
   417 => x"e8050d77",
   418 => x"79555680",
   419 => x"c4c4b376",
   420 => x"0c84a2d5",
   421 => x"ccf70b84",
   422 => x"170cf8c4",
   423 => x"e6d5bb0b",
   424 => x"88170cfc",
   425 => x"e6f7ddff",
   426 => x"0b8c170c",
   427 => x"85aad6d5",
   428 => x"aa0b9017",
   429 => x"0c821608",
   430 => x"53728291",
   431 => x"cd88d52e",
   432 => x"8f387252",
   433 => x"848080a3",
   434 => x"f0518480",
   435 => x"8082872d",
   436 => x"86160853",
   437 => x"7286b3de",
   438 => x"91992e8f",
   439 => x"38725284",
   440 => x"8080a4ac",
   441 => x"51848080",
   442 => x"82872d8a",
   443 => x"16085372",
   444 => x"fad5ef99",
   445 => x"dd2e8f38",
   446 => x"72528480",
   447 => x"80a4e851",
   448 => x"84808082",
   449 => x"872d8e16",
   450 => x"085372fe",
   451 => x"f7fdaad5",
   452 => x"2e8f3872",
   453 => x"52848080",
   454 => x"a5a45184",
   455 => x"80808287",
   456 => x"2d755580",
   457 => x"74258e38",
   458 => x"74708405",
   459 => x"5608ff15",
   460 => x"555373f4",
   461 => x"38821608",
   462 => x"53728291",
   463 => x"cd88d52e",
   464 => x"8f387252",
   465 => x"848080a5",
   466 => x"e0518480",
   467 => x"8082872d",
   468 => x"86160853",
   469 => x"7286b3de",
   470 => x"91992e8f",
   471 => x"38725284",
   472 => x"8080a69c",
   473 => x"51848080",
   474 => x"82872d8a",
   475 => x"16085372",
   476 => x"fad5ef99",
   477 => x"dd2e8f38",
   478 => x"72528480",
   479 => x"80a6d851",
   480 => x"84808082",
   481 => x"872d8e16",
   482 => x"085372fe",
   483 => x"f7fdaad5",
   484 => x"2e8f3872",
   485 => x"52848080",
   486 => x"a7945184",
   487 => x"80808287",
   488 => x"2d728480",
   489 => x"80adb40c",
   490 => x"0298050d",
   491 => x"0402cc05",
   492 => x"0d7e5a81",
   493 => x"5b800b84",
   494 => x"8080a7d0",
   495 => x"52598480",
   496 => x"8082872d",
   497 => x"80e1b357",
   498 => x"80fe5dae",
   499 => x"51848080",
   500 => x"85db2d76",
   501 => x"5c8fffff",
   502 => x"5876bfff",
   503 => x"ff067010",
   504 => x"101b5675",
   505 => x"0c761070",
   506 => x"962a8106",
   507 => x"56577480",
   508 => x"2e853876",
   509 => x"81075776",
   510 => x"952a8106",
   511 => x"5574802e",
   512 => x"85387681",
   513 => x"3257ff18",
   514 => x"58778025",
   515 => x"cc387b57",
   516 => x"8fffff58",
   517 => x"76bfffff",
   518 => x"06701010",
   519 => x"1b700857",
   520 => x"5d567476",
   521 => x"2e818b38",
   522 => x"80795384",
   523 => x"8080a7e0",
   524 => x"525b8480",
   525 => x"8082872d",
   526 => x"74547553",
   527 => x"75528480",
   528 => x"80a7f451",
   529 => x"84808082",
   530 => x"872d7a59",
   531 => x"76107096",
   532 => x"2a810656",
   533 => x"5774802e",
   534 => x"85387681",
   535 => x"07577695",
   536 => x"2a81065c",
   537 => x"7b802e85",
   538 => x"38768132",
   539 => x"57ff1858",
   540 => x"778025ff",
   541 => x"9f387610",
   542 => x"70962a81",
   543 => x"06595777",
   544 => x"802e8538",
   545 => x"76810757",
   546 => x"76952a81",
   547 => x"065c7b80",
   548 => x"2e853876",
   549 => x"813257ff",
   550 => x"1d5d7cfe",
   551 => x"ae388a51",
   552 => x"84808085",
   553 => x"db2d7a84",
   554 => x"8080adb4",
   555 => x"0c02b405",
   556 => x"0d048119",
   557 => x"59848080",
   558 => x"90cc0402",
   559 => x"c8050d7f",
   560 => x"5d815b80",
   561 => x"61922bff",
   562 => x"055b5c80",
   563 => x"e1b30b84",
   564 => x"8080a89c",
   565 => x"52578480",
   566 => x"8082872d",
   567 => x"7b7a2781",
   568 => x"9e387c7a",
   569 => x"5a587678",
   570 => x"0c761070",
   571 => x"962a7081",
   572 => x"06515757",
   573 => x"75802e85",
   574 => x"38768107",
   575 => x"5776952a",
   576 => x"70810651",
   577 => x"5675802e",
   578 => x"85387681",
   579 => x"3257ff19",
   580 => x"84195959",
   581 => x"78d03880",
   582 => x"e1b35780",
   583 => x"7a2780df",
   584 => x"387c5877",
   585 => x"08567577",
   586 => x"2e80e838",
   587 => x"807c5384",
   588 => x"8080a7e0",
   589 => x"525b8480",
   590 => x"8082872d",
   591 => x"7d557554",
   592 => x"76537852",
   593 => x"848080a8",
   594 => x"b0518480",
   595 => x"8082872d",
   596 => x"7a5c7610",
   597 => x"70962a81",
   598 => x"065e577c",
   599 => x"802e8538",
   600 => x"76810757",
   601 => x"76952a81",
   602 => x"065d7c80",
   603 => x"2e853876",
   604 => x"81325781",
   605 => x"19841959",
   606 => x"59797926",
   607 => x"ffa5388a",
   608 => x"51848080",
   609 => x"85db2d7a",
   610 => x"848080ad",
   611 => x"b40c02b8",
   612 => x"050d0481",
   613 => x"1c5c8480",
   614 => x"8092d204",
   615 => x"02cc050d",
   616 => x"7e605e58",
   617 => x"815a805b",
   618 => x"80c07a58",
   619 => x"5c85ada9",
   620 => x"89bb780c",
   621 => x"79598156",
   622 => x"97557676",
   623 => x"07822b78",
   624 => x"11515485",
   625 => x"ada989bb",
   626 => x"740c7510",
   627 => x"ff165656",
   628 => x"748025e6",
   629 => x"38761081",
   630 => x"1a5a5798",
   631 => x"7925d738",
   632 => x"7756807d",
   633 => x"2590387c",
   634 => x"55757084",
   635 => x"055708ff",
   636 => x"16565474",
   637 => x"f4388157",
   638 => x"ff8787a5",
   639 => x"c3780c97",
   640 => x"5976822b",
   641 => x"78117008",
   642 => x"5f56567c",
   643 => x"ff8787a5",
   644 => x"c32e80cc",
   645 => x"38740854",
   646 => x"7385ada9",
   647 => x"89bb2e94",
   648 => x"38807508",
   649 => x"54765384",
   650 => x"8080a8e4",
   651 => x"525a8480",
   652 => x"8082872d",
   653 => x"7610ff1a",
   654 => x"5a577880",
   655 => x"25c3387a",
   656 => x"822b5675",
   657 => x"b1387b52",
   658 => x"848080a9",
   659 => x"84518480",
   660 => x"8082872d",
   661 => x"7b848080",
   662 => x"adb40c02",
   663 => x"b4050d04",
   664 => x"7a770777",
   665 => x"10ff1b5b",
   666 => x"585b7880",
   667 => x"25ff9238",
   668 => x"84808094",
   669 => x"bf047552",
   670 => x"848080a9",
   671 => x"c0518480",
   672 => x"8082872d",
   673 => x"75992a81",
   674 => x"32810670",
   675 => x"09810571",
   676 => x"07700970",
   677 => x"9f2c7d06",
   678 => x"79109fff",
   679 => x"fffc0660",
   680 => x"812a415a",
   681 => x"5d575859",
   682 => x"75da3879",
   683 => x"09810570",
   684 => x"7b079f2a",
   685 => x"55567bbf",
   686 => x"26843873",
   687 => x"9d388170",
   688 => x"53848080",
   689 => x"a984525c",
   690 => x"84808082",
   691 => x"872d7b84",
   692 => x"8080adb4",
   693 => x"0c02b405",
   694 => x"0d048480",
   695 => x"80a9d851",
   696 => x"84808082",
   697 => x"872d7b52",
   698 => x"848080a9",
   699 => x"84518480",
   700 => x"8082872d",
   701 => x"7b848080",
   702 => x"adb40c02",
   703 => x"b4050d04",
   704 => x"02f0050d",
   705 => x"75548189",
   706 => x"88e6c474",
   707 => x"0c85ab99",
   708 => x"ef880b84",
   709 => x"150cf9cd",
   710 => x"aaf7cc0b",
   711 => x"88150cfd",
   712 => x"efbbfe80",
   713 => x"0b8c150c",
   714 => x"73085372",
   715 => x"818988e6",
   716 => x"c42e9038",
   717 => x"73085284",
   718 => x"8080aaa4",
   719 => x"51848080",
   720 => x"82872d84",
   721 => x"14085372",
   722 => x"85ab99ef",
   723 => x"882e9138",
   724 => x"84140852",
   725 => x"848080aa",
   726 => x"e0518480",
   727 => x"8082872d",
   728 => x"88140853",
   729 => x"72f9cdaa",
   730 => x"f7cc2e91",
   731 => x"38881408",
   732 => x"52848080",
   733 => x"ab9c5184",
   734 => x"80808287",
   735 => x"2d8c1408",
   736 => x"5372fdef",
   737 => x"bbfe802e",
   738 => x"91388c14",
   739 => x"08528480",
   740 => x"80abd851",
   741 => x"84808082",
   742 => x"872d810b",
   743 => x"848080ad",
   744 => x"b40c0290",
   745 => x"050d0402",
   746 => x"cc050d81",
   747 => x"8988e6c4",
   748 => x"0b800c85",
   749 => x"ab99ef88",
   750 => x"0b840cf9",
   751 => x"cdaaf7cc",
   752 => x"0b880cfd",
   753 => x"efbbfe80",
   754 => x"0b8c0c80",
   755 => x"08567581",
   756 => x"8988e6c4",
   757 => x"2e903880",
   758 => x"08528480",
   759 => x"80aaa451",
   760 => x"84808082",
   761 => x"872d8408",
   762 => x"577685ab",
   763 => x"99ef882e",
   764 => x"90388408",
   765 => x"52848080",
   766 => x"aae05184",
   767 => x"80808287",
   768 => x"2d880858",
   769 => x"77f9cdaa",
   770 => x"f7cc2e90",
   771 => x"38880852",
   772 => x"848080ab",
   773 => x"9c518480",
   774 => x"8082872d",
   775 => x"8c085978",
   776 => x"fdefbbfe",
   777 => x"802e9038",
   778 => x"8c085284",
   779 => x"8080abd8",
   780 => x"51848080",
   781 => x"82872d84",
   782 => x"8080ac94",
   783 => x"51848080",
   784 => x"82872d81",
   785 => x"0b848080",
   786 => x"9cd85a5a",
   787 => x"835b7808",
   788 => x"800c8008",
   789 => x"7908585d",
   790 => x"7c772e94",
   791 => x"38800853",
   792 => x"76528480",
   793 => x"809ce851",
   794 => x"84808082",
   795 => x"872d805a",
   796 => x"80705957",
   797 => x"77708405",
   798 => x"59088118",
   799 => x"5856a080",
   800 => x"7724f138",
   801 => x"80087908",
   802 => x"58567577",
   803 => x"2e943880",
   804 => x"08537652",
   805 => x"8480809d",
   806 => x"a8518480",
   807 => x"8082872d",
   808 => x"805aff1b",
   809 => x"841a5a5b",
   810 => x"7a8025ff",
   811 => x"a1387980",
   812 => x"2e8d3884",
   813 => x"8080acac",
   814 => x"51848080",
   815 => x"82872da0",
   816 => x"80528051",
   817 => x"84808087",
   818 => x"ed2d8480",
   819 => x"80adb408",
   820 => x"802e8d38",
   821 => x"848080ac",
   822 => x"d0518480",
   823 => x"8082872d",
   824 => x"a0805280",
   825 => x"51848080",
   826 => x"939c2d84",
   827 => x"8080adb4",
   828 => x"085d8480",
   829 => x"80adb408",
   830 => x"802e8d38",
   831 => x"848080ac",
   832 => x"ec518480",
   833 => x"8082872d",
   834 => x"815a807d",
   835 => x"90808029",
   836 => x"ff055a5b",
   837 => x"80e1b30b",
   838 => x"848080a8",
   839 => x"9c525784",
   840 => x"80808287",
   841 => x"2d7a587a",
   842 => x"792781a2",
   843 => x"3877822b",
   844 => x"77710c56",
   845 => x"76107096",
   846 => x"2a708106",
   847 => x"51575775",
   848 => x"802e8538",
   849 => x"76810757",
   850 => x"76952a70",
   851 => x"81065156",
   852 => x"75802e85",
   853 => x"38768132",
   854 => x"57811858",
   855 => x"787826cd",
   856 => x"3880e1b3",
   857 => x"57805877",
   858 => x"792780e2",
   859 => x"3877822b",
   860 => x"70085156",
   861 => x"75772e81",
   862 => x"c538807b",
   863 => x"53848080",
   864 => x"a7e0525a",
   865 => x"84808082",
   866 => x"872d7b55",
   867 => x"75547653",
   868 => x"77528480",
   869 => x"80a8b051",
   870 => x"84808082",
   871 => x"872d795b",
   872 => x"76107096",
   873 => x"2a708106",
   874 => x"51575775",
   875 => x"802e8538",
   876 => x"76810757",
   877 => x"76952a70",
   878 => x"81065156",
   879 => x"75802e85",
   880 => x"38768132",
   881 => x"57811858",
   882 => x"787826ff",
   883 => x"a0388a51",
   884 => x"84808085",
   885 => x"db2d7980",
   886 => x"2e8d3884",
   887 => x"8080ad84",
   888 => x"51848080",
   889 => x"82872d7c",
   890 => x"52805184",
   891 => x"80808fad",
   892 => x"2d848080",
   893 => x"adb40880",
   894 => x"2efbb038",
   895 => x"848080ad",
   896 => x"9c518480",
   897 => x"8082872d",
   898 => x"818988e6",
   899 => x"c40b800c",
   900 => x"85ab99ef",
   901 => x"880b840c",
   902 => x"f9cdaaf7",
   903 => x"cc0b880c",
   904 => x"fdefbbfe",
   905 => x"800b8c0c",
   906 => x"80085675",
   907 => x"818988e6",
   908 => x"c42e0981",
   909 => x"06fba038",
   910 => x"84808097",
   911 => x"e604811b",
   912 => x"5b848080",
   913 => x"9ba00400",
   914 => x"00ffffff",
   915 => x"ff00ffff",
   916 => x"ffff00ff",
   917 => x"ffffff00",
   918 => x"00000000",
   919 => x"55555555",
   920 => x"aaaaaaaa",
   921 => x"ffffffff",
   922 => x"53616e69",
   923 => x"74792063",
   924 => x"6865636b",
   925 => x"20666169",
   926 => x"6c656420",
   927 => x"28626566",
   928 => x"6f726520",
   929 => x"63616368",
   930 => x"65207265",
   931 => x"66726573",
   932 => x"6829206f",
   933 => x"6e203078",
   934 => x"25642028",
   935 => x"676f7420",
   936 => x"30782564",
   937 => x"290a0000",
   938 => x"53616e69",
   939 => x"74792063",
   940 => x"6865636b",
   941 => x"20666169",
   942 => x"6c656420",
   943 => x"28616674",
   944 => x"65722063",
   945 => x"61636865",
   946 => x"20726566",
   947 => x"72657368",
   948 => x"29206f6e",
   949 => x"20307825",
   950 => x"64202867",
   951 => x"6f742030",
   952 => x"78256429",
   953 => x"0a000000",
   954 => x"42797465",
   955 => x"20636865",
   956 => x"636b2066",
   957 => x"61696c65",
   958 => x"64202862",
   959 => x"65666f72",
   960 => x"65206361",
   961 => x"63686520",
   962 => x"72656672",
   963 => x"65736829",
   964 => x"20617420",
   965 => x"30202867",
   966 => x"6f742030",
   967 => x"78256429",
   968 => x"0a000000",
   969 => x"42797465",
   970 => x"20636865",
   971 => x"636b2066",
   972 => x"61696c65",
   973 => x"64202862",
   974 => x"65666f72",
   975 => x"65206361",
   976 => x"63686520",
   977 => x"72656672",
   978 => x"65736829",
   979 => x"20617420",
   980 => x"33202867",
   981 => x"6f742030",
   982 => x"78256429",
   983 => x"0a000000",
   984 => x"42797465",
   985 => x"20636865",
   986 => x"636b2032",
   987 => x"20666169",
   988 => x"6c656420",
   989 => x"28626566",
   990 => x"6f726520",
   991 => x"63616368",
   992 => x"65207265",
   993 => x"66726573",
   994 => x"68292061",
   995 => x"74203020",
   996 => x"28676f74",
   997 => x"20307825",
   998 => x"64290a00",
   999 => x"42797465",
  1000 => x"20636865",
  1001 => x"636b2032",
  1002 => x"20666169",
  1003 => x"6c656420",
  1004 => x"28626566",
  1005 => x"6f726520",
  1006 => x"63616368",
  1007 => x"65207265",
  1008 => x"66726573",
  1009 => x"68292061",
  1010 => x"74203320",
  1011 => x"28676f74",
  1012 => x"20307825",
  1013 => x"64290a00",
  1014 => x"42797465",
  1015 => x"20636865",
  1016 => x"636b2066",
  1017 => x"61696c65",
  1018 => x"64202861",
  1019 => x"66746572",
  1020 => x"20636163",
  1021 => x"68652072",
  1022 => x"65667265",
  1023 => x"73682920",
  1024 => x"61742030",
  1025 => x"2028676f",
  1026 => x"74203078",
  1027 => x"2564290a",
  1028 => x"00000000",
  1029 => x"42797465",
  1030 => x"20636865",
  1031 => x"636b2066",
  1032 => x"61696c65",
  1033 => x"64202861",
  1034 => x"66746572",
  1035 => x"20636163",
  1036 => x"68652072",
  1037 => x"65667265",
  1038 => x"73682920",
  1039 => x"61742033",
  1040 => x"2028676f",
  1041 => x"74203078",
  1042 => x"2564290a",
  1043 => x"00000000",
  1044 => x"42797465",
  1045 => x"20726561",
  1046 => x"64206368",
  1047 => x"65636b20",
  1048 => x"6661696c",
  1049 => x"65642061",
  1050 => x"74203020",
  1051 => x"28676f74",
  1052 => x"20307825",
  1053 => x"64290a00",
  1054 => x"42797465",
  1055 => x"20726561",
  1056 => x"64206368",
  1057 => x"65636b20",
  1058 => x"6661696c",
  1059 => x"65642061",
  1060 => x"74203120",
  1061 => x"28676f74",
  1062 => x"20307825",
  1063 => x"64290a00",
  1064 => x"42797465",
  1065 => x"20726561",
  1066 => x"64206368",
  1067 => x"65636b20",
  1068 => x"6661696c",
  1069 => x"65642061",
  1070 => x"74203220",
  1071 => x"28676f74",
  1072 => x"20307825",
  1073 => x"64290a00",
  1074 => x"42797465",
  1075 => x"20726561",
  1076 => x"64206368",
  1077 => x"65636b20",
  1078 => x"6661696c",
  1079 => x"65642061",
  1080 => x"74203320",
  1081 => x"28676f74",
  1082 => x"20307825",
  1083 => x"64290a00",
  1084 => x"42797465",
  1085 => x"20726561",
  1086 => x"64206368",
  1087 => x"65636b20",
  1088 => x"6661696c",
  1089 => x"65642061",
  1090 => x"74203132",
  1091 => x"2028676f",
  1092 => x"74203078",
  1093 => x"2564290a",
  1094 => x"00000000",
  1095 => x"42797465",
  1096 => x"20726561",
  1097 => x"64206368",
  1098 => x"65636b20",
  1099 => x"6661696c",
  1100 => x"65642061",
  1101 => x"74203133",
  1102 => x"2028676f",
  1103 => x"74203078",
  1104 => x"2564290a",
  1105 => x"00000000",
  1106 => x"42797465",
  1107 => x"20726561",
  1108 => x"64206368",
  1109 => x"65636b20",
  1110 => x"6661696c",
  1111 => x"65642061",
  1112 => x"74203134",
  1113 => x"2028676f",
  1114 => x"74203078",
  1115 => x"2564290a",
  1116 => x"00000000",
  1117 => x"42797465",
  1118 => x"20726561",
  1119 => x"64206368",
  1120 => x"65636b20",
  1121 => x"6661696c",
  1122 => x"65642061",
  1123 => x"74203135",
  1124 => x"2028676f",
  1125 => x"74203078",
  1126 => x"2564290a",
  1127 => x"00000000",
  1128 => x"576f7264",
  1129 => x"20726561",
  1130 => x"64206368",
  1131 => x"65636b20",
  1132 => x"6661696c",
  1133 => x"65642061",
  1134 => x"74203020",
  1135 => x"28676f74",
  1136 => x"20307825",
  1137 => x"64290a00",
  1138 => x"576f7264",
  1139 => x"20726561",
  1140 => x"64206368",
  1141 => x"65636b20",
  1142 => x"6661696c",
  1143 => x"65642061",
  1144 => x"74203720",
  1145 => x"28676f74",
  1146 => x"20307825",
  1147 => x"64290a00",
  1148 => x"416c6967",
  1149 => x"6e206368",
  1150 => x"65636b20",
  1151 => x"6661696c",
  1152 => x"65642028",
  1153 => x"6265666f",
  1154 => x"72652063",
  1155 => x"61636865",
  1156 => x"20726566",
  1157 => x"72657368",
  1158 => x"29206174",
  1159 => x"20322028",
  1160 => x"676f7420",
  1161 => x"30782564",
  1162 => x"290a0000",
  1163 => x"416c6967",
  1164 => x"6e206368",
  1165 => x"65636b20",
  1166 => x"6661696c",
  1167 => x"65642028",
  1168 => x"6265666f",
  1169 => x"72652063",
  1170 => x"61636865",
  1171 => x"20726566",
  1172 => x"72657368",
  1173 => x"29206174",
  1174 => x"20362028",
  1175 => x"676f7420",
  1176 => x"30782564",
  1177 => x"290a0000",
  1178 => x"416c6967",
  1179 => x"6e206368",
  1180 => x"65636b20",
  1181 => x"6661696c",
  1182 => x"65642028",
  1183 => x"6265666f",
  1184 => x"72652063",
  1185 => x"61636865",
  1186 => x"20726566",
  1187 => x"72657368",
  1188 => x"29206174",
  1189 => x"20313020",
  1190 => x"28676f74",
  1191 => x"20307825",
  1192 => x"64290a00",
  1193 => x"416c6967",
  1194 => x"6e206368",
  1195 => x"65636b20",
  1196 => x"6661696c",
  1197 => x"65642028",
  1198 => x"6265666f",
  1199 => x"72652063",
  1200 => x"61636865",
  1201 => x"20726566",
  1202 => x"72657368",
  1203 => x"29206174",
  1204 => x"20313420",
  1205 => x"28676f74",
  1206 => x"20307825",
  1207 => x"64290a00",
  1208 => x"416c6967",
  1209 => x"6e206368",
  1210 => x"65636b20",
  1211 => x"6661696c",
  1212 => x"65642028",
  1213 => x"61667465",
  1214 => x"72206361",
  1215 => x"63686520",
  1216 => x"72656672",
  1217 => x"65736829",
  1218 => x"20617420",
  1219 => x"32202867",
  1220 => x"6f742030",
  1221 => x"78256429",
  1222 => x"0a000000",
  1223 => x"416c6967",
  1224 => x"6e206368",
  1225 => x"65636b20",
  1226 => x"6661696c",
  1227 => x"65642028",
  1228 => x"61667465",
  1229 => x"72206361",
  1230 => x"63686520",
  1231 => x"72656672",
  1232 => x"65736829",
  1233 => x"20617420",
  1234 => x"36202867",
  1235 => x"6f742030",
  1236 => x"78256429",
  1237 => x"0a000000",
  1238 => x"416c6967",
  1239 => x"6e206368",
  1240 => x"65636b20",
  1241 => x"6661696c",
  1242 => x"65642028",
  1243 => x"61667465",
  1244 => x"72206361",
  1245 => x"63686520",
  1246 => x"72656672",
  1247 => x"65736829",
  1248 => x"20617420",
  1249 => x"31302028",
  1250 => x"676f7420",
  1251 => x"30782564",
  1252 => x"290a0000",
  1253 => x"416c6967",
  1254 => x"6e206368",
  1255 => x"65636b20",
  1256 => x"6661696c",
  1257 => x"65642028",
  1258 => x"61667465",
  1259 => x"72206361",
  1260 => x"63686520",
  1261 => x"72656672",
  1262 => x"65736829",
  1263 => x"20617420",
  1264 => x"31342028",
  1265 => x"676f7420",
  1266 => x"30782564",
  1267 => x"290a0000",
  1268 => x"43686563",
  1269 => x"6b696e67",
  1270 => x"206d656d",
  1271 => x"6f727900",
  1272 => x"30782564",
  1273 => x"20676f6f",
  1274 => x"64207265",
  1275 => x"6164732c",
  1276 => x"20000000",
  1277 => x"4572726f",
  1278 => x"72206174",
  1279 => x"20307825",
  1280 => x"642c2065",
  1281 => x"78706563",
  1282 => x"74656420",
  1283 => x"30782564",
  1284 => x"2c20676f",
  1285 => x"74203078",
  1286 => x"25640a00",
  1287 => x"4c696e65",
  1288 => x"6172206d",
  1289 => x"656d6f72",
  1290 => x"79206368",
  1291 => x"65636b00",
  1292 => x"4572726f",
  1293 => x"72206174",
  1294 => x"20307825",
  1295 => x"642c2065",
  1296 => x"78706563",
  1297 => x"74656420",
  1298 => x"30782564",
  1299 => x"2c20676f",
  1300 => x"74203078",
  1301 => x"2564206f",
  1302 => x"6e20726f",
  1303 => x"756e6420",
  1304 => x"25640a00",
  1305 => x"42616420",
  1306 => x"64617461",
  1307 => x"20666f75",
  1308 => x"6e642061",
  1309 => x"74203078",
  1310 => x"25642028",
  1311 => x"30782564",
  1312 => x"290a0000",
  1313 => x"53445241",
  1314 => x"4d207369",
  1315 => x"7a652028",
  1316 => x"61737375",
  1317 => x"6d696e67",
  1318 => x"206e6f20",
  1319 => x"61646472",
  1320 => x"65737320",
  1321 => x"6661756c",
  1322 => x"74732920",
  1323 => x"69732030",
  1324 => x"78256420",
  1325 => x"6d656761",
  1326 => x"62797465",
  1327 => x"730a0000",
  1328 => x"416c6961",
  1329 => x"73657320",
  1330 => x"666f756e",
  1331 => x"64206174",
  1332 => x"20307825",
  1333 => x"640a0000",
  1334 => x"28416c69",
  1335 => x"61736573",
  1336 => x"2070726f",
  1337 => x"6261626c",
  1338 => x"79207369",
  1339 => x"6d706c79",
  1340 => x"20696e64",
  1341 => x"69636174",
  1342 => x"65207468",
  1343 => x"61742052",
  1344 => x"414d0a69",
  1345 => x"7320736d",
  1346 => x"616c6c65",
  1347 => x"72207468",
  1348 => x"616e2036",
  1349 => x"34206d65",
  1350 => x"67616279",
  1351 => x"74657329",
  1352 => x"0a000000",
  1353 => x"53696d70",
  1354 => x"6c652063",
  1355 => x"6865636b",
  1356 => x"20666169",
  1357 => x"6c656420",
  1358 => x"61742030",
  1359 => x"2028676f",
  1360 => x"74202564",
  1361 => x"2c206578",
  1362 => x"70656374",
  1363 => x"65642030",
  1364 => x"78313132",
  1365 => x"32333334",
  1366 => x"3429290a",
  1367 => x"00000000",
  1368 => x"53696d70",
  1369 => x"6c652063",
  1370 => x"6865636b",
  1371 => x"20666169",
  1372 => x"6c656420",
  1373 => x"61742031",
  1374 => x"2028676f",
  1375 => x"74202564",
  1376 => x"2c206578",
  1377 => x"70656374",
  1378 => x"65642030",
  1379 => x"78353536",
  1380 => x"36373738",
  1381 => x"3829290a",
  1382 => x"00000000",
  1383 => x"53696d70",
  1384 => x"6c652063",
  1385 => x"6865636b",
  1386 => x"20666169",
  1387 => x"6c656420",
  1388 => x"61742032",
  1389 => x"2028676f",
  1390 => x"74202564",
  1391 => x"2c206578",
  1392 => x"70656374",
  1393 => x"65642030",
  1394 => x"78393961",
  1395 => x"61626263",
  1396 => x"6329290a",
  1397 => x"00000000",
  1398 => x"53696d70",
  1399 => x"6c652063",
  1400 => x"6865636b",
  1401 => x"20666169",
  1402 => x"6c656420",
  1403 => x"61742033",
  1404 => x"2028676f",
  1405 => x"74202564",
  1406 => x"2c206578",
  1407 => x"70656374",
  1408 => x"65642030",
  1409 => x"78646465",
  1410 => x"65666630",
  1411 => x"3029290a",
  1412 => x"00000000",
  1413 => x"53696d70",
  1414 => x"6c652063",
  1415 => x"6865636b",
  1416 => x"20706173",
  1417 => x"7365642e",
  1418 => x"0a000000",
  1419 => x"46697273",
  1420 => x"74207374",
  1421 => x"61676520",
  1422 => x"73616e69",
  1423 => x"74792063",
  1424 => x"6865636b",
  1425 => x"20706173",
  1426 => x"7365642e",
  1427 => x"0a000000",
  1428 => x"42797465",
  1429 => x"20286471",
  1430 => x"6d292063",
  1431 => x"6865636b",
  1432 => x"20706173",
  1433 => x"7365640a",
  1434 => x"00000000",
  1435 => x"41646472",
  1436 => x"65737320",
  1437 => x"63686563",
  1438 => x"6b207061",
  1439 => x"73736564",
  1440 => x"2e0a0000",
  1441 => x"4c696e65",
  1442 => x"61722063",
  1443 => x"6865636b",
  1444 => x"20706173",
  1445 => x"7365642e",
  1446 => x"0a0a0000",
  1447 => x"4c465352",
  1448 => x"20636865",
  1449 => x"636b2070",
  1450 => x"61737365",
  1451 => x"642e0a0a",
  1452 => x"00000000",
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
			ram(to_integer(unsigned(from_zpu.memAAddr(maxAddrBitBRAM downto 2)))) := from_zpu.memAWrite;
			to_zpu.memARead <= from_zpu.memAWrite;
		else
			to_zpu.memARead <= ram(to_integer(unsigned(from_zpu.memAAddr(maxAddrBitBRAM downto 2))));
		end if;
	end if;
end process;

process (clk)
begin
	if (clk'event and clk = '1') then
		if (from_zpu.memBWriteEnable = '1') then
			ram(to_integer(unsigned(from_zpu.memBAddr(maxAddrBitBRAM downto 2)))) := from_zpu.memBWrite;
			to_zpu.memBRead <= from_zpu.memBWrite;
		else
			to_zpu.memBRead <= ram(to_integer(unsigned(from_zpu.memBAddr(maxAddrBitBRAM downto 2))));
		end if;
	end if;
end process;


end arch;

