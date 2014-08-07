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

entity HelloTinyZPU_ROM is
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
end HelloTinyZPU_ROM;

architecture arch of HelloTinyZPU_ROM is

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
   161 => x"0b0b0b8d",
   162 => x"e4738306",
   163 => x"10100508",
   164 => x"060b0b0b",
   165 => x"88a20400",
   166 => x"00000000",
   167 => x"00000000",
   168 => x"88088c08",
   169 => x"90087575",
   170 => x"0b0b0b89",
   171 => x"e52d5050",
   172 => x"88085690",
   173 => x"0c8c0c88",
   174 => x"0c510400",
   175 => x"00000000",
   176 => x"88088c08",
   177 => x"90087575",
   178 => x"0b0b0b8b",
   179 => x"972d5050",
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
   279 => x"04040000",
   280 => x"00000004",
   281 => x"5d8e8470",
   282 => x"8e84278b",
   283 => x"38807170",
   284 => x"8405530c",
   285 => x"88e70488",
   286 => x"da5188fd",
   287 => x"04803d0d",
   288 => x"8df451a8",
   289 => x"3f800b88",
   290 => x"0c823d0d",
   291 => x"04ff3d0d",
   292 => x"7352c008",
   293 => x"70882a70",
   294 => x"81065151",
   295 => x"5170802e",
   296 => x"f13871c0",
   297 => x"0c71880c",
   298 => x"833d0d04",
   299 => x"fd3d0d75",
   300 => x"53723370",
   301 => x"81ff0652",
   302 => x"5270802e",
   303 => x"a1387181",
   304 => x"ff068114",
   305 => x"5452c008",
   306 => x"70882a70",
   307 => x"81065151",
   308 => x"5170802e",
   309 => x"f13871c0",
   310 => x"0c811454",
   311 => x"d4397388",
   312 => x"0c853d0d",
   313 => x"04940802",
   314 => x"940cf93d",
   315 => x"0d800b94",
   316 => x"08fc050c",
   317 => x"94088805",
   318 => x"088025ab",
   319 => x"38940888",
   320 => x"05083094",
   321 => x"0888050c",
   322 => x"800b9408",
   323 => x"f4050c94",
   324 => x"08fc0508",
   325 => x"8838810b",
   326 => x"9408f405",
   327 => x"0c9408f4",
   328 => x"05089408",
   329 => x"fc050c94",
   330 => x"088c0508",
   331 => x"8025ab38",
   332 => x"94088c05",
   333 => x"08309408",
   334 => x"8c050c80",
   335 => x"0b9408f0",
   336 => x"050c9408",
   337 => x"fc050888",
   338 => x"38810b94",
   339 => x"08f0050c",
   340 => x"9408f005",
   341 => x"089408fc",
   342 => x"050c8053",
   343 => x"94088c05",
   344 => x"08529408",
   345 => x"88050851",
   346 => x"81a73f88",
   347 => x"08709408",
   348 => x"f8050c54",
   349 => x"9408fc05",
   350 => x"08802e8c",
   351 => x"389408f8",
   352 => x"05083094",
   353 => x"08f8050c",
   354 => x"9408f805",
   355 => x"0870880c",
   356 => x"54893d0d",
   357 => x"940c0494",
   358 => x"0802940c",
   359 => x"fb3d0d80",
   360 => x"0b9408fc",
   361 => x"050c9408",
   362 => x"88050880",
   363 => x"25933894",
   364 => x"08880508",
   365 => x"30940888",
   366 => x"050c810b",
   367 => x"9408fc05",
   368 => x"0c94088c",
   369 => x"05088025",
   370 => x"8c389408",
   371 => x"8c050830",
   372 => x"94088c05",
   373 => x"0c815394",
   374 => x"088c0508",
   375 => x"52940888",
   376 => x"050851ad",
   377 => x"3f880870",
   378 => x"9408f805",
   379 => x"0c549408",
   380 => x"fc050880",
   381 => x"2e8c3894",
   382 => x"08f80508",
   383 => x"309408f8",
   384 => x"050c9408",
   385 => x"f8050870",
   386 => x"880c5487",
   387 => x"3d0d940c",
   388 => x"04940802",
   389 => x"940cfd3d",
   390 => x"0d810b94",
   391 => x"08fc050c",
   392 => x"800b9408",
   393 => x"f8050c94",
   394 => x"088c0508",
   395 => x"94088805",
   396 => x"0827ac38",
   397 => x"9408fc05",
   398 => x"08802ea3",
   399 => x"38800b94",
   400 => x"088c0508",
   401 => x"24993894",
   402 => x"088c0508",
   403 => x"1094088c",
   404 => x"050c9408",
   405 => x"fc050810",
   406 => x"9408fc05",
   407 => x"0cc93994",
   408 => x"08fc0508",
   409 => x"802e80c9",
   410 => x"3894088c",
   411 => x"05089408",
   412 => x"88050826",
   413 => x"a1389408",
   414 => x"88050894",
   415 => x"088c0508",
   416 => x"31940888",
   417 => x"050c9408",
   418 => x"f8050894",
   419 => x"08fc0508",
   420 => x"079408f8",
   421 => x"050c9408",
   422 => x"fc050881",
   423 => x"2a9408fc",
   424 => x"050c9408",
   425 => x"8c050881",
   426 => x"2a94088c",
   427 => x"050cffaf",
   428 => x"39940890",
   429 => x"0508802e",
   430 => x"8f389408",
   431 => x"88050870",
   432 => x"9408f405",
   433 => x"0c518d39",
   434 => x"9408f805",
   435 => x"08709408",
   436 => x"f4050c51",
   437 => x"9408f405",
   438 => x"08880c85",
   439 => x"3d0d940c",
   440 => x"04000000",
   441 => x"00ffffff",
   442 => x"ff00ffff",
   443 => x"ffff00ff",
   444 => x"ffffff00",
   445 => x"48656c6c",
   446 => x"6f2c2077",
   447 => x"6f726c64",
   448 => x"210a0064",
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

