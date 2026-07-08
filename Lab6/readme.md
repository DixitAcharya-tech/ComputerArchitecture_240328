# Lab 6: VHDL Code for Combinational Circuits (Code Converter)

## Course Information

* **Course:** Computer Architecture (CMP 262)
* **Program:** Bachelor of Computer Engineering
* **Semester:** Fourth Semester
* **College:** Cosmos College of Management and Technology
* **Department:** Information and Communication Technology

---

# Objective

* To design and simulate a **BCD-to-Excess-3 Code Converter** in VHDL.
* To design and simulate a **Binary-to-Gray Code Converter** in VHDL.
* To understand the implementation of code conversion using combinational circuits.
* To verify the converters using **GHDL** and **GTKWave**.

---

# Introduction

## Code Converter

A code converter is a combinational logic circuit that converts data from one binary code to another without changing its numerical value.

In this laboratory, two different code converters are implemented:

* **BCD-to-Excess-3 Converter**
* **Binary-to-Gray Code Converter**

These converters are commonly used in digital systems, communication devices, arithmetic circuits, and error reduction applications.

---

# BCD to Excess-3 Code Converter

## Theory

Excess-3 (XS-3) is a **non-weighted binary coded decimal (BCD)** code obtained by adding **3 (0011)** to each BCD digit.

It is a **self-complementing code**, making it useful in decimal arithmetic and digital systems.

### BCD to Excess-3 Conversion Table

| Decimal | BCD (DCBA) | Excess-3 (WXYZ) |
|---------|------------|-----------------|
| 0 | 0000 | 0011 |
| 1 | 0001 | 0100 |
| 2 | 0010 | 0101 |
| 3 | 0011 | 0110 |
| 4 | 0100 | 0111 |
| 5 | 0101 | 1000 |
| 6 | 0110 | 1001 |
| 7 | 0111 | 1010 |
| 8 | 1000 | 1011 |
| 9 | 1001 | 1100 |

---

# Binary to Gray Code Converter

## Theory

Gray code is a binary numbering system in which **only one bit changes between consecutive values**.

Gray code is widely used in:

* Rotary encoders
* Digital communication
* Error minimization
* Position sensors

### Gray Code Conversion Rule

```
G3 = B3

G2 = B3 XOR B2

G1 = B2 XOR B1

G0 = B1 XOR B0
```

where **B** represents the binary input and **G** represents the Gray code output.

---

# Libraries Used

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
```

## Description

* `STD_LOGIC_1164` provides the `std_logic` and `std_logic_vector` data types.
* `NUMERIC_STD` provides arithmetic operations for unsigned binary values.

---

# VHDL Code

## File: `bcd_to_xs3.vhd`

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCD_TO_XS3 is
    port (
        BCD : in std_logic_vector(3 downto 0);
        XS3 : out std_logic_vector(3 downto 0)
    );
end entity BCD_TO_XS3;

architecture Behavioral of BCD_TO_XS3 is
begin

    process(BCD)
    begin
        -- Add 3 to the BCD input
        XS3 <= std_logic_vector(unsigned(BCD) + 3);
    end process;

end architecture Behavioral;
```

---

# Testbench

## File: `bcd_xs3_tb.vhd`

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_XS3_TB is
end entity BCD_XS3_TB;

architecture Simulation of BCD_XS3_TB is

    signal BCD : std_logic_vector(3 downto 0) := "0000";
    signal XS3 : std_logic_vector(3 downto 0);

begin

    DUT : entity work.BCD_TO_XS3
        port map(
            BCD => BCD,
            XS3 => XS3
        );

    STIMULUS : process
    begin

        BCD <= "0000";
        wait for 10 ns;

        BCD <= "0001";
        wait for 10 ns;

        BCD <= "0101";
        wait for 10 ns;

        BCD <= "1001";
        wait for 10 ns;

        wait;

    end process;

