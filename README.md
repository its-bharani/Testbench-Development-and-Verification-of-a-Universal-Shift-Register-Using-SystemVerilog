# Testbench-Development-and-Verification-of-a-Universal-Shift-Register-Using-SystemVerilog

## Introduction

This project aims to design and **functionally verify a Universal Shift Register (USR)** using **SystemVerilog**. The USR is a versatile sequential circuit that can perform multiple data operations like shifting and parallel loading. It is a core component in many digital systems including processors, communication interfaces, and memory buffers.

The verification is done using a **modular testbench architecture** built from scratch, applying SystemVerilog constructs such as classes, mailboxes, and virtual interfaces. The design was simulated using **QuestaSim**, and functional as well as code coverage were analyzed to ensure correctness.

---

## Operation of the Universal Shift Register

The **4-bit Universal Shift Register** performs the following operations based on control inputs `s1` and `s0`:

| `s1` | `s0` | Operation       | Description                         |
|------|------|----------------|-------------------------------------|
| 0    | 0    | Hold           | Retains the current value           |
| 0    | 1    | Shift Right    | Shifts bits to the right            |
| 1    | 0    | Shift Left     | Shifts bits to the left             |
| 1    | 1    | Parallel Load  | Loads new 4-bit input simultaneously|


## Testbench Environment

The verification environment is **layered and object-oriented**, built entirely in **SystemVerilog (without UVM libraries)**. It uses **mailboxes for inter-component communication** and **virtual interfaces** to drive and monitor the DUT.

### Components Overview

- **Transaction Class**  
  Encapsulates all DUT input fields: `in`, `s1`, `s0`, `MSB_in`, `LSB_in`(with distribution)  
  Includes constraints to generate valid randomized stimuli for all control operations.

- **Generator**  
  Creates randomized transactions and sends them to the driver using a mailbox(gen2dr).  
  Ensures that each operation mode (Hold, Shift Left, Shift Right, Load) is adequately tested.

- **Driver**  
  Drives inputs to the DUT through a virtual interface.  
  Receives transactions from the generator via a mailbox(gen2dr).

- **Write Monitor**  
  Monitors the inputs applied to the DUT.  
  Captures and sends this data to the reference model via mailbox(mon2rm).

- **Read Monitor**  
  Continuously observes the DUT output.  
  Forwards the captured output to the scoreboard using a mailbox(mon2sb).

- **Reference Model**  
  Implements the expected behavior of the Universal Shift Register.  
  Receives input data from the write monitor(mon2rm) and generates the expected output.

- **Scoreboard**  
  Compares the actual DUT output (from read monitor(data2sb)) and the expected output (from reference model(ref2sb)).  
  Reports a pass/fail status based on whether outputs match.

- **Environment**  
  Instantiates and connects all above components.  
  Acts as the top-level container for the verification components.

- **Test Class**  
  Extends the environment class.  
  Calls `build() and `run() methods to initialize and start simulation.

- **Top Module (`top.sv`)**  
  - Instantiates the DUT and interface.  
  - Connects the virtual interface to driver and monitors.  
  - Generates clock and reset.  
  - Includes all required packages and testbench files.
   

 
  ## Results

-  All four operations (**Hold**, **Shift Left**, **Shift Right**, **Parallel Load**) were verified successfully.
  
-  The design was exercised with **randomized input combinations** to ensure wide functional coverage.
  
- **Waveform simulations** in *QuestaSim* confirmed correct behavior of each operation mode.
  
- **Code Coverage Report** from *QuestaSim* showed:

  
![image](https://github.com/user-attachments/assets/cc0d16a9-82e3-4b08-9179-c554836a643c)


![image](https://github.com/user-attachments/assets/ac4cc536-a37b-424f-b836-af1bbe8313a2)


![image](https://github.com/user-attachments/assets/0c244116-6c9e-4ee7-9132-ee5a8c6cb3dc)


## Conclusion

This project demonstrated a **complete end-to-end verification flow** for a **4-bit Universal Shift Register** using **SystemVerilog**.

The testbench effectively verified all operational modes under **constrained random scenarios**, validating the **functional correctness** of the design.

The verification process achieved **90+ code coverage** and produced **traceable, reproducible results**, ensuring the reliability and robustness of the shift register module.
