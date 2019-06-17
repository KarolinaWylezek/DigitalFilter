library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift is
port(	s_in : in std_logic_vector(7 downto 0);
	k : in integer;
	s_out : out std_logic_vector(7 downto 0);
	lefts, rights, load, clk, rst : in std_logic);
end shift;

architecture behaviour of shift is
begin
process(rst,clk,lefts,rights,load,s_in,k)
variable input : signed(7 downto 0);
begin
if(rst='1') then s_out<="00000000";
elsif(rising_edge(clk)) then 
	if (load='1') then input:=signed(s_in);
	end if;
	if(lefts='1') then input:=shift_left(input,k);
	elsif(rights='1') then input:=shift_right(input,k);
	end if;
	s_out<=std_logic_vector(input);
end if;
end process;
end behaviour;
