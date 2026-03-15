# Contributing Guidelines

Thank you for your interest in contributing to the **Healthcare dbt Project**.  
This project follows modern analytics engineering best practices, including:

- Git‑based development workflows  
- Pull request reviews  
- Automated CI/CD using GitHub Actions  
- dbt testing, documentation, and code quality standards  
- A layered modeling architecture (staging → intermediate → marts)

These guidelines ensure consistency, reliability, and maintainability across the project.

---

## 🧩 Branching Strategy

We use a lightweight, industry‑standard Git workflow:

### **`main`**
- Always production‑ready  
- Protected branch  
- Only updated via PR from `develop`  
- Mirrors production Snowflake schema  

### **`develop`**
- Integration branch for upcoming releases  
- Feature branches merge here first  
- CI must pass before merging  

### **`feature/<short-description>`**
- Short‑lived branches for individual changes  
- Examples:
  - `feature/add-lab-results-fact`
  - `feature/refactor-patient-dim`
  - `feature/update-diagnosis-staging`

---

## 🔄 Pull Request Process

1. **Create a feature branch** from `develop`:
   ```bash
   git checkout develop
   git checkout -b feature/<description>
