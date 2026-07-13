# Exercise 1-5: Anomaly Insights and Advanced Predictions

<!-- ============================================================ -->

## Overview

In this exercise, you use Oracle EPM Cloud Insights to identify anomalies, explore root causes, generate AI-driven narrative summaries, and review Advanced Predictions for performance analysis.

<!-- ============================================================ -->

## Objective

By the end of this exercise, you will be able to:

- Navigate to IPM Insights data.
- Review revenue performance across regions.
- Filter and open anomaly insights.
- Review AI-generated explanations and summaries.
- Explore Advanced Predictions, explainability, feature importance, prediction results, and forecast value-add analysis.

<!-- ============================================================ -->

## Prerequisites

Log in to Oracle EPM Cloud with the credentials provided by the instructor.

```text
User ID: Provided on your card
Password: Provided at the front of the room
```

![Oracle EPM Cloud login](assets/images/exercise-1-5-step-01.png)

<!-- ============================================================ -->

## Steps

### Step 1: Open Insights Data

After period data is finalized, Kerry begins the performance review process. Insights provide action items and support collaboration across stakeholders.

1. Click **IPM**.
2. Click **Insights Data**.

![Open IPM Insights Data](assets/images/exercise-1-5-step-02.png)

<!-- ============================================================ -->

### Step 2: Review regional revenue performance

The dashboard highlights revenue performance across regions and major product lines. Revenue for Sales US East appears to increase, while Sales US West declines. This requires further investigation using Insights.

1. On the line graph, click the drop-down titled **Total Sales Regions**.
2. Select **Sales US - West** and review.
3. Select **Sales US - East** and review.
4. Click the **Insights** tab on the horizontal bar above the dashboard.

![Regional revenue dashboard](assets/images/exercise-1-5-step-03.png)

<!-- ============================================================ -->

### Step 3: Review the Insights dashboard

The Insights dashboard brings together curated AI-generated insights for business users. Priority can be configured as high, medium, or low. The dashboard shows dollar and percentage variances, data intersections, variance type, explanation, status, and creation date.

This exercise focuses on the **Anomaly** type.

1. Scroll down to review the list of Insights.
2. Read several rows of Insights.

![Insights dashboard](assets/images/exercise-1-5-step-04.png)

<!-- ============================================================ -->

### Step 4: Filter for the Sales US East insight

Kerry wants to identify the factors behind strong Sales East performance. Filter the insights to review the anomaly generated for the relevant Sales US East data.

1. In the search box, type:

```text
Equipment and Fleet
```

2. Select:

```text
Sales US - East - Equipment and Fleet
```

![Filter Insights for Equipment and Fleet](assets/images/exercise-1-5-step-05.png)

<!-- ============================================================ -->

### Step 5: Open the insight details

The model generated an anomaly for Sales US East. The anomaly appears at the total level for a portfolio that includes multiple product lines.

1. Click the **Details** link to open the selected Insight.

![Open Insight details](assets/images/exercise-1-5-step-06.png)

<!-- ============================================================ -->

### Step 6: Review anomaly explanation

On the chart, the orange line represents actual revenue. The system automatically detects an unusual revenue spike. It identifies true anomalies that deviate from expected patterns, rather than ordinary seasonal spikes.

1. Hover over the data point represented as a star at the far-right side of the line graph.
2. Click the icon at the top-right of the line graph to open the explanations panel.
3. Review the **Insights AI** tab, which contains an AI-generated narrative explanation of the anomaly.

![Anomaly explanation panel](assets/images/exercise-1-5-step-07.png)

<!-- ============================================================ -->

### Step 7: Review AI-generated summaries

Kerry uses GenAI to summarize which products and lines drove the unusual performance. The summary explains how individual entity and product-level performance contributed to the overall anomaly. It can be used in reports or presentations with relevant data points.

1. Click the **Summary** tab at the bottom-left of the screen to see a list of summaries.
2. After review, close the summary text by clicking **X**.

