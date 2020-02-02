
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.01.2020 11:22:24
-- Design Name: 
-- Module Name: four_digits - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity one_digit is
    Port (
        swi   : in  STD_LOGIC_VECTOR (3 downto 0);
        segm  : out STD_LOGIC_VECTOR (6 downto 0));
        --ann   : out STD_LOGIC_VECTOR (3 downto 0));
end one_digit;

architecture Behavioral of one_digit is

begin
    --an <= an_value;
    segm <=  "0000001" when swi = "0000" else
            "1001111" when swi = "0001" else
            "0010010" when swi = "0010" else
            "0000110" when swi = "0011" else
            "1001100" when swi = "0100" else
            "0100100" when swi = "0101" else
            "1100000" when swi = "0110" else
            "0001111" when swi = "0111" else
            "0000000" when swi = "1000" else
            "0001100" when swi = "1001";
    
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- MODIFY FOUR DIGITS PORT
entity four_digits is
  Port (  button: in STD_LOGIC;
          sw   : in  STD_LOGIC_VECTOR (15 downto 0);
          seg  : out STD_LOGIC_VECTOR (6 downto 0);
          an   : out STD_LOGIC_VECTOR (3 downto 0));
end four_digits;

ARCHITECTURE Behav OF four_digits IS
    TYPE toggle_sw IS (one, two, three, four);
    COMPONENT one_digit
        PORT (
            swi   : in  STD_LOGIC_VECTOR (3 downto 0);
            segm  : out STD_LOGIC_VECTOR (6 downto 0));
            --an   : out STD_LOGIC_VECTOR (3 downto 0));
    END COMPONENT;
    SIGNAL current_state, next_state : toggle_sw;
    SIGNAL reg: UNSIGNED(3 downto 0) := "1110";
    SIGNAL shifted: UNSIGNED(3 downto 0);
    SIGNAL seg3, seg2, seg1, seg0: STD_LOGIC_VECTOR(6 downto 0);
BEGIN
    an <= STD_LOGIC_VECTOR(reg);
    state1: one_digit port map (sw(15 downto 12),seg3);
    state2: one_digit port map (sw(11 downto 8),seg2);
    state3: one_digit port map (sw(7 downto 4),seg1);
    state4: one_digit port map (sw(3 downto 0),seg0);
    PROCESS(button)
    BEGIN
        IF button = '1' THEN
            --first time it works but then it doesn't
            --set first value
            --add debouncer
            reg <= shift_right(reg,1);
            --reg <= shifted;
            CASE current_state IS
            WHEN one => 
            --cambiar que segmento va a ser el outputeado
            seg <= seg3;
            next_state <= two;
            WHEN two =>
            seg <= seg2;
            next_state <= three;
            WHEN three =>
            seg <= seg1;
            next_state <= four;
            WHEN four =>
            seg <= seg0;
            next_state <= one;
            END CASE;
         END IF;
    END PROCESS;
end Behav;