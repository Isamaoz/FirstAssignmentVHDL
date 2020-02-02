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


ENTITY main1_one_digit IS
    PORT (
        sw   : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
        seg  : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        --dp   : out STD_LOGIC;
        an   : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END main1_one_digit;

ARCHITECTURE Behavioral OF main1_one_digit IS

BEGIN
    an <= "0000";
    seg <=  "0000001" WHEN sw = "0000" ELSE
            "1001111" WHEN sw = "0001" ELSE
            "0010010" WHEN sw = "0010" ELSE
            "0000110" WHEN sw = "0011" ELSE
            "1001100" WHEN sw = "0100" ELSE
            "0100100" WHEN sw = "0101" ELSE
            "1100000" WHEN sw = "0110" ELSE
            "0001111" WHEN sw = "0111" ELSE
            "0000000" WHEN sw = "1000" ELSE
            "0001100" WHEN sw = "1001";
    --dp <= sw(7);
    
END Behavioral;
