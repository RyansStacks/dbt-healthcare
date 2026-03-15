# \# Encounter Logic Overview

# 

# This document describes how encounters are modeled across the staging, intermediate, and marts layers.

# 

# \## Key Concepts

# 

# \### Encounter Identity

# \- `encounter\_id` is the natural key.

# \- `encounter\_sk` is the surrogate key generated in the intermediate layer.

# 

# \### Core Logic

# \- Admission and discharge timestamps are standardized in `int\_encounters`.

# \- Length of stay (LOS) is calculated in `int\_encounter\_timelines`.

# \- Visit rollups (first/last visit, visit count) are created in `int\_visit\_rollups`.

# 

# \### Marts Layer

# `fct\_encounters` combines:

# \- encounter attributes  

# \- LOS metrics  

# \- visit rollups  

# \- diagnosis flags  

# \- lab flags  

# 

# This produces a wide, analytics‑ready encounter fact table.



