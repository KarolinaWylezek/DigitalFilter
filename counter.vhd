library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
port(	clk, plus, minus, enable, clear : in std_logic;
	counted : out std_logic_vector(9 downto 0));
end counter;

architecture behaviour of counter is
begin
process(clk, clear, enable, plus , minus )
variable tmp : unsigned(9 downto 0):= "0000000000";
begin
if(enable='1' and clear='0') then
	if(rising_edge(clk)) then
		if(plus='1') then tmp:=tmp+1;
		elsif(minus='1') then 
			if(tmp="0000000000") then tmp:="0000000000";
			else tmp:=tmp-1;
			end if;
		end if;
	end if;
elsif(enable='1' and clear='1') then tmp:="0000000000";
end if;

counted<=std_logic_vector(tmp);
end process;
end behaviour;