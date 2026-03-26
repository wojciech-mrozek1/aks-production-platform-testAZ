# 🚀 Production-Style AKS Platform with Monitoring & Stateful Workloads

This project demonstrates a **production-style Kubernetes platform** built on **Azure Kubernetes Service (AKS)**.

It focuses on **platform engineering practices**, including infrastructure design, workload isolation, deployment automation, and observability — rather than application complexity.

---

## 🧱 Architecture Diagram

### High-Level Architecture

```text
                    ┌─────────────────────────────┐
                    │        GitHub Actions       │
                    │      (CI/CD Pipeline)       │
                    └────────────┬────────────────┘
                                 │
                                 ▼
                    ┌─────────────────────────────┐
                    │ Azure Container Registry    │
                    │           (ACR)             │
                    └────────────┬────────────────┘
                                 │
                                 ▼
                    ┌─────────────────────────────┐
                    │ Azure Kubernetes Service    │
                    │       (Private AKS)         │
                    └────────────┬────────────────┘
                                 │
        ┌───────────────┬────────┼───────────┬───────────────┐
        ▼               ▼        ▼           ▼               ▼
   ┌────────┐     ┌────────┐ ┌────────┐ ┌────────┐     ┌────────┐
   │ system │     │ apppool│ │ dbpool │ │ monpool│     │ Azure  │
   │ nodes  │     │ (app)  │ │ (DB)   │ │monitor │     │ Disk   │
   └────────┘     └────────┘ └────────┘ └────────┘     └────────┘
                         │           │          │
                         ▼           ▼          ▼
                    ┌────────┐  ┌────────┐ ┌─────────────┐
                    │  App   │  │Postgres│ │ Prometheus  │
                    │        │  │Stateful│ │ Grafana     │
                    └────────┘  └────────┘ │ Alertmanager│
                                           └─────────────┘
```

---

## 🧠 Node Pool Strategy

| Pool    | Purpose                         |
| ------- | ------------------------------- |
| system  | Kubernetes core components      |
| apppool | Application workloads           |
| dbpool  | PostgreSQL (stateful workloads) |
| monpool | Monitoring stack                |

Isolation enforced via:

* `nodeSelector`
* `taints & tolerations`

---

## ☁️ Infrastructure (Terraform)

### Provisioned Resources

* Azure Kubernetes Service (private cluster)
* Azure Container Registry (ACR)
* Log Analytics Workspace
* Multiple node pools:
  * system
  * apppool
  * dbpool
  * monpool

### Key Features

* Private API endpoint
* RBAC enabled
* Azure CNI networking
* Autoscaling node pools
* Managed identities

---

## 🔒 Private Cluster Access

The AKS cluster is **private** and does not expose a public API endpoint.

All operations and deployments are executed via:

```bash
az aks command invoke
```

This allows secure interaction with the cluster without exposing it publicly.

---

## 🔄 CI/CD Pipeline (GitHub Actions)

### 🏗️ Build Stage

Builds Docker image using:

```bash
az acr build
```

### 🔁 Immutable Deployments

Application is deployed using **commit-based image tags (SHA)** instead of `latest`.

This ensures:

* deterministic deployments
* traceability between code and running version
* reproducibility of environments

Flow:

```
git push → build image (ACR) → tag = commit SHA → deploy to AKS
```

### 🚀 Deploy Stage

* Uses Kustomize
* Applies manifests via:

```bash
az aks command invoke
```

### ✅ Verification

* rollout status
* pod health checks

---

## 🐳 Application Layer

* Node.js application (sample workload)
* Kubernetes Deployment
* ClusterIP Service
* ConfigMap + Secret

### Health Probes

* readiness
* liveness

### Resource Management

* CPU / Memory limits enforced

---

## 🗄️ PostgreSQL (Stateful Workload)

* Deployed as StatefulSet
* Persistent storage via PVC (Azure Disk)

### Storage Architecture

```text
Postgres Pod
     │
     ▼
PersistentVolumeClaim (PVC)
     │
     ▼
PersistentVolume (PV)
     │
     ▼
Azure Managed Disk
```

### ✅ Persistence Validation

* ✔ Data inserted
* ✔ Pod restarted
* ✔ Data still present

---

## 📊 Observability Stack

Installed via Helm:

* Prometheus
* Grafana
* Alertmanager
* kube-state-metrics
* node-exporter

### PostgreSQL Monitoring

* postgres-exporter deployed
* metrics scraped by Prometheus
* custom Grafana dashboard created

---

## 📸 Screenshots

### 🧠 Workload Distribution
![Pods](./docs/images/pods.png)

### 🖥️ Node Pools
![Nodes](./docs/images/nodes.png)

### 📦 Persistent Storage
![PVC](./docs/images/pvc.png)

### 📊 PostgreSQL Monitoring
![Grafana PostgreSQL](./docs/images/grafana-postgres.png)

### 📈 Kubernetes Cluster Monitoring
![Grafana Cluster](./docs/images/grafana-cluster.png)

### 🧩 Node Monitoring
![Grafana Node](./docs/images/grafana-node.png)

---

## 🔐 Security

* Private AKS cluster (no public API)
* Grafana exposed temporarily for testing and reverted to ClusterIP
* Secrets are NOT stored in the repository
* Secrets are injected dynamically via GitHub Actions
* Kubernetes Secrets created during deployment
* RBAC enabled

---

## 🧠 Key Concepts Demonstrated

* Kubernetes workload isolation
* Stateful workloads in AKS
* Infrastructure as Code (Terraform)
* CI/CD pipelines (GitHub Actions)
* Immutable deployments (SHA-based)
* Observability (Prometheus + Grafana)
* Secure cluster architecture

---

## 🧪 Validation

* ✔ Application deployed and running
* ✔ PostgreSQL persistence verified
* ✔ Prometheus collecting metrics
* ✔ Grafana dashboards populated

---

## 🏁 Summary

This project simulates a real-world production environment, including:

* isolated workloads
* persistent database layer
* monitoring & alerting
* automated deployment pipelines
* secure private cluster operations

---

## 🚀 Future Improvements

* Azure Key Vault + External Secrets
* GitOps (ArgoCD)
* Ingress with TLS termination
* PostgreSQL automated backups
* Advanced alerting and SLOs