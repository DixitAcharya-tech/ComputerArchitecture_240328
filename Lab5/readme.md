# Lab 5: VHDL Code for Combinational Circuits (2-bit Magnitude Comparator)

## Course Information

* **Course:** Computer Architecture (CMP 262)
* **Program:** Bachelor of Computer Engineering
* **Semester:** Fourth Semester
* **College:** Cosmos College of Management and Technology
* **Department:** Information and Communication Technology

---

# Objective

* To design and simulate a 2-bit Magnitude Comparator in VHDL.
* To understand how comparison operations are implemented in digital hardware.
* To verify the comparator using GHDL and GTKWave.

---

# Introduction

## Magnitude Comparator

A magnitude comparator is a combinational circuit that compares two binary numbers and determines their relationship.

For two binary numbers **A** and **B**, the comparator generates three outputs:

* **EQ (Equal)** → HIGH when **A = B**
* **GT (Greater Than)** → HIGH when **A > B**
* **LT (Less Than)** → HIGH when **A < B**

In this laboratory, a **2-bit Magnitude Comparator** is designed using Behavioral VHDL.

---

# 2-bit Magnitude Comparator

A 2-bit comparator compares two 2-bit binary numbers:

* **A = A1A0**
* **B = B1B0**

The comparator produces:

* **EQ = 1** if A equals B
* **GT = 1** if A is greater than B
* **LT = 1** if A is less than B

---

# Logic Expressions

For a 2-bit comparator:

```
EQ = (A1 XNOR B1) · (A0 XNOR B0)

GT = (A1 · B1') + ((A1 XNOR B1) · A0 · B0')

LT = (A1' · B1) + ((A1 XNOR B1) · A0' · B0)
```

---

# Truth Table

| A | B | EQ | GT | LT |
|---|---|----|----|----|
| 00 | 00 | 1 | 0 | 0 |
| 01 | 00 | 0 | 1 | 0 |
| 00 | 01 | 0 | 0 | 1 |
| 10 | 11 | 0 | 0 | 1 |
| 11 | 10 | 0 | 1 | 0 |
| 11 | 11 | 1 | 0 | 0 |

---

# Libraries Used

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
```

## Description

* `STD_LOGIC_1164` provides the `std_logic` and `std_logic_vector` data types.
* `NUMERIC_STD` provides arithmetic and comparison operations for unsigned and signed data types.

---

# VHDL Code

## File: `comparator_2bit.vhd`

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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

    process(A, B)
    begin

        if unsigned(A) = unsigned(B) then

            EQ <= '1';
            GT <= '0';
            LT <= '0';

        elsif unsigned(A) > unsigned(B) then

            EQ <= '0';
            GT <= '1';
            LT <= '0';

        else

            EQ <= '0';
            GT <= '0';
            LT <= '1';

        end if;

    end process;

end architecture Behavioral;
```

---

# Testbench

## File: `comparator_tb.vhd`

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COMPARATOR_TB is
end entity COMPARATOR_TB;

architecture Simulation of COMPARATOR_TB is

    signal A  : std_logic_vector(1 downto 0) := "00";
    signal B  : std_logic_vector(1 downto 0) := "00";
    signal EQ : std_logic;
    signal GT : std_logic;
    signal LT : std_logic;

begin

    DUT : entity work.COMPARATOR_2BIT
        port map (
            A  => A,
            B  => B,
            EQ => EQ,
            GT => GT,
            LT => LT
        );

    STIMULUS : process
    begin

        A <= "00"; B <= "00";
        wait for 10 ns;

        A <= "01"; B <= "00";
        wait for 10 ns;

        A <= "00"; B <= "01";
        wait for 10 ns;

        A <= "10"; B <= "11";
        wait for 10 ns;

        A <= "11"; B <= "10";
        wait for 10 ns;

        A <= "11"; B <= "11";
        wait for 10 ns;

        wait;

    end process;

end architecture Simulation;
```

---

# GHDL Simulation Commands

```bash
# Compile the comparator and testbench
ghdl -a comparator_2bit.vhd comparator_tb.vhd

# Elaborate the testbench
ghdl -e COMPARATOR_TB

# Run simulation
ghdl -r COMPARATOR_TB --vcd=comparator.vcd

# Open waveform
gtkwave comparator.vcd
```

---

# Simulation Output

| Time | A | B | EQ | GT | LT |
|------|----|----|----|----|----|
| 0 ns | 00 | 00 | 1 | 0 | 0 |
| 10 ns | 01 | 00 | 0 | 1 | 0 |
| 20 ns | 00 | 01 | 0 | 0 | 1 |
| 30 ns | 10 | 11 | 0 | 0 | 1 |
| 40 ns | 11 | 10 | 0 | 1 | 0 |
| 50 ns | 11 | 11 | 1 | 0 | 0 |

---

# Waveform Output

## Comparator Waveform

![Comparator Waveform](comparator.png)

### Result

The waveform confirms that the comparator correctly identifies whether the two 2-bit inputs are equal, greater than, or less than each other. At any given time, only one output (**EQ**, **GT**, or **LT**) becomes HIGH, indicating the correct comparison result.

---

# Tools Used

| Tool | Purpose |
|------|---------|
| **VS Code** | Writing and editing VHDL code |
| **GHDL** | Compiling and simulating VHDL programs |
| **GTKWave** | Viewing waveform output |

---

# Conclusion

In this laboratory exercise, a **2-bit Magnitude Comparator** was successfully designed and simulated using **Behavioral VHDL**. The comparator compares two unsigned 2-bit binary numbers and generates one of three outputs: **EQ**, **GT**, or **LT**, depending on the relationship between the inputs. The design was compiled and simulated using **GHDL**, and the waveform was analyzed using **GTKWave**. The simulation results matched the expected outputs, confirming the correct operation of the comparator circuit.