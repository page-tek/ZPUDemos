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

entity Dhrystone_min_ROM is
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
end Dhrystone_min_ROM;

architecture arch of Dhrystone_min_ROM is

type ram_type is array(natural range 0 to ((2**(maxAddrBitBRAM+1))/4)-1) of std_logic_vector(wordSize-1 downto 0);

shared variable ram : ram_type :=
(
     0 => x"0b0b0b88",
     1 => x"e5040000",
     2 => x"00000000",
     3 => x"00000000",
     4 => x"00000000",
     5 => x"00000000",
     6 => x"00000000",
     7 => x"00000000",
     8 => x"88088c08",
     9 => x"90080b0b",
    10 => x"0b88e108",
    11 => x"2d900c8c",
    12 => x"0c880c04",
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
   161 => x"0b0b0ba0",
   162 => x"f8738306",
   163 => x"10100508",
   164 => x"060b0b0b",
   165 => x"88a20400",
   166 => x"00000000",
   167 => x"00000000",
   168 => x"88088c08",
   169 => x"90087575",
   170 => x"0b0b0b99",
   171 => x"e92d5050",
   172 => x"88085690",
   173 => x"0c8c0c88",
   174 => x"0c510400",
   175 => x"00000000",
   176 => x"88088c08",
   177 => x"90087575",
   178 => x"0b0b0b9b",
   179 => x"9b2d5050",
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
   224 => x"04000000",
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
   278 => x"80040088",
   279 => x"da040400",
   280 => x"00000004",
   281 => x"5ea5d070",
   282 => x"80f89827",
   283 => x"8b388071",
   284 => x"70840553",
   285 => x"0c88e704",
   286 => x"88da5190",
   287 => x"c804f03d",
   288 => x"0d933d5c",
   289 => x"80707d70",
   290 => x"84055f08",
   291 => x"72404040",
   292 => x"587d7084",
   293 => x"055f0857",
   294 => x"80597698",
   295 => x"2a77882b",
   296 => x"58557480",
   297 => x"2e83ce38",
   298 => x"7c802e80",
   299 => x"c638805d",
   300 => x"7480e42e",
   301 => x"81e93874",
   302 => x"80f82e81",
   303 => x"e2387480",
   304 => x"e42e81ed",
   305 => x"387480e4",
   306 => x"2680d938",
   307 => x"7480e32e",
   308 => x"b838a551",
   309 => x"83cf3f74",
   310 => x"5183ca3f",
   311 => x"82185881",
   312 => x"19598379",
   313 => x"25ffb338",
   314 => x"74ffa638",
   315 => x"7f880c92",
   316 => x"3d0d0474",
   317 => x"a52e0981",
   318 => x"06973881",
   319 => x"0b811a5a",
   320 => x"5d837925",
   321 => x"ff9438e0",
   322 => x"397b841d",
   323 => x"7108575d",
   324 => x"56745183",
   325 => x"903f8118",
   326 => x"811a5a58",
   327 => x"837925fe",
   328 => x"f938c539",
   329 => x"7480f32e",
   330 => x"82d23874",
   331 => x"80f82e09",
   332 => x"8106ff9e",
   333 => x"387e0b0b",
   334 => x"0ba6a00b",
   335 => x"0b0b0ba5",
   336 => x"d0585c54",
   337 => x"805a797f",
   338 => x"2482d038",
   339 => x"7381b038",
   340 => x"b00b0b0b",
   341 => x"0ba5d034",
   342 => x"811656ff",
   343 => x"16567533",
   344 => x"7b708105",
   345 => x"5d34811a",
   346 => x"5a750b0b",
   347 => x"0ba5d02e",
   348 => x"098106e7",
   349 => x"38807b34",
   350 => x"790b0b0b",
   351 => x"a6a05753",
   352 => x"ff135480",
   353 => x"7325fed7",
   354 => x"38757081",
   355 => x"05573370",
   356 => x"52558291",
   357 => x"3f811874",
   358 => x"ff165654",
   359 => x"58e5397b",
   360 => x"841d7108",
   361 => x"415d5374",
   362 => x"80e42e09",
   363 => x"8106fe95",
   364 => x"387e0b0b",
   365 => x"0ba6a00b",
   366 => x"0b0b0ba5",
   367 => x"d0585c54",
   368 => x"805a797f",
   369 => x"2481ca38",
   370 => x"7380ef38",
   371 => x"b00b0b0b",
   372 => x"0ba5d034",
   373 => x"811656ff",
   374 => x"16567533",
   375 => x"7b708105",
   376 => x"5d34811a",
   377 => x"5a750b0b",
   378 => x"0ba5d02e",
   379 => x"098106e7",
   380 => x"38807b34",
   381 => x"790b0b0b",
   382 => x"a6a05753",
   383 => x"ff823990",
   384 => x"7436a188",
   385 => x"05537233",
   386 => x"76708105",
   387 => x"58349074",
   388 => x"355473eb",
   389 => x"38750b0b",
   390 => x"0ba5d02e",
   391 => x"fed738ff",
   392 => x"16567533",
   393 => x"7b708105",
   394 => x"5d34811a",
   395 => x"5a750b0b",
   396 => x"0ba5d02e",
   397 => x"febf38fe",
   398 => x"a2398a74",
   399 => x"36a18805",
   400 => x"53723376",
   401 => x"70810558",
   402 => x"348a7435",
   403 => x"5473eb38",
   404 => x"750b0b0b",
   405 => x"a5d02efe",
   406 => x"9c38ff16",
   407 => x"5675337b",
   408 => x"7081055d",
   409 => x"34811a5a",
   410 => x"750b0b0b",
   411 => x"a5d02eff",
   412 => x"8038fee3",
   413 => x"3977880c",
   414 => x"923d0d04",
   415 => x"7b841d71",
   416 => x"08705458",
   417 => x"5d54bd3f",
   418 => x"800bff11",
   419 => x"5553fdf3",
   420 => x"39ad5191",
   421 => x"3f7e3054",
   422 => x"feae39ad",
   423 => x"51873f7e",
   424 => x"3054fda8",
   425 => x"39ff3d0d",
   426 => x"7352c008",
   427 => x"70882a70",
   428 => x"81065151",
   429 => x"5170802e",
   430 => x"f13871c0",
   431 => x"0c71880c",
   432 => x"833d0d04",
   433 => x"fb3d0d80",
   434 => x"78575575",
   435 => x"70840557",
   436 => x"08538054",
   437 => x"72982a73",
   438 => x"882b5452",
   439 => x"71802ea2",
   440 => x"38c00870",
   441 => x"882a7081",
   442 => x"06515151",
   443 => x"70802ef1",
   444 => x"3871c00c",
   445 => x"81158115",
   446 => x"55558374",
   447 => x"25d63871",
   448 => x"ca387488",
   449 => x"0c873d0d",
   450 => x"04c80888",
   451 => x"0c04803d",
   452 => x"0d80c10b",
   453 => x"80f5ec34",
   454 => x"800b80f8",
   455 => x"840c7088",
   456 => x"0c823d0d",
   457 => x"04ff3d0d",
   458 => x"800b80f5",
   459 => x"ec335252",
   460 => x"7080c12e",
   461 => x"99387180",
   462 => x"f8840807",
   463 => x"80f8840c",
   464 => x"80c20b80",
   465 => x"f5f03470",
   466 => x"880c833d",
   467 => x"0d04810b",
   468 => x"80f88408",
   469 => x"0780f884",
   470 => x"0c80c20b",
   471 => x"80f5f034",
   472 => x"70880c83",
   473 => x"3d0d04fd",
   474 => x"3d0d7570",
   475 => x"088a0553",
   476 => x"5380f5ec",
   477 => x"33517080",
   478 => x"c12e8b38",
   479 => x"73f33870",
   480 => x"880c853d",
   481 => x"0d04ff12",
   482 => x"7080f5e8",
   483 => x"0831740c",
   484 => x"880c853d",
   485 => x"0d04fc3d",
   486 => x"0d80f694",
   487 => x"08557480",
   488 => x"2e8c3876",
   489 => x"7508710c",
   490 => x"80f69408",
   491 => x"56548c15",
   492 => x"5380f5e8",
   493 => x"08528a51",
   494 => x"889c3f73",
   495 => x"880c863d",
   496 => x"0d04fb3d",
   497 => x"0d777008",
   498 => x"5656b053",
   499 => x"80f69408",
   500 => x"5274518e",
   501 => x"f23f850b",
   502 => x"8c170c85",
   503 => x"0b8c160c",
   504 => x"7508750c",
   505 => x"80f69408",
   506 => x"5473802e",
   507 => x"8a387308",
   508 => x"750c80f6",
   509 => x"9408548c",
   510 => x"145380f5",
   511 => x"e808528a",
   512 => x"5187d33f",
   513 => x"841508ad",
   514 => x"38860b8c",
   515 => x"160c8815",
   516 => x"52881608",
   517 => x"5186df3f",
   518 => x"80f69408",
   519 => x"7008760c",
   520 => x"548c1570",
   521 => x"54548a52",
   522 => x"73085187",
   523 => x"a93f7388",
   524 => x"0c873d0d",
   525 => x"04750854",
   526 => x"b0537352",
   527 => x"75518e87",
   528 => x"3f73880c",
   529 => x"873d0d04",
   530 => x"f33d0d80",
   531 => x"f5800b80",
   532 => x"f5b40c80",
   533 => x"f5b80b80",
   534 => x"f6940c80",
   535 => x"f5800b80",
   536 => x"f5b80c80",
   537 => x"0b80f5b8",
   538 => x"0b84050c",
   539 => x"820b80f5",
   540 => x"b80b8805",
   541 => x"0ca80b80",
   542 => x"f5b80b8c",
   543 => x"050c9f53",
   544 => x"a19c5280",
   545 => x"f5c8518d",
   546 => x"be3f9f53",
   547 => x"a1bc5280",
   548 => x"f7e4518d",
   549 => x"b23f8a0b",
   550 => x"b3cc0ca4",
   551 => x"9c51f7de",
   552 => x"3fa1dc51",
   553 => x"f7d83fa4",
   554 => x"9c51f7d2",
   555 => x"3fa5cc08",
   556 => x"802e83e6",
   557 => x"38a28c51",
   558 => x"f7c43fa4",
   559 => x"9c51f7be",
   560 => x"3fa5c808",
   561 => x"52a2b851",
   562 => x"f7b43fc8",
   563 => x"0870a6ec",
   564 => x"0c568158",
   565 => x"800ba5c8",
   566 => x"082582c4",
   567 => x"388c3d5b",
   568 => x"80c10b80",
   569 => x"f5ec3481",
   570 => x"0b80f884",
   571 => x"0c80c20b",
   572 => x"80f5f034",
   573 => x"825c835a",
   574 => x"9f53a2e8",
   575 => x"5280f5f4",
   576 => x"518cc43f",
   577 => x"815d800b",
   578 => x"80f5f453",
   579 => x"80f7e452",
   580 => x"5586e73f",
   581 => x"8808752e",
   582 => x"09810683",
   583 => x"38815574",
   584 => x"80f8840c",
   585 => x"7b705755",
   586 => x"748325a0",
   587 => x"38741010",
   588 => x"15fd055e",
   589 => x"8f3dfc05",
   590 => x"53835275",
   591 => x"5185973f",
   592 => x"811c705d",
   593 => x"70575583",
   594 => x"7524e238",
   595 => x"7d547453",
   596 => x"a6f05280",
   597 => x"f69c5185",
   598 => x"8d3f80f6",
   599 => x"94087008",
   600 => x"5757b053",
   601 => x"76527551",
   602 => x"8bdd3f85",
   603 => x"0b8c180c",
   604 => x"850b8c17",
   605 => x"0c760876",
   606 => x"0c80f694",
   607 => x"08557480",
   608 => x"2e8a3874",
   609 => x"08760c80",
   610 => x"f6940855",
   611 => x"8c155380",
   612 => x"f5e80852",
   613 => x"8a5184be",
   614 => x"3f841608",
   615 => x"839e3886",
   616 => x"0b8c170c",
   617 => x"88165288",
   618 => x"17085183",
   619 => x"c93f80f6",
   620 => x"94087008",
   621 => x"770c578c",
   622 => x"16705455",
   623 => x"8a527408",
   624 => x"5184933f",
   625 => x"80c10b80",
   626 => x"f5f03356",
   627 => x"56757526",
   628 => x"a23880c3",
   629 => x"52755184",
   630 => x"f73f8808",
   631 => x"7d2e82af",
   632 => x"38811670",
   633 => x"81ff0680",
   634 => x"f5f03352",
   635 => x"57557476",
   636 => x"27e0387d",
   637 => x"7a7d2935",
   638 => x"705d8a05",
   639 => x"80f5ec33",
   640 => x"80f5e808",
   641 => x"59575575",
   642 => x"80c12e82",
   643 => x"c73878f7",
   644 => x"38811858",
   645 => x"a5c80878",
   646 => x"25fdc538",
   647 => x"a6ec0856",
   648 => x"c8087080",
   649 => x"f5b00c70",
   650 => x"773170a6",
   651 => x"e80c53a3",
   652 => x"88525bf4",
   653 => x"c93fa6e8",
   654 => x"085680f7",
   655 => x"762580e0",
   656 => x"38a5c808",
   657 => x"707787e8",
   658 => x"2935a6e0",
   659 => x"0c767187",
   660 => x"e82935a6",
   661 => x"e40c7671",
   662 => x"84b92935",
   663 => x"80f6980c",
   664 => x"5aa39851",
   665 => x"f4983fa6",
   666 => x"e00852a3",
   667 => x"c851f48e",
   668 => x"3fa3d051",
   669 => x"f4883fa6",
   670 => x"e40852a3",
   671 => x"c851f3fe",
   672 => x"3f80f698",
   673 => x"0852a480",
   674 => x"51f3f33f",
   675 => x"a49c51f3",
   676 => x"ed3f800b",
   677 => x"880c8f3d",
   678 => x"0d04a4a0",
   679 => x"51fc9939",
   680 => x"a4d051f3",
   681 => x"d93fa588",
   682 => x"51f3d33f",
   683 => x"a49c51f3",
   684 => x"cd3fa6e8",
   685 => x"08a5c808",
   686 => x"707287e8",
   687 => x"2935a6e0",
   688 => x"0c717187",
   689 => x"e82935a6",
   690 => x"e40c7171",
   691 => x"84b92935",
   692 => x"80f6980c",
   693 => x"5b56a398",
   694 => x"51f3a33f",
   695 => x"a6e00852",
   696 => x"a3c851f3",
   697 => x"993fa3d0",
   698 => x"51f3933f",
   699 => x"a6e40852",
   700 => x"a3c851f3",
   701 => x"893f80f6",
   702 => x"980852a4",
   703 => x"8051f2fe",
   704 => x"3fa49c51",
   705 => x"f2f83f80",
   706 => x"0b880c8f",
   707 => x"3d0d048f",
   708 => x"3df80552",
   709 => x"805180de",
   710 => x"3f9f53a5",
   711 => x"a85280f5",
   712 => x"f45188a3",
   713 => x"3f777880",
   714 => x"f5e80c81",
   715 => x"177081ff",
   716 => x"0680f5f0",
   717 => x"33525856",
   718 => x"5afdb339",
   719 => x"760856b0",
   720 => x"53755276",
   721 => x"5188803f",
   722 => x"80c10b80",
   723 => x"f5f03356",
   724 => x"56fcfa39",
   725 => x"ff157078",
   726 => x"317c0c59",
   727 => x"8059fdb1",
   728 => x"39ff3d0d",
   729 => x"73823270",
   730 => x"30707207",
   731 => x"8025880c",
   732 => x"5252833d",
   733 => x"0d04fe3d",
   734 => x"0d747671",
   735 => x"53545271",
   736 => x"822e8338",
   737 => x"83517181",
   738 => x"2e9a3881",
   739 => x"72269f38",
   740 => x"71822eb8",
   741 => x"3871842e",
   742 => x"a9387073",
   743 => x"0c70880c",
   744 => x"843d0d04",
   745 => x"80e40b80",
   746 => x"f5e80825",
   747 => x"8b388073",
   748 => x"0c70880c",
   749 => x"843d0d04",
   750 => x"83730c70",
   751 => x"880c843d",
   752 => x"0d048273",
   753 => x"0c70880c",
   754 => x"843d0d04",
   755 => x"81730c70",
   756 => x"880c843d",
   757 => x"0d04803d",
   758 => x"0d747414",
   759 => x"8205710c",
   760 => x"880c823d",
   761 => x"0d04f73d",
   762 => x"0d7b7d7f",
   763 => x"61851270",
   764 => x"822b7511",
   765 => x"70747170",
   766 => x"8405530c",
   767 => x"5a5a5d5b",
   768 => x"760c7980",
   769 => x"f8180c79",
   770 => x"86125257",
   771 => x"585a5a76",
   772 => x"76249938",
   773 => x"76b32982",
   774 => x"2b791151",
   775 => x"53767370",
   776 => x"8405550c",
   777 => x"81145475",
   778 => x"7425f238",
   779 => x"7681cc29",
   780 => x"19fc1108",
   781 => x"8105fc12",
   782 => x"0c7a1970",
   783 => x"089fa013",
   784 => x"0c585685",
   785 => x"0b80f5e8",
   786 => x"0c75880c",
   787 => x"8b3d0d04",
   788 => x"fe3d0d02",
   789 => x"93053351",
   790 => x"80028405",
   791 => x"97053354",
   792 => x"5270732e",
   793 => x"88387188",
   794 => x"0c843d0d",
   795 => x"047080f5",
   796 => x"ec34810b",
   797 => x"880c843d",
   798 => x"0d04f83d",
   799 => x"0d7a7c59",
   800 => x"56820b83",
   801 => x"19555574",
   802 => x"16703375",
   803 => x"335b5153",
   804 => x"72792e80",
   805 => x"c63880c1",
   806 => x"0b811681",
   807 => x"16565657",
   808 => x"827525e3",
   809 => x"38ffa917",
   810 => x"7081ff06",
   811 => x"55597382",
   812 => x"26833887",
   813 => x"55815376",
   814 => x"80d22e98",
   815 => x"38775275",
   816 => x"51869d3f",
   817 => x"80537288",
   818 => x"08258938",
   819 => x"871580f5",
   820 => x"e80c8153",
   821 => x"72880c8a",
   822 => x"3d0d0472",
   823 => x"80f5ec34",
   824 => x"827525ff",
   825 => x"a238ffbd",
   826 => x"39940802",
   827 => x"940cf93d",
   828 => x"0d800b94",
   829 => x"08fc050c",
   830 => x"94088805",
   831 => x"088025ab",
   832 => x"38940888",
   833 => x"05083094",
   834 => x"0888050c",
   835 => x"800b9408",
   836 => x"f4050c94",
   837 => x"08fc0508",
   838 => x"8838810b",
   839 => x"9408f405",
   840 => x"0c9408f4",
   841 => x"05089408",
   842 => x"fc050c94",
   843 => x"088c0508",
   844 => x"8025ab38",
   845 => x"94088c05",
   846 => x"08309408",
   847 => x"8c050c80",
   848 => x"0b9408f0",
   849 => x"050c9408",
   850 => x"fc050888",
   851 => x"38810b94",
   852 => x"08f0050c",
   853 => x"9408f005",
   854 => x"089408fc",
   855 => x"050c8053",
   856 => x"94088c05",
   857 => x"08529408",
   858 => x"88050851",
   859 => x"81a73f88",
   860 => x"08709408",
   861 => x"f8050c54",
   862 => x"9408fc05",
   863 => x"08802e8c",
   864 => x"389408f8",
   865 => x"05083094",
   866 => x"08f8050c",
   867 => x"9408f805",
   868 => x"0870880c",
   869 => x"54893d0d",
   870 => x"940c0494",
   871 => x"0802940c",
   872 => x"fb3d0d80",
   873 => x"0b9408fc",
   874 => x"050c9408",
   875 => x"88050880",
   876 => x"25933894",
   877 => x"08880508",
   878 => x"30940888",
   879 => x"050c810b",
   880 => x"9408fc05",
   881 => x"0c94088c",
   882 => x"05088025",
   883 => x"8c389408",
   884 => x"8c050830",
   885 => x"94088c05",
   886 => x"0c815394",
   887 => x"088c0508",
   888 => x"52940888",
   889 => x"050851ad",
   890 => x"3f880870",
   891 => x"9408f805",
   892 => x"0c549408",
   893 => x"fc050880",
   894 => x"2e8c3894",
   895 => x"08f80508",
   896 => x"309408f8",
   897 => x"050c9408",
   898 => x"f8050870",
   899 => x"880c5487",
   900 => x"3d0d940c",
   901 => x"04940802",
   902 => x"940cfd3d",
   903 => x"0d810b94",
   904 => x"08fc050c",
   905 => x"800b9408",
   906 => x"f8050c94",
   907 => x"088c0508",
   908 => x"94088805",
   909 => x"0827ac38",
   910 => x"9408fc05",
   911 => x"08802ea3",
   912 => x"38800b94",
   913 => x"088c0508",
   914 => x"24993894",
   915 => x"088c0508",
   916 => x"1094088c",
   917 => x"050c9408",
   918 => x"fc050810",
   919 => x"9408fc05",
   920 => x"0cc93994",
   921 => x"08fc0508",
   922 => x"802e80c9",
   923 => x"3894088c",
   924 => x"05089408",
   925 => x"88050826",
   926 => x"a1389408",
   927 => x"88050894",
   928 => x"088c0508",
   929 => x"31940888",
   930 => x"050c9408",
   931 => x"f8050894",
   932 => x"08fc0508",
   933 => x"079408f8",
   934 => x"050c9408",
   935 => x"fc050881",
   936 => x"2a9408fc",
   937 => x"050c9408",
   938 => x"8c050881",
   939 => x"2a94088c",
   940 => x"050cffaf",
   941 => x"39940890",
   942 => x"0508802e",
   943 => x"8f389408",
   944 => x"88050870",
   945 => x"9408f405",
   946 => x"0c518d39",
   947 => x"9408f805",
   948 => x"08709408",
   949 => x"f4050c51",
   950 => x"9408f405",
   951 => x"08880c85",
   952 => x"3d0d940c",
   953 => x"04940802",
   954 => x"940cff3d",
   955 => x"0d800b94",
   956 => x"08fc050c",
   957 => x"94088805",
   958 => x"088106ff",
   959 => x"11700970",
   960 => x"94088c05",
   961 => x"08069408",
   962 => x"fc050811",
   963 => x"9408fc05",
   964 => x"0c940888",
   965 => x"0508812a",
   966 => x"94088805",
   967 => x"0c94088c",
   968 => x"05081094",
   969 => x"088c050c",
   970 => x"51515151",
   971 => x"94088805",
   972 => x"08802e84",
   973 => x"38ffbd39",
   974 => x"9408fc05",
   975 => x"0870880c",
   976 => x"51833d0d",
   977 => x"940c04fc",
   978 => x"3d0d7670",
   979 => x"797b5555",
   980 => x"55558f72",
   981 => x"278c3872",
   982 => x"75078306",
   983 => x"5170802e",
   984 => x"a738ff12",
   985 => x"5271ff2e",
   986 => x"98387270",
   987 => x"81055433",
   988 => x"74708105",
   989 => x"5634ff12",
   990 => x"5271ff2e",
   991 => x"098106ea",
   992 => x"3874880c",
   993 => x"863d0d04",
   994 => x"74517270",
   995 => x"84055408",
   996 => x"71708405",
   997 => x"530c7270",
   998 => x"84055408",
   999 => x"71708405",
  1000 => x"530c7270",
  1001 => x"84055408",
  1002 => x"71708405",
  1003 => x"530c7270",
  1004 => x"84055408",
  1005 => x"71708405",
  1006 => x"530cf012",
  1007 => x"52718f26",
  1008 => x"c9388372",
  1009 => x"27953872",
  1010 => x"70840554",
  1011 => x"08717084",
  1012 => x"05530cfc",
  1013 => x"12527183",
  1014 => x"26ed3870",
  1015 => x"54ff8339",
  1016 => x"fb3d0d77",
  1017 => x"79707207",
  1018 => x"83065354",
  1019 => x"52709338",
  1020 => x"71737308",
  1021 => x"54565471",
  1022 => x"73082e80",
  1023 => x"c4387375",
  1024 => x"54527133",
  1025 => x"7081ff06",
  1026 => x"52547080",
  1027 => x"2e9d3872",
  1028 => x"33557075",
  1029 => x"2e098106",
  1030 => x"95388112",
  1031 => x"81147133",
  1032 => x"7081ff06",
  1033 => x"54565452",
  1034 => x"70e53872",
  1035 => x"33557381",
  1036 => x"ff067581",
  1037 => x"ff067171",
  1038 => x"31880c52",
  1039 => x"52873d0d",
  1040 => x"04710970",
  1041 => x"f7fbfdff",
  1042 => x"140670f8",
  1043 => x"84828180",
  1044 => x"06515151",
  1045 => x"70973884",
  1046 => x"14841671",
  1047 => x"08545654",
  1048 => x"7175082e",
  1049 => x"dc387375",
  1050 => x"5452ff96",
  1051 => x"39800b88",
  1052 => x"0c873d0d",
  1053 => x"04000000",
  1054 => x"00ffffff",
  1055 => x"ff00ffff",
  1056 => x"ffff00ff",
  1057 => x"ffffff00",
  1058 => x"30313233",
  1059 => x"34353637",
  1060 => x"38394142",
  1061 => x"43444546",
  1062 => x"00000000",
  1063 => x"44485259",
  1064 => x"53544f4e",
  1065 => x"45205052",
  1066 => x"4f475241",
  1067 => x"4d2c2053",
  1068 => x"4f4d4520",
  1069 => x"53545249",
  1070 => x"4e470000",
  1071 => x"44485259",
  1072 => x"53544f4e",
  1073 => x"45205052",
  1074 => x"4f475241",
  1075 => x"4d2c2031",
  1076 => x"27535420",
  1077 => x"53545249",
  1078 => x"4e470000",
  1079 => x"44687279",
  1080 => x"73746f6e",
  1081 => x"65204265",
  1082 => x"6e63686d",
  1083 => x"61726b2c",
  1084 => x"20566572",
  1085 => x"73696f6e",
  1086 => x"20322e31",
  1087 => x"20284c61",
  1088 => x"6e677561",
  1089 => x"67653a20",
  1090 => x"43290a00",
  1091 => x"50726f67",
  1092 => x"72616d20",
  1093 => x"636f6d70",
  1094 => x"696c6564",
  1095 => x"20776974",
  1096 => x"68202772",
  1097 => x"65676973",
  1098 => x"74657227",
  1099 => x"20617474",
  1100 => x"72696275",
  1101 => x"74650a00",
  1102 => x"45786563",
  1103 => x"7574696f",
  1104 => x"6e207374",
  1105 => x"61727473",
  1106 => x"2c202564",
  1107 => x"2072756e",
  1108 => x"73207468",
  1109 => x"726f7567",
  1110 => x"68204468",
  1111 => x"72797374",
  1112 => x"6f6e650a",
  1113 => x"00000000",
  1114 => x"44485259",
  1115 => x"53544f4e",
  1116 => x"45205052",
  1117 => x"4f475241",
  1118 => x"4d2c2032",
  1119 => x"274e4420",
  1120 => x"53545249",
  1121 => x"4e470000",
  1122 => x"55736572",
  1123 => x"2074696d",
  1124 => x"653a2025",
  1125 => x"640a0000",
  1126 => x"4d696372",
  1127 => x"6f736563",
  1128 => x"6f6e6473",
  1129 => x"20666f72",
  1130 => x"206f6e65",
  1131 => x"2072756e",
  1132 => x"20746872",
  1133 => x"6f756768",
  1134 => x"20446872",
  1135 => x"7973746f",
  1136 => x"6e653a20",
  1137 => x"00000000",
  1138 => x"2564200a",
  1139 => x"00000000",
  1140 => x"44687279",
  1141 => x"73746f6e",
  1142 => x"65732070",
  1143 => x"65722053",
  1144 => x"65636f6e",
  1145 => x"643a2020",
  1146 => x"20202020",
  1147 => x"20202020",
  1148 => x"20202020",
  1149 => x"20202020",
  1150 => x"20202020",
  1151 => x"00000000",
  1152 => x"56415820",
  1153 => x"4d495053",
  1154 => x"20726174",
  1155 => x"696e6720",
  1156 => x"2a203130",
  1157 => x"3030203d",
  1158 => x"20256420",
  1159 => x"0a000000",
  1160 => x"50726f67",
  1161 => x"72616d20",
  1162 => x"636f6d70",
  1163 => x"696c6564",
  1164 => x"20776974",
  1165 => x"686f7574",
  1166 => x"20277265",
  1167 => x"67697374",
  1168 => x"65722720",
  1169 => x"61747472",
  1170 => x"69627574",
  1171 => x"650a0000",
  1172 => x"4d656173",
  1173 => x"75726564",
  1174 => x"2074696d",
  1175 => x"6520746f",
  1176 => x"6f20736d",
  1177 => x"616c6c20",
  1178 => x"746f206f",
  1179 => x"62746169",
  1180 => x"6e206d65",
  1181 => x"616e696e",
  1182 => x"6766756c",
  1183 => x"20726573",
  1184 => x"756c7473",
  1185 => x"0a000000",
  1186 => x"506c6561",
  1187 => x"73652069",
  1188 => x"6e637265",
  1189 => x"61736520",
  1190 => x"6e756d62",
  1191 => x"6572206f",
  1192 => x"66207275",
  1193 => x"6e730a00",
  1194 => x"44485259",
  1195 => x"53544f4e",
  1196 => x"45205052",
  1197 => x"4f475241",
  1198 => x"4d2c2033",
  1199 => x"27524420",
  1200 => x"53545249",
  1201 => x"4e470000",
  1202 => x"000061a8",
  1203 => x"00000000",
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

