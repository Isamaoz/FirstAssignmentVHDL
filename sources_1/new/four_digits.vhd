
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

ENTITY debouncer IS
    GENERIC( clk_freq : INTEGER := 50_000_00;
             stable_time: INTEGER := 10); 
    PORT( clk:  IN STD_LOGIC;
          reset: IN STD_LOGIC;
          button_in: IN STD_LOGIC;
          pulse_out: OUT STD_LOGIC);
END debouncer;

ARCHITECTURE behav OF debouncer is
    SIGNAL flipflops : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL counter_set : STD_LOGIC;
    --CONSTANT count_max: integer := 100000;
    --CONSTANT active: STD_LOGIC := '1';
    --SIGNAL counter: integer := 0;
    --TYPE btn_state IS (off, wait_time);
    --SIGNAL state: btn_state := off;
BEGIN
    counter_set <= flipflops(0) xor flipflops(1);
PROCESS(reset, clk)
    VARIABLE count: INTEGER RANGE 0 to clk_freq*stable_time/1000;
BEGIN
    IF (reset = '1') THEN
        flipflops <= "00";
        pulse_out <= '0';
    ELSIF (RISING_EDGE(clk)) THEN
        flipflops(0) <= button_in;
        flipflops(1) <= flipflops(0);
        IF(counter_set = '1') THEN
            count := 0;
        ELSIF(count < clk_freq*stable_time/1000) THEN
            count := count + 1;
        ELSE 
            pulse_out <= flipflops(1);
        END IF;
    END IF;
END PROCESS;
    
    
    
    
--        CASE (state) IS 
--            WHEN off =>
--                IF(button_in = active) THEN
--                    state <= wait_time;
--                ELSE
--                    state <= off;
--                END IF;
--                pulse_out <= '0';
--            WHEN wait_time =>
--                IF(counter = count_max) THEN
--                    counter <= 0;
--                    IF (button_in = active) then
--                        pulse_out <= '1';
--                    END IF;
--                state <= off;
--                ELSE
--                    counter <= counter + 1;
--                END IF;
--        END CASE;
--   END IF;
--END PROCESS;
END ARCHITECTURE;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- MODIFY FOUR DIGITS PORT
entity four_digits is
  Port (  clock: in STD_LOGIC;
          rst: in STD_LOGIC;
          button: in STD_LOGIC;
          sw   : in  STD_LOGIC_VECTOR (15 downto 0);
          seg  : out STD_LOGIC_VECTOR (6 downto 0);
          an   : out STD_LOGIC_VECTOR (3 downto 0);
          led  : out STD_LOGIC_VECTOR (3 downto 0));
end four_digits;

-- First number in the board is 8, when none of the switches have that number

-- When the button is pressed, it changes the 4 numbers accordingly to the 
-- first 4 switches.

ARCHITECTURE Behav OF four_digits IS
    TYPE toggle_sw IS (one, two, three, four);
    COMPONENT one_digit
        PORT (
            swi   : in  STD_LOGIC_VECTOR (3 downto 0);
            segm  : out STD_LOGIC_VECTOR (6 downto 0));
            --an   : out STD_LOGIC_VECTOR (3 downto 0));
    END COMPONENT;
    
    COMPONENT debouncer 
        PORT( clk:  IN STD_LOGIC;
              reset: IN STD_LOGIC;
              button_in: IN STD_LOGIC;
              pulse_out: OUT STD_LOGIC);
    END COMPONENT;
    
    SIGNAL current_state: toggle_sw := one;
    SIGNAL reg: UNSIGNED(3 downto 0) := "0111";
    SIGNAL shifted: UNSIGNED(3 downto 0);
    SIGNAL seg3, seg2, seg1, seg0: STD_LOGIC_VECTOR(6 downto 0);
    SIGNAL pulse: STD_LOGIC;
BEGIN
    --an <= STD_LOGIC_VECTOR(reg);
    debounce: debouncer port map (clock, rst, button, pulse);
    state1: one_digit port map (sw(15 downto 12),seg3);
    state2: one_digit port map (sw(11 downto 8),seg2);
    state3: one_digit port map (sw(7 downto 4),seg1);
    state4: one_digit port map (sw(3 downto 0),seg0);
    PROCESS(button)
    BEGIN
        --WAIT UNTIL button'EVENT and button = '1';
            --first time it works but then it doesn't
            --set first value
            --add debouncer
            --reg <= shift_right(reg,1);
            --reg <= shifted;
            CASE current_state IS
            WHEN one => 
            --cambiar que segmento va a ser el outputeado
            --reg <= shift_right(reg,1);
            an <= "0111";
            seg <= seg3;
            led <= "0001";
            IF(pulse = '1') THEN
            current_state <= two;
            END IF;
            WHEN two =>
            an <= "1011";
            reg <= shift_right(reg,1);
            seg <= seg2;
            led <= "0010";
            IF(pulse = '1') THEN
            current_state <= three;
            END IF;
            WHEN three =>
            an <= "1101";
            reg <= shift_right(reg,1);
            seg <= seg1;
            led <= "0100";
            IF(pulse = '1') THEN
            current_state <= four;
            END IF;
            WHEN four =>
            an <= "1110";
            reg <= shift_right(reg,1);
            seg <= seg0;
            led <= "1000";
            IF(pulse = '1') THEN
            current_state <= one;
            END IF;
            END CASE;
    END PROCESS;
end Behav;