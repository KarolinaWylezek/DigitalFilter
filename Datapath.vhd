LIBRARY ieee;
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
signal output : signed(15 downto 0);
begin 
process(address)
begin

if address=0 then 
	output <= -1*(shift_right(signed(datain0),2));

elsif address=1 then 
	output <= -1*(shift_right(signed(datain0),2)- shift_left(signed(datain1),2));

elsif(address=2) then 
	output <= -1*(shift_right(signed(datain0),2)- shift_left(signed(datain1),2) + shift_left(signed(datain2),4));

else
	 output <= -1*(shift_right(signed(datain0),2)- shift_left(signed(datain1),2) + shift_left(signed(datain2),4)+ shift_right(signed(datain3),4));
end if;

if(output>"01111111") then data_out<="01111111";
elsif (output<"10000000") then data_out<="10000000";
else data_out<=output;
end if;
end process;
end behaviour;
