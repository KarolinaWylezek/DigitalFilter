LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY CU IS 
PORT(  
	CUDATA_IN    : in  std_logic_vector(7 downto 0);
	CUCLK      : in  std_logic;
	CUSTART	: in  std_logic;
	CUDATA_OUT  : out std_logic_vector(7 downto 0);
	CUDONE : out std_logic);
	
END entity;


ARCHITECTURE BEHAVIOUR OF CU IS
--COMPONENTS: 
component REG
port(	
	DataIn : in std_logic_vector(7 downto 0);
	Address : in std_logic_vector(9 downto 0);
	CS : in std_logic;
	clk :  in std_logic;
	wr : in std_logic;
	RD : in std_logic;
	data_out : out std_logic_vector(7 downto 0)
	
	);
end component;

component counter
port(	clk, plus, minus, enable, clear : in std_logic;
	counted : out std_logic_vector(9 downto 0));
end component;

component shift
port(	s_in : in std_logic_vector(7 downto 0);
	k : in integer;
	s_out : out std_logic_vector(7 downto 0);
	lefts, rights, load, clk, rst : in std_logic);
end component;

component adder
port(	A, B : in std_logic_vector(10 downto 0);
	operant : in std_logic;
	sum : out std_logic_vector(10 downto 0));
end component;


--SIGNALS:
--Counter
signal CUplus, CUminus, CUenable, CUclear : std_logic;
signal CUcounted: std_logic_vector(9 downto 0);
--Memory A
signal CUaddrs_A : std_logic_vector(9 downto 0);
signal CUcs_A, CUwr_A, CUrd_A : std_logic;
signal CUData_out_A : std_logic_vector(7 downto 0);
--Memory B
signal CUData_in_B: std_logic_vector(7 downto 0);
signal CUaddrs_B : std_logic_vector(9 downto 0);
signal CUcs_B, CUwr_B, CUrd_B : std_logic;
--Shifter
signal CUS_IN : std_logic_vector(7 downto 0);
signal CUS_OUT : std_logic_vector(7 downto 0);
signal CUk : integer;
signal CUlefts, CUrights, CUload, CUrst : std_logic;
--Adder
signal CUA,CUB : std_logic_vector(10 downto 0);
signal CUOperand : std_logic;
signal CUSum : std_logic_vector(10 downto 0);
--Memory A Mode: 0 for write, 1 for read
signal CUoperationA : std_logic :='0';
--BEGIN SECTION:
begin
--Port Mapping of Components:
Shifter1 : shift port map(CUS_IN, CUk, CUS_OUT, CUlefts, CUrights, CUload, CUCLK ,CUrst);
Adder1 : adder port map(CUA, CUB, CUOperand, CUSum);
MemA : REG port map(CUData_IN, CUaddrs_A,CUcs_A, CUclk, CUwr_A,CUrd_A,CUdata_out_A);
MemB : REG port map(CUData_in_B, CUaddrs_B,CUcs_B, CUclk, CUwr_B,CUrd_B,CUData_out);
Counter1 : counter port map(CUCLK, CUplus,  CUminus, CUenable, CUclear, CUcounted);
--EXECUTION OF THE PROGRAM PROCESS:
process (CUoperationA,CUcounted,CUSTART,CUaddrs_A,CUS_OUT,CUData_out_A,CUSum)
--VARIABLES:
variable CU_address_tmp: unsigned(9 downto 0):= unsigned(CUcounted);
variable a,b,c,d,X,Y,SUMA: std_logic_vector(10 downto 0);
--BEGIN OF PROCESS SECTION:
begin
--FILLING OF MEMORY A SECTION
CUaddrs_A<=CUcounted;
if(CUSTART='1')then
CUenable<='1';
if(CUaddrs_A="1111111111") then CUoperationA <= not(CUoperationA);
	CUclear<='1';
elsif(CUaddrs_A<"1111111111") then CUclear<='0';
end if; 

if (CUoperationA='0') then CUwr_A<='1';
	 CUrd_A<='0';
	CUCS_A<='1';

elsif CUoperationA='1' then CUwr_A<='0';
	 CUrd_A<='1';
	CUCS_A<='1';
