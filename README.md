# international-education-costs
Full-stack data analysis using Excel, SQL, Python, R, and Power BI

# 🌍 International Education Cost Analysis

A full-stack data analytics project exploring the cost of higher education across 70+ countries. This project integrates tools like **Excel**, **Python**, **R**, **SQL (MySQL)**, and **Power BI** to deliver powerful insights into international education affordability.

---

## 📁 Dataset Overview

The dataset includes key features for evaluating total education cost by university and country:

| Column            | Description                              |
|-------------------|------------------------------------------|
| `Country`         | Country offering the program             |
| `City`            | City of the university                   |
| `University`      | Name of the institution                  |
| `Program`         | Degree/program name                      |
| `Level`           | Bachelor, Master, or PhD                 |
| `Duration_years`  | Program duration                         |
| `Tuition`         | Tuition fee in USD                       |
| `Living Cost Index` | Cost of living index in city           |
| `Rent`            | Monthly rent cost in USD                 |
| `Visa Fee`        | One-time visa application fee            |
| `Insurance`       | Estimated insurance cost                 |
| `Exchange Rate`   | Rate for converting to local currency    |
| `Total Cost`      | Total estimated cost (Tuition + Rent + Fees)

---

## 🧰 Tools & Technologies Used

| Tool         | Purpose                                           |
|--------------|---------------------------------------------------|
| **Excel**    | Data exploration, pivot tables, charts            |
| **Python**   | Exploratory Data Analysis, visualization, insights |
| **R**        | Statistical summary and ggplot2-based visuals     |
| **SQL (MySQL)** | Schema design, queries, views, analysis       |
| **Power BI** | Interactive dashboard with KPIs and filters       |
| **GitHub**   | Project version control and collaboration         |

---

## 📌 Business Questions Answered

✅ Which countries and universities are the most/least affordable?  
✅ Which programs have the highest average tuition or rent?  
✅ What’s the average cost by level (Bachelor, Master, PhD)?  
✅ Which cities offer low-cost, high-value education?  
✅ What is the country-wise total cost distribution?

---

## 🗂️ Project Folder Structure

international-education-costs/
│
├── data/
│ └── data_iec.xlsx # Dataset
│
├── sql/
│ ├── schema.sql # SQL table creation (with PK, FK)
│ ├── queries.sql # Select, aggregate, join queries
│ └── views.sql # Country-wise views
│
├── python/
│ └──  iec_py.py # EDA, KMeans clustering by cost
│
├── r/
│ ├── iec_code.R # Summary statistics and visualizations
│ └── shiny app_iec.R
│
├── powerbi/
│ ├── dashboard_ice.pbix # Final dashboard file
│ └── screenshots/
│ ├── screenshot_dashboard1.png
│ ├── screenshot_dashboard2.png
│ ├── screenshot_dashboard3.png
│ ├── screenshot_dashboard4.png
│ ├── screenshot_dashboard5.png
│ └── screenshot_dashboard6.png
│
└── README.md # This file

---


## 📊 Power BI Dashboard Highlights

- **Slicers**: Country, Level, Program
- **KPIs**: 
  - Most Expensive/Least Expensive Country
  - Average Tuition and Rent by Level
  - Total Cost by Program
- **Visuals**:
  - Bar Charts for Tuition, Rent, Total Cost
  - Pie Chart for Level Distribution
  - Count of Programs per Country

📸 See screenshots in `/powerbi/screenshots`.

---

## 📌 SQL Database Design

- **Tables**: `education_costs`, `countries`, `universities`, `programs`
- **Relationships**:
  - `universities.country_id → countries.id`
  - `education_costs.university_id → universities.id`
- Used **PRIMARY KEY** and **FOREIGN KEY** constraints.
- Views include:
  - `avg_cost_by_country`
  - `top5_affordable_universities`

---

## 🔍 Python Insights

- Libraries used: `pandas`, `matplotlib`, `seaborn`, `plotly`
- Key visuals:
  - Boxplot: Tuition across countries
  - Heatmap: Correlation between cost factors
  - Distribution plots for rent and visa

---

## 📈 R Visualizations

- Used `ggplot2` for:
  - Country-wise tuition comparison
  - Level-wise cost distribution
- Summary stats generated for:
  - Mean, median, IQR, variance

---

## 🎯 Summary

📚 This project demonstrates:
- End-to-end data handling and reporting
- Integration of multiple tools for a real-world data scenario
- Analytical thinking and dashboard design for decision-making

---

## ✅ How to Run

1. Clone the repo  
   `git clone https://github.com/Jem1917/international-education-costs.git`

2. Use files in:
   - `/python/` to run Python EDA
   - `/sql/` to set up MySQL schema and queries
   - `/r/` to view R visuals
   - `/powerbi/` to open `.pbix` file for dashboard

---

## 📄 License

MIT License

---

## 🙌 Connect

Feel free to reach out or ⭐ star the repo if you find it helpful!

