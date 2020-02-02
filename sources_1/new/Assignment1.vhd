----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.01.2020 16:15:36
-- Design Name: 
-- Module Name: main - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main0_dummy is
    Port (
        sw   : in  STD_LOGIC_VECTOR (15 downto 0);
        seg  : out STD_LOGIC_VECTOR (6 downto 0);
        dp   : out STD_LOGIC;
        an   : out STD_LOGIC_VECTOR (3 downto 0));
end main0_dummy;

architecture Behavioral of main0_dummy is

begin
    an <= "0000";
    seg <=  "1111111" when sw(3 downto 0) = "0000" else
            "1001111" when sw(3 downto 0) = "0001" else
            "0010010" when sw(3 downto 0) = "0010" else
            "0000110" when sw(3 downto 0) = "0011" else
            "1001100" when sw(3 downto 0) = "0100" else
            "0100100" when sw(3 downto 0) = "0101" else
            "1100000" when sw(3 downto 0) = "0110" else
            "0001111" when sw(3 downto 0) = "0111" else
            "0000000" when sw(3 downto 0) = "1000" else
            "0001100" when sw(3 downto 0) = "1001";
    dp <= sw(7);
    
end Behavioral;
