LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;


ENTITY reg IS
PORT (	CS, wr, rd, clk : in std_logic;
	Address : in std_logic_vector(9 downto 0);
	input : in std_logic_vector(7 downto 0);
	output : out std_logic_vector(7 downto 0)); 
END reg;

ARCHITECTURE Behaviour OF reg IS

type memory is array (1023 downto 0) of std_logic_vector(7 downto 0);
signal mem : memory := (others=> "00000000");
begin
process(clk,rd)
begin
if(rising_edge(clk))then
	if(cs='1')then
		if(rd='1') then output<=std_logic_vector(mem(to_integer(unsigned(Address))));
		elsif(wr='1') then mem(to_integer(unsigned(Address)))<=input;
		end if;
	end if;
end if;
end process;
END Behaviour;

