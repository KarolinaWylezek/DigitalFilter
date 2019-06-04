library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity part1 is 
port(	DataIn : in std_logic_vector(7 downto 0);
	Address : in std_logic_vector(9 downto 0);
	CS : in std_logic;
	clk :  in std_logic;
	wr : in std_logic;
	data_out : out std_logic_vector(7 downto 0);
	RD : out std_logic);
end entity;

Architecture behavior of part1 is 

component MemoryA IS
PORT(	DataIn : in std_logic_vector(7 downto 0);
	Address : in std_logic_vector(9 downto 0);
	CS : in std_logic;
	clk :  in std_logic;
	wr : in std_logic;
	data_out : out std_logic_vector(7 downto 0);
	RD : out std_logic);
End component; 

component MemoryB IS
PORT(	DataIn : in std_logic_vector(7 downto 0);
	Address : in std_logic_vector(9 downto 0);
	CS : in std_logic;
	clk :  in std_logic;
	wr : in std_logic;
	data_out : out std_logic_vector(7 downto 0);
	RD : out std_logic);
End component; 

component Datapath is 
PORT(	datain0 : in std_logic_vector(7 downto 0);
	datain1 : in std_logic_vector(7 downto 0);
	datain2 : in std_logic_vector(7 downto 0);
	datain3 : in std_logic_vector(7 downto 0);
	address : in std_logic_vector(9 downto 0);
	data_out : out signed(15 downto 0));
END component;
begin

end behavior;