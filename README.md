# 🔥 Combustion Chamber Carpet Plot Generator   (MATLAB)

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
   - **`generateCarpetPlotV1.m`**

2. **Open MATLAB**, and in the **Current Folder** panel, navigate to the script directory.  
   Alternatively, set the path manually using the MATLAB toolbar.

3. In the **Command Window**, run:
   ```matlab
   >> generateCarpetPlot
4. When prompted, enter the desired input ranges:
   ```matlab
   === Combustion Chamber Carpet Plot Generator ===
   Enter minimum O/F ratio: (input here)
   Enter maximum O/F ratio: (input here)
   Enter O/F increment: (input here)
   Enter minimum chamber pressure (psi): (input here)
   Enter maximum chamber pressure (psi): (input here)
   Enter Pc increment (psi): (input here)
5. Select your Excel data file when the file dialog appears (Excel format sample file "ExcelTemplate" provided in main repository page).
   Below is an example of the excel file template requested by the generator:

   ![Sample Excel Template](CarpetPlotData.png)
   
7. The program will:
   - Read the performance data
   - Detect Isp and Tc columns automatically
   - Plot Isp vs Tc curves for all chamber pressures
   - Connect points of equal O/F to form the carpet pattern
8. View and save the results:
   - The plot appears automatically
   - You can export or save it using MATLAB’s built-in save tools
   Below is an example of the excel file template requested by the generator:

   ![Sample Carpet Plot](CarpetPlot.png)