end architecture Simulation;
```

---

# VHDL Code

## File: `bin_to_gray.vhd`

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BIN_TO_GRAY is
    port (
        B : in std_logic_vector(3 downto 0);
        G : out std_logic_vector(3 downto 0)
    );
end entity BIN_TO_GRAY;

architecture Dataflow of BIN_TO_GRAY is
begin

    G(3) <= B(3);
    G(2) <= B(3) xor B(2);
    G(1) <= B(2) xor B(1);
    G(0) <= B(1) xor B(0);

end architecture Dataflow;
```

---

# Testbench

## File: `gray_tb.vhd`

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GRAY_TB is
end entity GRAY_TB;

architecture Simulation of GRAY_TB is

    signal B : std_logic_vector(3 downto 0) := "0000";
    signal G : std_logic_vector(3 downto 0);

begin

    DUT : entity work.BIN_TO_GRAY
        port map(
            B => B,
            G => G
        );

    STIMULUS : process
    begin

        B <= "0000";
        wait for 10 ns;

        B <= "0001";
        wait for 10 ns;

        B <= "0010";
        wait for 10 ns;

        B <= "0011";
        wait for 10 ns;

        B <= "0100";
        wait for 10 ns;

        B <= "1111";
        wait for 10 ns;

        wait;

    end process;

end architecture Simulation;
```

---

# GHDL Simulation Commands

## BCD to Excess-3 Converter

```bash
# Compile
ghdl -a bcd_to_xs3.vhd bcd_xs3_tb.vhd

# Elaborate
ghdl -e BCD_XS3_TB

# Run simulation
ghdl -r BCD_XS3_TB --vcd=bcd_xs3.vcd

# View waveform
gtkwave bcd_xs3.vcd
```

---

## Binary to Gray Converter

```bash
# Compile
ghdl -a bin_to_gray.vhd gray_tb.vhd

# Elaborate
ghdl -e GRAY_TB

# Run simulation
ghdl -r GRAY_TB --vcd=gray.vcd

# View waveform
gtkwave gray.vcd
```

---

# Simulation Output

## BCD to Excess-3 Converter

| Time | BCD | XS-3 |
|------|------|------|
| 0 ns | 0000 | 0011 |
| 10 ns | 0001 | 0100 |
| 20 ns | 0101 | 1000 |
| 30 ns | 1001 | 1100 |

---

## Binary to Gray Converter

| Time | Binary | Gray |
|------|--------|------|
| 0 ns | 0000 | 0000 |
| 10 ns | 0001 | 0001 |
| 20 ns | 0010 | 0011 |
| 30 ns | 0011 | 0010 |
| 40 ns | 0100 | 0110 |
| 50 ns | 1111 | 1000 |

---

# Waveform Output

## BCD to Excess-3 Waveform

![BCD to Excess-3 Waveform](bcd_xs3.png)

### Result

The waveform confirms that each valid BCD digit is correctly converted into its corresponding Excess-3 code by adding binary 3 to the input value.

---

## Binary to Gray Waveform

![Binary to Gray Waveform](gray.png)

### Result

The waveform verifies that the Binary-to-Gray converter correctly generates Gray code, where only one bit changes between consecutive values.

---

# Tools Used

| Tool | Purpose |
|------|---------|
| **VS Code** | Writing and editing VHDL code |
| **GHDL** | Compiling and simulating VHDL programs |
| **GTKWave** | Viewing waveform output |

---

# Conclusion

In this laboratory exercise, two combinational code converters were successfully designed and simulated using **Behavioral VHDL** and **Dataflow VHDL**. The **BCD-to-Excess-3 Converter** correctly transformed valid BCD inputs into their corresponding Excess-3 codes by adding binary 3, while the **Binary-to-Gray Converter** generated Gray codes using XOR operations according to the standard conversion rules. Both designs were compiled and simulated using **GHDL**, and their waveforms were analyzed using **GTKWave**. The simulation results matched the expected outputs, confirming the correct functionality of both code converter circuits.