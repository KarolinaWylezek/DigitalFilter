IBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

ENTITY Datapath IS
PORT(	datain0 : in std_logic_vector(7 downto 0);
	datain1 : in std_logic_vector(7 downto 0);
	datain2 : in std_logic_vector(7 downto 0);
	datain3 : in std_logic_vector(7 downto 0);
	address : in std_logic_vector(9 downto 0);
	data_out : out signed(7 downto 0)
	);
END Datapath;

Architecture behaviour of Datapath is

component register
