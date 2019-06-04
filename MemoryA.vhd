LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY MemoryA IS
PORT(	DataIn : in std_logic_vector(7 downto 0);
	Address : in std_logic_vector(9 downto 0);
	CS : in std_logic;
	clk :  in std_logic;
	wr : in std_logic;
	data_out : out std_logic_vector(7 downto 0);
	DATA_OUT1 : out std_logic_vector(7 downto 0);
	data_out2 : out std_logic_vector(7 downto 0);
	data_out3 : out std_logic_vector(7 downto 0);
	RD : out std_logic
	);
END MemoryA;

Architecture behaviour of MemoryA is

--signal w :std_logic:='0';

subtype int is integer range 0 to 1023;
signal a : int :=0; 
signal addrs : int;


type storage is array (1023 downto 0) of std_logic_vector(7 downto 0);
signal box : storage;
--signal a : storage;

begin
addrs <= to_integer(signed(Address));

process(clk, wr, CS)
	begin
	if ((rising_edge(clk))and(wr='0')and(CS='1')) then 
		box(a)<=DataIn;
		a<=a+1;
	end if;
end process;


process(clk, CS, wr )
	begin
	if((rising_edge(clk))and(wr='1')and(CS='1')) then
		data_out<=box(addrs);
		data_out1<=box(addrs-1);
		data_out2<=box(addrs-2);
		data_out3<=box(addrs-3);
	end if;
end process;

end behaviour;
