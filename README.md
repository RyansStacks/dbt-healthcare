# \# Healthcare dbt Project

# 

# This repository contains a complete, production‑ready dbt project designed to model healthcare encounter, patient, diagnosis, and laboratory data. The project follows modern analytics engineering best practices and uses a layered architecture to transform raw clinical data into analytics‑ready fact and dimension tables.

# 

# The goal of this project is to demonstrate a full end‑to‑end dbt implementation, including:

# \- Staging, intermediate, and marts layers

# \- Documentation and testing

# \- Seeds, snapshots, macros, and exposures

# \- CI/CD via GitHub Actions

# \- A Snowflake‑ready configuration

# 

# \---

# 

# \## 📐 Project Architecture

# 

# This dbt project uses a \*\*three‑layer modeling approach\*\*:

# 

# \### 1. \*\*Staging Layer (`models/staging/`)\*\*

# \- Mirrors raw source tables 1:1

# \- Cleans column names and data types

# \- Applies basic standardization

# \- Defines sources in `\_master\_sources.yml`

# 

# \### 2. \*\*Intermediate Layer (`models/intermediate/`)\*\*

# \- Joins staging models across domains

# \- Adds business logic and derived fields

# \- Prepares data for fact/dimension modeling

# 

# \### 3. \*\*Marts Layer (`models/marts/`)\*\*

# \- Contains final fact and dimension tables

# \- Organized by domain (e.g., `clinical`)

# \- Used by BI tools, APIs, and data science

# 

# \---

# 

# \## 🧱 Data Domains Modeled

# 

# This project models the following healthcare entities:

# 

# \- \*\*Patients\*\*

# \- \*\*Encounters\*\*

# \- \*\*Visits\*\*

# \- \*\*Diagnosis\*\*

# \- \*\*Lab Tests\*\*

# \- \*\*Encounter‑level Lab Results\*\*

# \- \*\*Payors\*\*

# \- \*\*Coverage Bridge\*\*

# \- \*\*Dates\*\*

# 

# These are transformed into:

# 

# \### 🔹 Dimensions

# \- `dim\_patients`

# \- `dim\_dates`

# \- `dim\_diagnosis`

# \- `dim\_payors`

# \- `dim\_visits`

# 

# \### 🔹 Facts

# \- `fct\_encounters`

# \- `fct\_lab\_results`

# 

# \---

# 

# \## 🧪 Testing \& Quality

# 

# The project includes:

# 

# \- Schema tests (`unique`, `not\_null`)

# \- Custom SQL tests

# \- Seed‑based validation

# \- Snapshotting for historical tracking

# 

# Tests live in:

# 



