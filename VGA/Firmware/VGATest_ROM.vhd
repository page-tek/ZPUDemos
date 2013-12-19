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

entity VGATest_ROM is
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
end VGATest_ROM;

architecture arch of VGATest_ROM is

type ram_type is array(natural range 0 to ((2**(maxAddrBitBRAM+1))/4)-1) of std_logic_vector(wordSize-1 downto 0);

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
     8 => x"88088c08",
     9 => x"90080b0b",
    10 => x"0b88e708",
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
   161 => x"0b0b0b91",
   162 => x"ac738306",
   163 => x"10100508",
   164 => x"060b0b0b",
   165 => x"88a20400",
   166 => x"00000000",
   167 => x"00000000",
   168 => x"88088c08",
   169 => x"90087575",
   170 => x"0b0b0b8d",
   171 => x"ae2d5050",
   172 => x"88085690",
   173 => x"0c8c0c88",
   174 => x"0c510400",
   175 => x"00000000",
   176 => x"88088c08",
   177 => x"90087575",
   178 => x"0b0b0b8e",
   179 => x"e02d5050",
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
   280 => x"8cec0404",
   281 => x"00000000",
   282 => x"00046302",
   283 => x"c0050d02",
   284 => x"80c4050b",
   285 => x"0b0b92a0",
   286 => x"5a5c807c",
   287 => x"7084055e",
   288 => x"08715f5f",
   289 => x"577d7084",
   290 => x"055f0856",
   291 => x"80587598",
   292 => x"2a76882b",
   293 => x"57557480",
   294 => x"2e82d338",
   295 => x"7c802eb9",
   296 => x"38805d74",
   297 => x"80e42e81",
   298 => x"9f387480",
   299 => x"e42680dc",
   300 => x"387480e3",
   301 => x"2eba38a5",
   302 => x"518c842d",
   303 => x"74518c84",
   304 => x"2d821757",
   305 => x"81185883",
   306 => x"7825c338",
   307 => x"74ffb638",
   308 => x"7e880c02",
   309 => x"80c0050d",
   310 => x"0474a52e",
   311 => x"09810698",
   312 => x"38810b81",
   313 => x"19595d83",
   314 => x"7825ffa2",
   315 => x"3889cc04",
   316 => x"7b841d71",
   317 => x"08575d5a",
   318 => x"74518c84",
   319 => x"2d811781",
   320 => x"19595783",
   321 => x"7825ff86",
   322 => x"3889cc04",
   323 => x"7480f32e",
   324 => x"098106ff",
   325 => x"a2387b84",
   326 => x"1d710870",
   327 => x"545b5d54",
   328 => x"8ca52d80",
   329 => x"0bff1155",
   330 => x"53807325",
   331 => x"ff963878",
   332 => x"7081055a",
   333 => x"84e02d70",
   334 => x"52558c84",
   335 => x"2d811774",
   336 => x"ff165654",
   337 => x"578aa904",
   338 => x"7b841d71",
   339 => x"080b0b0b",
   340 => x"92a00b0b",
   341 => x"0b0b91d0",
   342 => x"615f585e",
   343 => x"525d5380",
   344 => x"73248193",
   345 => x"3872ba38",
   346 => x"b00b0b0b",
   347 => x"0b91d00b",
   348 => x"85802d81",
   349 => x"1454ff14",
   350 => x"547384e0",
   351 => x"2d7b7081",
   352 => x"055d8580",
   353 => x"2d811a5a",
   354 => x"730b0b0b",
   355 => x"91d02e09",
   356 => x"8106e338",
   357 => x"807b8580",
   358 => x"2d79ff11",
   359 => x"55538aa9",
   360 => x"048a5272",
   361 => x"518ee02d",
   362 => x"880891bc",
   363 => x"0584e02d",
   364 => x"74708105",
   365 => x"5685802d",
   366 => x"8a527251",
   367 => x"8dae2d88",
   368 => x"08538808",
   369 => x"dc38730b",
   370 => x"0b0b91d0",
   371 => x"2ec638ff",
   372 => x"14547384",
   373 => x"e02d7b70",
   374 => x"81055d85",
   375 => x"802d811a",
   376 => x"5a730b0b",
   377 => x"0b91d02e",
   378 => x"ffaa388a",
   379 => x"f6047688",
   380 => x"0c0280c0",
   381 => x"050d04ad",
   382 => x"518c842d",
   383 => x"72098105",
   384 => x"538ae504",
   385 => x"02f8050d",
   386 => x"7352c008",
   387 => x"70882a70",
   388 => x"81065151",
   389 => x"5170802e",
   390 => x"f13871c0",
   391 => x"0c71880c",
   392 => x"0288050d",
   393 => x"0402e805",
   394 => x"0d807857",
   395 => x"55757084",
   396 => x"05570853",
   397 => x"80547298",
   398 => x"2a73882b",
   399 => x"54527180",
   400 => x"2ea238c0",
   401 => x"0870882a",
   402 => x"70810651",
   403 => x"51517080",
   404 => x"2ef13871",
   405 => x"c00c8115",
   406 => x"81155555",
   407 => x"837425d6",
   408 => x"3871ca38",
   409 => x"74880c02",
   410 => x"98050d04",
   411 => x"02ec050d",
   412 => x"80518480",
   413 => x"800bfc80",
   414 => x"0c811170",
   415 => x"52558480",
   416 => x"80538054",
   417 => x"84fe5281",
   418 => x"117083ff",
   419 => x"ff067075",
   420 => x"70840557",
   421 => x"0cfe1454",
   422 => x"51517180",
   423 => x"25e93881",
   424 => x"145483df",
   425 => x"7425dd38",
   426 => x"8115518c",
   427 => x"f9049408",
   428 => x"02940cf9",
   429 => x"3d0d800b",
   430 => x"9408fc05",
   431 => x"0c940888",
   432 => x"05088025",
   433 => x"ab389408",
   434 => x"88050830",
   435 => x"94088805",
   436 => x"0c800b94",
   437 => x"08f4050c",
   438 => x"9408fc05",
   439 => x"08883881",
   440 => x"0b9408f4",
   441 => x"050c9408",
   442 => x"f4050894",
   443 => x"08fc050c",
   444 => x"94088c05",
   445 => x"088025ab",
   446 => x"3894088c",
   447 => x"05083094",
   448 => x"088c050c",
   449 => x"800b9408",
   450 => x"f0050c94",
   451 => x"08fc0508",
   452 => x"8838810b",
   453 => x"9408f005",
   454 => x"0c9408f0",
   455 => x"05089408",
   456 => x"fc050c80",
   457 => x"5394088c",
   458 => x"05085294",
   459 => x"08880508",
   460 => x"5181a73f",
   461 => x"88087094",
   462 => x"08f8050c",
   463 => x"549408fc",
   464 => x"0508802e",
   465 => x"8c389408",
   466 => x"f8050830",
   467 => x"9408f805",
   468 => x"0c9408f8",
   469 => x"05087088",
   470 => x"0c54893d",
   471 => x"0d940c04",
   472 => x"94080294",
   473 => x"0cfb3d0d",
   474 => x"800b9408",
   475 => x"fc050c94",
   476 => x"08880508",
   477 => x"80259338",
   478 => x"94088805",
   479 => x"08309408",
   480 => x"88050c81",
   481 => x"0b9408fc",
   482 => x"050c9408",
   483 => x"8c050880",
   484 => x"258c3894",
   485 => x"088c0508",
   486 => x"3094088c",
   487 => x"050c8153",
   488 => x"94088c05",
   489 => x"08529408",
   490 => x"88050851",
   491 => x"ad3f8808",
   492 => x"709408f8",
   493 => x"050c5494",
   494 => x"08fc0508",
   495 => x"802e8c38",
   496 => x"9408f805",
   497 => x"08309408",
   498 => x"f8050c94",
   499 => x"08f80508",
   500 => x"70880c54",
   501 => x"873d0d94",
   502 => x"0c049408",
   503 => x"02940cfd",
   504 => x"3d0d810b",
   505 => x"9408fc05",
   506 => x"0c800b94",
   507 => x"08f8050c",
   508 => x"94088c05",
   509 => x"08940888",
   510 => x"050827ac",
   511 => x"389408fc",
   512 => x"0508802e",
   513 => x"a338800b",
   514 => x"94088c05",
   515 => x"08249938",
   516 => x"94088c05",
   517 => x"08109408",
   518 => x"8c050c94",
   519 => x"08fc0508",
   520 => x"109408fc",
   521 => x"050cc939",
   522 => x"9408fc05",
   523 => x"08802e80",
   524 => x"c9389408",
   525 => x"8c050894",
   526 => x"08880508",
   527 => x"26a13894",
   528 => x"08880508",
   529 => x"94088c05",
   530 => x"08319408",
   531 => x"88050c94",
   532 => x"08f80508",
   533 => x"9408fc05",
   534 => x"08079408",
   535 => x"f8050c94",
   536 => x"08fc0508",
   537 => x"812a9408",
   538 => x"fc050c94",
   539 => x"088c0508",
   540 => x"812a9408",
   541 => x"8c050cff",
   542 => x"af399408",
   543 => x"90050880",
   544 => x"2e8f3894",
   545 => x"08880508",
   546 => x"709408f4",
   547 => x"050c518d",
   548 => x"399408f8",
   549 => x"05087094",
   550 => x"08f4050c",
   551 => x"519408f4",
   552 => x"0508880c",
   553 => x"853d0d94",
   554 => x"0c040000",
   555 => x"00ffffff",
   556 => x"ff00ffff",
   557 => x"ffff00ff",
   558 => x"ffffff00",
   559 => x"30313233",
   560 => x"34353637",
   561 => x"38394142",
   562 => x"43444546",
   563 => x"00444546",
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

