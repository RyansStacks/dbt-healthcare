# \# Metrics Overview

# 

# This document summarizes the key clinical and operational metrics produced in the marts layer.

# 

# \## Encounter Metrics

# \- \*\*Length of Stay (LOS)\*\*  

# &#x20; Derived in hours and days using admission and discharge timestamps.

# 

# \- \*\*Visit Count\*\*  

# &#x20; Number of visits associated with an encounter.

# 

# \- \*\*Primary Diagnosis Flag\*\*  

# &#x20; Indicates whether an encounter has a primary diagnosis.

# 

# \- \*\*Abnormal Lab Flag\*\*  

# &#x20; Indicates whether any lab results were abnormal.

# 

# \## Lab Metrics

# \- \*\*Normalized Result Value\*\*  

# &#x20; Scales lab results to a 0–1 range based on reference ranges.

# 

# \- \*\*Abnormal Rate\*\*  

# &#x20; Calculated daily per LOINC code in `agg\_lab\_abnormal\_rates`.

# 

# \## Readmission Metrics

# \- \*\*30‑Day Readmission Flag\*\*  

# &#x20; Identifies whether a patient was readmitted within 30 days of discharge.

# 

# These metrics support operational reporting, quality improvement, and clinical analytics.



