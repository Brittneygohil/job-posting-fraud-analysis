# 🕵️‍♀️ Job Posting Fraud Analysis (SQL + Python Project)

This project explores a dataset of job postings to uncover fraudulent patterns using **Power Query**, **PostgreSQL (SQL)**, and **Python**.  
The goal is to detect fake job listings by analyzing trends across **location**, **industry**, **department**, and **function**, and visualizing fraud hotspots effectively.

🔗 **GitHub Repository:** [https://github.com/Brittneygohil/job-posting-fraud-analysis](https://github.com/Brittneygohil/job-posting-fraud-analysis)

---

## 📌 Project Workflow

1. 🧼 **Data Cleaning**
   - Cleaned the raw dataset using Power Query.  
   - Removed unnecessary columns (`company_profile`, `description`), fixed header mismatches, formatted salary ranges, and handled missing values.

2. 🗂 **SQL Import & Analysis**
   - Created PostgreSQL schema and imported the cleaned dataset.  
   - Ran SQL queries to analyze fraud distribution by:
     - 🌍 **Location**
     - 🏭 **Industry**
     - 🧠 **Department & Function**
     - 🎓 **Education**

3. 📊 **Visualization in Python**
   - Connected to PostgreSQL using Python.  
   - Queried aggregated results into Pandas DataFrames.  
   - Built visualizations (bar charts & heatmaps) using Matplotlib & Seaborn.

---

## 🛠 Tools & Technologies

- **Power Query** – Data cleaning & preprocessing  
- **PostgreSQL (SQL)** – Data storage & analysis  
- **Python** – Querying & Visualization  
  - `pandas`  
  - `matplotlib`  
  - `seaborn`  
- **Git & GitHub** – Version control & portfolio hosting

---

## 📈 Key Visualizations & Insights

### 📍 Top 15 Locations by Fake Job Percentage  
*Highlights regions with the highest share of fake job postings.*  
![Top Locations](top%2015%20location%20by%20fake%20job%20percentage.png)

---

### 🏭 Top 15 Industries by Fake Job Percentage  
*Comparison of industries most targeted by scammers.*  
![Top Industries](top%2015%20industry%20by%20fake%20job%20percentage.png)

---

### 🧠 Department vs Function Fraud Heatmap  
*Shows department–function combinations with the highest fraud concentration.*  
![Heatmap](fraud%20percentage%20by%20department%20and%20function.png)

---

## 💡 Key Findings

- 🏘 **Real Estate** had the highest fraud rate (~71%) in this dataset.  
- 🧠 Certain **department–function combinations** were repeatedly targeted by scammers.  
- 🌐 Some industries like **Internet/IT** had 0% fraud in this sample.  
- 📊 Fraudulent listings often had vague job descriptions and fewer education requirements.

---

## 🔮 Future Improvements

- 📊 Build an **interactive dashboard** using Power BI or Streamlit.  
- 🤖 Train a **machine learning model** to predict fake job postings.  
- ⚡ Automate the ETL pipeline for continuous fraud monitoring.  
- 📝 Add text-based features like word count, suspicious phrases, or URL checks.

---

## 📝 How to Reproduce

1. Clone this repository  
   ```bash
   git clone https://github.com/Brittneygohil/job-posting-fraud-analysis.git
