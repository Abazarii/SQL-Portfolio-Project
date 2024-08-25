# SQL Portfolio Projects

Welcome to my SQL portfolio repository! This repository showcases my work on SQL projects, including data cleaning and data exploration tasks. Below you will find a brief overview of the files included in this repository and the SQL techniques utilized.

## Contents

### 1. Data Cleaning - Housing Dataset

- **File Name**: `Data_Cleaning_Housing.sql`
- **Description**: This file contains SQL scripts for cleaning and preprocessing a housing dataset. The tasks performed include:
  - Handling missing values
  - Correcting data types
  - Standardizing data formats
  - Removing duplicates

  The goal is to prepare the dataset for further analysis and ensure data quality.

### 2. Data Exploration - COVID-19 Dataset

- **File Name**: `Data_Exploration_Covid-19.sql`
- **Description**: This file includes SQL queries for exploring and analyzing a COVID-19 dataset with vaccination data. The focus is on:
  - Summarizing key statistics
  - Identifying trends
  - Visualizing important metrics related to COVID-19 and vaccination

  The analysis aims to provide a comprehensive understanding of the COVID-19 impact and vaccination trends.

- **SQL Features Used**:
  - **Common Table Expressions (CTE)**: Used to simplify complex queries and improve readability.
  - **JOINs**: Employed to combine data from multiple tables and perform in-depth analysis.
  - **Aggregation Functions**: Utilized to calculate summary statistics and other metrics.
  - **Filtering and Sorting**: Applied to extract and organize relevant data.
- **Data Story**:
  
    The COVID-19 pandemic has prompted an extensive examination of its impacts through data analysis. By exploring a dataset of COVID-19 deaths and vaccinations, we uncover valuable insights into the pandemic's progression, public health responses, and the disparities in its impact across regions.
  
    Our analysis begins with an overview of the data, providing a broad perspective on the pandemic’s reach. This initial step helps in understanding the overall structure and volume of the dataset.
  
    Focusing on specific metrics, such as location, date, total cases, new cases, total deaths, and population, we refine our view to track trends over time and across different regions. This detailed approach allows us to better understand the progression of COVID-19.
  
    We then calculate mortality rates and infection rates relative to population sizes. This helps assess the severity of the pandemic and how it has spread across various populations. By identifying countries with the highest infection rates and death counts, we highlight the regions most severely affected.
  
    Aggregating global data, we summarize total new cases and deaths, providing an overview of the pandemic’s global impact and death percentage.
  
    Incorporating vaccination data, we track the pace of vaccination efforts and their correlation with COVID-19 case trends. Calculating vaccination coverage percentages reveals the effectiveness of vaccination campaigns in different regions.
  
    Using temporary tables and views enhances our analysis by simplifying complex calculations and making key metrics readily accessible for visualization.
  
    In summary, our data analysis offers a comprehensive view of the COVID-19 pandemic’s impact, the effectiveness of public health responses, and vaccination progress. This approach helps us understand the pandemic’s complexities and informs strategies for future public health challenges.

     Explore the detailed analyses through these interactive Tableau dashboards:

          - [COVID-19 Report Dashboard 1](https://public.tableau.com/views/covid-19_first_report/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
          - [COVID-19 Report Dashboard 2](https://public.tableau.com/views/covid-19_second_report/Dashboard3?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

  

## How to Use

1. **Clone the Repository**

   To clone this repository to your local machine, use the following command:
   ```bash
   git clone https://github.com/yourusername/your-repository.git