end if;
end if;
--FILLING OF MEMORY B SECTION
CUenable<='1';
CUaddrs_B<=CUcounted;
if((CUSTART='1') and (CUcounted<"1111111111")and(CUrd_A='1'))then
CUwr_B<='1';
CUrd_B<='0';
CUcs_B<='1';
--Loading the first shifter to compute 0.5*X(n)
CUk <= 1;
CUlefts <= '0';
CUrights <= '1';
CUload <= '1';
CUrst <= '0';
CUS_IN<=CUData_out_A;
a(0):=CUS_OUT(0);
a(1):=CUS_OUT(1);
a(2):=CUS_OUT(2);
a(3):=CUS_OUT(3);
a(4):=CUS_OUT(4);
a(5):=CUS_OUT(5);
a(6):=CUS_OUT(6);
a(7):=CUS_OUT(7);
a(8):=CUS_OUT(7);
a(9):=CUS_OUT(7);
a(10):=CUS_OUT(7);
--Loading the second shifter to compute 2*X(n-1)
CUk <= 1;
CUlefts <= '1';
CUrights <= '0';
CU_address_tmp := CU_address_tmp - 1;
CUS_IN<=CUData_out_A;
b(0):=CUS_OUT(0);
b(1):=CUS_OUT(1);
b(2):=CUS_OUT(2);
b(3):=CUS_OUT(3);
b(4):=CUS_OUT(4);
b(5):=CUS_OUT(5);
b(6):=CUS_OUT(6);
b(7):=CUS_OUT(7);
b(8):=CUS_OUT(7);
b(9):=CUS_OUT(7);
b(10):=CUS_OUT(7);
--Loading the third shifter to compute 4*X(n-2)
CUk <= 2;
CUlefts <= '1';
CUrights <= '0';
CU_address_tmp := CU_address_tmp - 1;
CUS_IN<=CUData_out_A;
c(0):=CUS_OUT(0);
c(1):=CUS_OUT(1);
c(2):=CUS_OUT(2);
c(3):=CUS_OUT(3);
c(4):=CUS_OUT(4);
c(5):=CUS_OUT(5);
c(6):=CUS_OUT(6);
c(7):=CUS_OUT(7);
c(8):=CUS_OUT(7);
c(9):=CUS_OUT(7);
c(10):=CUS_OUT(7);
--Loading the fourth shifter to compute 0.25*X(n-3)
CUk <= 2;
CUlefts <= '0';
CUrights <= '1';
CU_address_tmp := CU_address_tmp - 1;
CUS_IN<=CUData_out_A;
d(0):=CUS_OUT(0);
d(1):=CUS_OUT(1);
d(2):=CUS_OUT(2);
d(3):=CUS_OUT(3);
d(4):=CUS_OUT(4);
d(5):=CUS_OUT(5);
d(6):=CUS_OUT(6);
d(7):=CUS_OUT(7);
d(8):=CUS_OUT(7);
d(9):=CUS_OUT(7);
d(10):=CUS_OUT(7);
if(CUCounted = "0000000000") then
	b:="00000000000";
	c:="00000000000";
	d:="00000000000";
elsif(CUCounted = "0000000001") then
	c:="00000000000";
	d:="00000000000";
elsif(CUCounted = "0000000010") then
	d:="00000000000";
else
end if;
-- first sum: -0.5*X(n)+4*X(n-2) = c - a = S1

CUOperand <= '1';
CUA<=c;
CUB<=a;
X:=CUSum;

--2nd sum: -2*X(n-1)+0.25*X(n-3) = d - b = S2

CUOperand <= '1';
CUA<=d;
CUB<=b;
Y:=CUSum;

--3rd sum S3 = S1 + S2

CUOperand <= '0';
CUA<=X;
CUB<=Y;

if(CUSum>"00001111111") then CUData_in_B<="01111111";
elsif(CUSum<"11110000000") then CUData_in_B<="10000000";
else

CUData_in_B(0) <= CUSum(0);
CUData_in_B(1) <= CUSum(1);
CUData_in_B(2) <= CUSum(2);
CUData_in_B(3) <= CUSum(3);
CUData_in_B(4) <= CUSum(4);
CUData_in_B(5) <= CUSum(5);
CUData_in_B(6) <= CUSum(6);
CUData_in_B(7) <= CUSum(10);

end if;

else CUDONE<='1';
end if;
end process;	
end behaviour;