![AI-generated summary panel](assets/images/exercise-1-5-step-08.png)

<!-- ============================================================ -->

### Step 8: Open the first summary

The summary explains why sales surged and lets AI determine the cause of the anomaly without manual analysis, spreadsheet building, or data exports.

1. Select the first summary in the list.

![Select first summary](assets/images/exercise-1-5-step-09.png)

<!-- ============================================================ -->

### Step 9: Open Advanced Predictions

Advanced Predictions helps planners create stronger forecasts using machine learning and business drivers such as price, marketing spend, industry volume, and economic trends. It explains the forecast, shows accuracy, and identifies the most impactful drivers.

1. Click the **Advanced Predictions** tab at the top of the screen.

![Advanced Predictions tab](assets/images/exercise-1-5-step-10.png)

<!-- ============================================================ -->

### Step 10: Review driver inputs

Review product-level driver inputs such as marketing spend, industry volume, selling price, discounts, and macroeconomic variables. The drop-down allows the user to switch between drivers and understand which data feeds the prediction.

1. Select the drop-down.
2. Click **Marketing Spend**.

![Marketing Spend driver input](assets/images/exercise-1-5-step-11.png)

<!-- ============================================================ -->

### Step 11: Open Sales Volume Prediction Output

Select the drivers that influence sales volume. Advanced Predictions uses these inputs to build a stronger forecast.

1. Click **Sales Volume Prediction Output** in the bottom-left corner.

![Sales Volume Prediction Output tab](assets/images/exercise-1-5-step-12.png)

<!-- ============================================================ -->

### Step 12: Explain a prediction

Analyze monthly sales volume prediction output by product. Forecasted volumes are shown across products such as Site Mobilization, Earthwork, Underground Utilities, and others.

1. Right-click the first column under **Dec**.
2. Select **Explain Predictions**.

![Explain Predictions menu](assets/images/exercise-1-5-step-13.png)

<!-- ============================================================ -->

### Step 13: Open Feature Importance

The explainability panel shows the prediction trend, forecast range, and prediction details. It includes accuracy, error measure, algorithm used, and forecast period.

1. Click the **Feature Importance** tab.

![Prediction explainability panel](assets/images/exercise-1-5-step-14.png)

<!-- ============================================================ -->

### Step 14: Review key prediction drivers

The explainability view ranks the drivers that influenced the prediction, including marketing spend, supply chain status, economic indicators, and other drivers.

Advanced Predictions provides both a forecast number and the business drivers behind it.

1. Click the **Prediction Results** tab in the bottom-left corner.

![Feature Importance tab](assets/images/exercise-1-5-step-15.png)

<!-- ============================================================ -->

### Step 15: Review prediction results

Prediction Results includes actuals, forecasts, product drivers, and a sales volume mix chart by quarter. This view connects forecast output to supporting driver details.

1. Select the **FVA Analysis** tab at the bottom.

![Prediction Results dashboard](assets/images/exercise-1-5-step-16.png)

<!-- ============================================================ -->

### Step 16: Review FVA Analysis and sign out

FVA Analysis compares forecast accuracy across methods, including Trend Method, Driver Method, Predictive Planning, and Advanced Predictions. The charts and tables show where Advanced Predictions improves accuracy and adds value.

1. Click the user name in the top-right corner.
2. Select **Sign out**.

![FVA Analysis and sign out](assets/images/exercise-1-5-step-17.png)

<!-- ============================================================ -->

## Expected Result

You have used Insights to investigate an anomaly, reviewed AI-generated explanations and summaries, and explored Advanced Predictions and FVA Analysis to understand forecast drivers and value add.

<!-- ============================================================ -->

## Summary

Insights and Advanced Predictions help business users identify anomalies, explain root causes, collaborate with AI-generated summaries, and create stronger forecasts using transparent model drivers.
