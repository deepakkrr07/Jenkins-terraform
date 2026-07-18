# Retail Store Deployment on Amazon EKS

## Project Overview

This project demonstrates a complete production-style deployment of a Retail Store microservices application on Amazon EKS using Terraform, Helm, Jenkins, and Karpenter.

---

## Architecture

```
Developer
     │
     ▼
GitHub
     │
     ▼
Jenkins Pipeline
     │
     ├── Build
     ├── Deploy Helm Charts
     ├── Deploy Ingress
     └── Verify Deployment
     │
     ▼
Amazon EKS
     │
     ├── Cart Service
     ├── Catalog Service
     ├── Checkout Service
     ├── Orders Service
     └── UI Service
     │
     ▼
AWS Application Load Balancer
     │
     ▼
Internet
```

---

## Technologies Used

- AWS
- Amazon EKS
- Terraform
- Kubernetes
- Helm
- Jenkins
- Karpenter
- AWS Load Balancer Controller
- Docker
- GitHub

---

## Application Components

- Cart Service
- Catalog Service
- Checkout Service
- Orders Service
- UI Service

---

## Deployment Steps

### 1. Create Namespace

```bash
kubectl apply -f namespace.yaml
```

### 2. Deploy Helm Charts

Jenkins deploys all Helm charts from:

```
charts_v1.0.0
```

or

```
charts_v2.0.0
```

depending on the selected version.

### 3. Deploy Ingress

```bash
kubectl apply -f retail-ingress.yaml
```

### 4. Verify

```bash
kubectl get pods -n retailstore

kubectl get svc -n retailstore

kubectl get ingress -n retailstore
```

---

## Jenkins Pipeline

The Jenkins pipeline performs:

- Workspace Cleanup
- Git Checkout
- Configure kubeconfig
- Deploy Helm Charts
- Deploy Ingress
- Verify Deployment

---

## Autoscaling

Node provisioning is handled automatically by Karpenter.

When application demand increases:

- Pending Pods are detected
- Karpenter provisions new EC2 instances
- Pods are scheduled automatically

---

## Networking

Application traffic flow:

Internet

↓

AWS Application Load Balancer

↓

Kubernetes Ingress

↓

UI Service

↓

Retail Store UI Pod

---

## Monitoring

Useful commands:

```bash
kubectl get pods -n retailstore

kubectl get svc -n retailstore

kubectl get ingress -n retailstore

kubectl get nodes

kubectl get nodepool

kubectl get ec2nodeclass

kubectl get nodeclaims
```

---

## Cleanup

```bash
helm uninstall retail-store-sample-cart-chart -n retailstore

helm uninstall retail-store-sample-catalog-chart -n retailstore

helm uninstall retail-store-sample-checkout-chart -n retailstore

helm uninstall retail-store-sample-orders-chart -n retailstore

helm uninstall retail-store-sample-ui-chart -n retailstore

kubectl delete ingress retail-store-http-ip-mode -n retailstore

kubectl delete namespace retailstore
```

---

## Author

Deepak V

AWS | Kubernetes | Terraform | Jenkins | Helm | Karpenter | DevOps Engineer
