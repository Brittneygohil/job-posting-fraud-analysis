import psycopg2
import pandas as pd
from docutils.nodes import legend
from pandas import pivot

# 1 connection to the DATABASE
conn = psycopg2.connect(
    host="localhost",
    database="JOBPOSTING",
    user="postgres",
    password="bless"
)
query = "SELECT * FROM fake_jobs_clean LIMIT 10;"
df = pd.read_sql(query, conn)
print(df)

query = """
SELECT location,
    COUNT(*) AS total_jobs,
    ROUND(SUM(CASE WHEN fraud =1 THEN 1 ELSE 0 END)*100.0/ COUNT(*),2) AS fake_percentage
    FROM fake_jobs_clean
    GROUP BY location
    HAVING COUNT(*) > 10
    ORDER BY fake_percentage DESC
    LIMIT 15 ;
"""
df = pd.read_sql(query, conn)

import matplotlib.pyplot as plt
import seaborn as sns

plt.figure(figsize=(12,6))
sns.barplot(x='fake_percentage', y='location', data=df, palette='Reds_r')
plt.title('Top 15 Location by Fake Job Percentage')
plt.xlabel('Fake Job Percentage(%)')
plt.ylabel('Location')
plt.tight_layout()
plt.show()

# top 15 industry by fake percentage
query_industry="""
SELECT 
    industry,
    COUNT(*) AS total_jobs,
    ROUND(SUM(CASE WHEN fraud =1 THEN 1 ELSE 0 END)*100.0/ COUNT(*),2) AS fake_percentage
    FROM fake_jobs_clean
    WHERE industry is NOT NULL
    GROUP BY industry
    HAVING COUNT(*) > 10
    ORDER BY fake_percentage DESC
    LIMIT 15 ;
    """

df_industry = pd.read_sql(query_industry, conn)
print(df_industry)
plt.figure(figsize=(12,6))
sns.barplot(
    x='fake_percentage',
    y='industry',
    data=df_industry,
    hue='industry',
    palette='magma',
    legend=False
)
plt.title('Top 15 Industries by Fake Job Percentage')
plt.xlabel('Fake Job Percentage (%)')
plt.ylabel('Industry')
plt.tight_layout()
plt.show()


#department vs function fraud heatmap

query_heatmap="""
SELECT
    department,
    function,
    ROUND(SUM(CASE WHEN fraud =1 THEN 1 ELSE 0 END)*100.0/ COUNT(*),2) AS fake_percentage
    FROM fake_jobs_clean
    WHERE department IS NOT NULL
    AND function IS NOT NULL
    GROUP BY department, function
    HAVING COUNT(*) > 5
    ORDER BY fake_percentage DESC
    """
df_heatmap = pd.read_sql(query_heatmap, conn)
print(df_heatmap.head())

pivot_df = df_heatmap.pivot(index='department', columns='function', values='fake_percentage')
plt.figure(figsize=(14,8))
sns.heatmap(pivot_df, cmap='Reds', annot=True, fmt='.1f')
plt.title('Fraud Percentage by Department and Function')
plt.xlabel('function')
plt.ylabel('department')
plt.tight_layout()
plt.show()