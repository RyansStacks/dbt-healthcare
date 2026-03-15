# \# Patient Definitions

# 

# This document defines how patient attributes are standardized and modeled.

# 

# \## Patient Identity

# \- `patient\_id` is the natural key from the source system.

# \- `patient\_sk` is the surrogate key used throughout the warehouse.

# 

# \## Demographic Attributes

# The following fields are standardized in `int\_patients`:

# \- first\_name  

# \- last\_name  

# \- date\_of\_birth  

# \- gender  

# \- race  

# \- ethnicity  

# 

# \## Slowly Changing Attributes

# Patient demographics are tracked over time using:

# \- `patients\_snapshot` (timestamp strategy)

# 

# This enables historical reporting and accurate point‑in‑time analysis.



