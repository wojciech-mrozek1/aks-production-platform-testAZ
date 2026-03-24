# 🚀 Azure Private AKS Platform

### Terraform • Kubernetes • PostgreSQL • Key Vault • GitHub Actions

![Azure](https://img.shields.io/badge/Azure-Cloud-blue?logo=microsoft-azure)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform)
![Kubernetes](https://img.shields.io/badge/Kubernetes-AKS-326CE5?logo=kubernetes)
![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-2088FF?logo=github-actions)
![Security](https://img.shields.io/badge/Security-Private%20Architecture-green)

---

## 📌 Overview

This project demonstrates how to build a **secure, private cloud platform on Microsoft Azure** using Infrastructure as Code and modern DevOps practices.

The goal is to simulate a **production-like environment** with:

* 🔐 private networking (no public exposure)
* ⚙️ automated infrastructure provisioning
* 🔑 secure secret management
* ☸️ Kubernetes-based workloads
* 🔄 CI/CD for infrastructure

---

## 🏗️ Architecture

```text
                (NO PUBLIC ACCESS)

        ┌─────────────────────────────┐
        │      AKS (Private)          │
        │   Application workloads     │
        └────────────┬────────────────┘
                     │
                     ▼
        ┌─────────────────────────────┐
        │ PostgreSQL Flexible Server  │
        │       (Private)             │
        └─────────────────────────────┘

        ┌─────────────────────────────┐
        │ Azure Key Vault             │
        │ Secrets (DB password etc.)  │
        └─────────────────────────────┘

        ┌─────────────────────────────┐
        │ Azure Container Registry    │
        └─────────────────────────────┘

        ┌─────────────────────────────┐
        │ Log Analytics               │
        └─────────────────────────────┘

        VNet: 10.10.0.0/16
```

---

## 🔐 Security First Approach

This project is built with **security as a primary concern**:

* ✅ AKS deployed as **private cluster**
* ✅ PostgreSQL deployed in **private subnet**
* ✅ No public database exposure
* ✅ Secrets stored in **Azure Key Vault**
* ✅ No secrets in Git repository
* ✅ RBAC-based access control
* ✅ Infrastructure isolated inside VNet

---

## 🌐 Networking

| Component         | Value                           |
| ----------------- | ------------------------------- |
| VNet              | `10.10.0.0/16`                  |
| AKS Subnet        | `10.10.1.0/24`                  |
| PostgreSQL Subnet | `10.10.2.0/24`                  |
| Private DNS       | `*.postgres.database.azure.com` |

---

## 📦 Infrastructure (Terraform)

All infrastructure is defined and managed via **Terraform**.

### Key features:

* Remote state (Azure Storage)
* Repeatable deployments
* Environment-driven configuration
* Clean separation of resources

### Resources created:

* Resource Group
* Virtual Network + subnets
* AKS (private cluster)
* PostgreSQL Flexible Server
* Azure Container Registry (ACR)
* Log Analytics Workspace
* Private DNS zones

---

## 🔑 Secrets Management

Secrets are securely stored in:

👉 **Azure Key Vault**

Example:

* `postgres-admin-password`

Secrets are:

* ❌ not committed to Git
* ❌ not stored in Terraform variables
* ✅ injected at runtime via CI/CD

---

## 🔄 CI/CD (GitHub Actions)

Infrastructure is validated using GitHub Actions.

### Pipeline flow:

```text
1. Azure Login (Service Principal)
2. Fetch secret from Key Vault
3. Terraform init
4. Terraform validate
5. Terraform plan
```

---

## 📁 Repository Structure

```text
.
├── infra/                      # Terraform configuration
├── .github/workflows/          # CI/CD pipelines
│   └── infra-plan.yml
└── README.md
```

---

## ⚙️ Required Configuration

### GitHub Secrets

| Name                  | Description              |
| --------------------- | ------------------------ |
| AZURE_CLIENT_ID       | Service Principal ID     |
| AZURE_CLIENT_SECRET   | Service Principal secret |
| AZURE_TENANT_ID       | Azure tenant             |
| AZURE_SUBSCRIPTION_ID | Target subscription      |

---

## 🚀 How to Use

### 1. Clone repository

```bash
git clone <repo>
cd test
```

### 2. Initialize Terraform

```bash
cd infra
terraform init
```

### 3. Validate configuration

```bash
terraform validate
```

### 4. Plan infrastructure

```bash
terraform plan
```

### 5. Apply (optional)

```bash
terraform apply
```

---

## 💰 Cost Control

⚠️ This project provisions real cloud resources.

To avoid charges:

```bash
terraform destroy
```

---

## 🧠 Key Concepts

* Private cloud architecture
* Infrastructure as Code (Terraform)
* Azure networking (VNet, subnets, DNS)
* Secure secret management (Key Vault)
* RBAC & identity management
* Kubernetes platform design
* CI/CD automation

---

## 🚧 Roadmap

* [ ] Deploy application to AKS
* [ ] Connect app to PostgreSQL
* [ ] Add internal ingress
* [ ] Introduce Helm charts
* [ ] Monitoring & logging improvements

---

## 📌 Why this project?

Built as a **hands-on DevOps & Cloud Engineering project** to:

* transition from AWS to Azure
* learn secure cloud architecture
* implement production-like patterns
* build a portfolio-ready platform

---

## 👨‍💻 Author

Cloud / DevOps learning project
focused on real-world architecture and best practices
