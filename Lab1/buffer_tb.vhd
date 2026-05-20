LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Testbench has NO ports
ENTITY BUFFER_TB IS
END ENTITY BUFFER_TB;

ARCHITECTURE Simulation OF BUFFER_TB IS

    -- Signals to connect to the DUT
    SIGNAL tb_A : STD_LOGIC := '0';
    SIGNAL tb_Y : STD_LOGIC;

BEGIN

    -- Instantiate (connect) the Design Under Test (DUT)
    DUT : ENTITY work.MY_BUFFER
        PORT MAP(
            A => tb_A,
            Y => tb_Y
        );

    -- Stimulus process: toggle the input
    STIMULUS : PROCESS
    BEGIN
        tb_A <= '0';
        WAIT FOR 10 ns; -- Y should follow: '0'

        tb_A <= '1';
        WAIT FOR 10 ns; -- Y should follow: '1'

        tb_A <= '0';
        WAIT FOR 10 ns; -- Y should follow: '0'

        WAIT; -- End simulation
    END PROCESS STIMULUS;

END ARCHITECTURE Simulation;