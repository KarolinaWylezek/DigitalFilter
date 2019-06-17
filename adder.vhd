library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder is
port(	A, B : in std_logic_vector(7 downto 0);
	operant : in std_logic;
	sum : out std_logic_vector(10 downto 0));
end adder;

architecture behaviour of adder is
signal summation : signed(7 downto 0);

begin
process(A,B,operant)
begin
if(operant='0') then summation <= signed(A) + signed(B);
else summation <= signed(A) - signed(B);
end if;
end process;
sum <= std_logic_vector(summation);
end behaviour;