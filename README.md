# **Project Documentation **

## **Overview**

This repository contains the infrastructure and configurations for deploying a set of microservices-based applications using **Terraform**, **ArgoCD**, and **Helm charts**. The application includes the following components:
- **QuoteService**: A backend service for handling quotes.
- **ApiGateway**: A gateway to manage API requests.
- **FrontendApplication**: The frontend application for user interaction.
- **ArgoCD**: Used for continuous deployment and managing application lifecycles.

### **Components Deployed**

1. **ArgoCD**:
   - ArgoCD is deployed using Helm charts and is configured to handle the lifecycle management of the microservices (QuoteService, ApiGateway, and FrontendApplication).
   - It is set up to synchronize the applications and continuously deploy the latest changes from the Git repository.
   
2. **QuoteService**:
   - A backend service that is exposed as a Kubernetes service.
   - Deployed through ArgoCD from a GitHub repository using Helm charts.
   
3. **ApiGateway**:
   - Serves as the entry point for managing and routing API requests to backend services.
   - Also deployed and managed through ArgoCD.
   
4. **FrontendApplication**:
   - A frontend application that communicates with the backend services via the API Gateway.
   - Deployed using ArgoCD from a Helm chart.

---

## **Deployment Instructions**

### **Pre-requisites**

1. **Install Terraform**:
   Follow the instructions in the [Terraform documentation](https://www.terraform.io/docs) to install Terraform on your local machine.

2. **Install Helm**:
   Helm is used to deploy applications in Kubernetes. You can install it by following the instructions in the [Helm documentation](https://helm.sh/docs/intro/install/).

3. **Install kubectl**:
   kubectl is used for interacting with the Kubernetes cluster. Follow the instructions in the [Kubernetes documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl/) to install kubectl.

4. **Install ArgoCD CLI**:
   Install the ArgoCD CLI to interact with the ArgoCD instance. Follow the instructions here: [ArgoCD CLI installation](https://argoproj.github.io/argo-cd/cli_installation/).

### **Steps to Deploy the Application**

1. **Clone the Repository**:
   Clone this repository to your local machine:
   ```bash
   git clone https://github.com/Muhammad-Awab/Assesment.git
   cd Assesment/infrastructure

2. **Configure AWS Credentials (For EKS)**:
Set up your AWS CLI and configure your AWS credentials. Make sure you have the proper permissions to create the EKS cluster:
    ```bash
    aws configure
    ```
3. **Initialize Terraform**:
Initialize Terraform to download the necessary providers and set up the configuration:
    ```bash
    terraform init
    ```
4. **Plan the Terraform Deployment**:
Review the resources that Terraform will create before applying:
    ```bash
    terraform plan
    ```
5. **Apply the Terraform Configuration**:
Apply the Terraform configuration to provision the infrastructure:
    ```bash
    terraform apply
    ```
6. **ArgoCD Setup**:
Once Terraform has successfully applied, ArgoCD will be installed in your Kubernetes cluster. You can access the ArgoCD UI by following these steps:

    Get the ArgoCD password:
    ```bash
    kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 --decode
    ```
    Access ArgoCD UI:
    Forward the ArgoCD port to access the UI locally:
    ```bash
    kubectl port-forward svc/argocd-server -n argocd 8080:80
    ```
Now, you can access ArgoCD on http://localhost:8080 using the username admin and the password obtained above.

7. **Sync Applications in ArgoCD**:

    Login to ArgoCD.
    
    Navigate to the Applications tab and sync the following applications:
       QuoteService
       ApiGateway
       FrontendApplication

    This will trigger the deployment process, and ArgoCD will manage the deployment of these applications in the Kubernetes cluster.

8. **Access the Application**:
After ArgoCD completes the deployment, the applications will be running on your Kubernetes cluster. You can access the services depending on your cluster’s setup.

    For example, for services with type ClusterIP, you can access them via port forwarding:
        ```bash
        kubectl port-forward svc/quoteservice 5000:5000 -n default
        ```
    QuoteService: http://localhost:5000
    
    FrontendApplication: http://localhost:80

**Auto-Sync Configuration**
ArgoCD is configured for auto-sync, meaning any changes pushed to the Git repository will automatically trigger ArgoCD to synchronize and deploy the changes to the Kubernetes cluster.





