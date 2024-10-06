# apb-verification-uvm
This project focuses on the Verification of Advanced Peripheral Bus (APB) protocol using the Universal Verification Methodology (UVM).
## APB Block Diagram
![APB block diagram](https://github.com/user-attachments/assets/2abd1a3f-ce54-4cb9-8b39-3a1e9b9817ce)

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
![New board - Page 1 (2)](https://github.com/user-attachments/assets/fc539f29-8eaf-496f-b97d-13bb8e050097)

## Coverage Results

- **Functional Coverage**:
![image](https://github.com/user-attachments/assets/70092332-fd7b-4eda-b5ea-ab44bb0e4fe2)

- **Code Coverage**  :
![image](https://github.com/user-attachments/assets/08c2c73f-32ff-4a7c-bcf5-2988d1b56d04)
