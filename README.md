# apb-verification-uvm
This project focuses on the Verification of Advanced Peripheral Bus (APB) protocol using the Universal Verification Methodology (UVM).
## APB Block Diagram

![APB block diagram](https://github.com/user-attachments/assets/758c616e-ad9e-40eb-8e34-e84de77229c1)

## APB Interface Signals

| **Signal Name**     | **Direction** | **Width** | **Description**                                   |
|---------------------|---------------|-----------|---------------------------------------------------|
| `PCLK`              | Input         | 1-bit     | Clock signal                                      |
| `PRESETn`           | Input         | 1-bit     | Active-low reset signal                           |
| `PADDR`             | Input         | 32-bit    | Address signal                                    |
| `PSELx`             | Input         | 1-bit     | Select signal for the slave device                |
| `PENABLE`           | Input         | 1-bit     | Indicates second and subsequent cycles of an APB transfer |
| `PWRITE`            | Input         | 1-bit     |  Indicates an APB write access when HIGH and an APB read access when LOW    |
| `PWDATA`            | Input         | 32-bit    | Data to be written to the selected address        |
| `PREADY`            | Output        | 1-bit     | Indicates the slave is ready to complete the data transfer |
| `PRDATA`            | Output        | 32-bit    | Data read from the selected address               |
| `PSLVERR`           | Output        | 1-bit     | Indicates a slave error                           |


## UVM Testbench Architecture
![New board - Page 1 (2)](https://github.com/user-attachments/assets/0d365400-323a-4dbe-a317-975286cfa32e)

## Coverage Results
- **Functional Coverage**:
- ![funcovapb](https://github.com/user-attachments/assets/55159333-1b66-468f-b3f7-351e649c346e)
- **Code Coverage**  :
- ![codecovapb](https://github.com/user-attachments/assets/64f8efb2-ee65-4186-904e-b32eb763d6da)

