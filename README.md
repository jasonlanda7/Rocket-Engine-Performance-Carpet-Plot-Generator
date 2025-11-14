# 🔥 Combustion Chamber Carpet Plot Generator (MATLAB)

### Author: Jason Da Silva  
**Credits:** Developed as part of the Propulsion Analysis Toolkit (2025)

---

## 🧠 Overview

This MATLAB program generates a **Carpet Plot** of **Specific Impulse (Isp)** versus **Chamber Temperature (Tc)** for varying **oxidizer-to-fuel ratios (O/F)** and **chamber pressures (Pc)**.  
It provides a visual representation of how combustion performance changes across different engine conditions — a key step in **liquid rocket engine performance analysis**.

The program reads performance data from a structured **Excel file** containing Isp and Tc values and automatically constructs a **clean, annotated carpet plot** for analysis or reporting.

---

## ✨ Features

- Reads **Isp** and **Tc** data directly from Excel files  
- Automatically detects:
  - Chamber pressure values from column headers (e.g., `ISP_300psi`, `Tc_300psi`)
  - Isp and Tc data columns  
- Plots **Isp vs Tc** for multiple chamber pressures  
- Connects **constant O/F ratio** lines across pressures  
- Annotates O/F lines for visual clarity  
- Produces clean MATLAB figures ready for **research papers or reports**

---

## 📂 Files

| File | Description |
|------|--------------|
| **`generateCarpetPlot.m`** | Core MATLAB function that reads data and generates the carpet plot |
| **`example_data.xlsx`** | Example Excel file containing O/F, Isp, and Tc data (user-provided) |
| **`output/carpet_plot.png`** | Example output plot (optional, generated after running script) |

---

## 🖥️ Usage Instructions

To run the Combustion Chamber Carpet Plot Generator:

1. **Ensure the following file is in your MATLAB working directory:**
   - **`generateCarpetPlot.m`**

2. **Open MATLAB**, and in the **Current Folder** panel, navigate to the script directory.  
   Alternatively, set the path manually using the MATLAB toolbar.

3. In the **Command Window**, run:
   ```matlab
   >> generateCarpetPlot
