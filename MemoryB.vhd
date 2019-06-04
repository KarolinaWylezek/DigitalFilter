LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY MemoryB IS
PORT(	DataIn : in std_logic_vector(7 downto 0);
	Address : in std_logic_vector(9 downto 0);
	CS : in std_logic;
	clk :  in std_logic;
	wr : in std_logic;
	data_out : out std_logic_vector(7 downto 0);
	RD : out std_logic
	);
END MemoryB;

Architecture behaviour of MemoryA is

subtype int is integer range 0 to 1023;
signal addrs : int;
type storage is array (1023 downto 0) of std_logic_vector(7 downto 0);
signal box : storage;
signal input : std_logic_vector(7 downto 0);

begin
addrs <= to_integer(signed(Address)); 

process(clk, wr, CS)
	begin
	if ((rising_edge(clk))and(wr='0')and(CS='1')) then 
		box(addrs)<=DataIn;
	end if;
end process;

end behaviour;