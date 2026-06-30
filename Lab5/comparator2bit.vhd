library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COMPARATOR_2BIT is
    port (
        A  : in  std_logic_vector(1 downto 0);
        B  : in  std_logic_vector(1 downto 0);
        EQ : out std_logic;
        GT : out std_logic;
        LT : out std_logic
    );
end entity COMPARATOR_2BIT;

architecture Behavioral of COMPARATOR_2BIT is
begin

    -- EQ = (A1 XNOR B1) · (A0 XNOR B0)
    EQ <= (A(1) xnor B(1)) and (A(0) xnor B(0));

    -- GT = A1·B1' + (A1 XNOR B1) · A0·B0'
    GT <= (A(1) and (not B(1))) or
          ((A(1) xnor B(1)) and A(0) and (not B(0)));

    -- LT = A1'·B1 + (A1 XNOR B1) · A0'·B0
    LT <= ((not A(1)) and B(1)) or
          ((A(1) xnor B(1)) and (not A(0)) and B(0));

end architecture Behavioral;