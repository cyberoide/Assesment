# 1. Install ArgoCD
resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.8"
}

# 2. Secret for Git Credentials
resource "kubernetes_secret" "argocd_git_credentials" {
  metadata {
    name      = "argocd-git-credentials"
    namespace = "argocd"
  }

  data = {
    username = base64encode(var.GIT_USERNAME)  
    password = base64encode(var.GIT_PASSWORD) 
  }
}

# 3. ArgoCD Application: QuoteService
resource "kubernetes_manifest" "quoteservice_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "quoteservice"
      namespace = "argocd"
    }
    spec = {
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "default"
      }
      source = {
        repoURL        = "https://github.com/Muhammad-Awab/Assesment.git"
        targetRevision = "main"
        path           = "helm-charts/quoteservice"
      }
      project = "default"
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
      }
    }
  }
}

# 4. ArgoCD Application: ApiGateway
resource "kubernetes_manifest" "apigateway_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "apigateway"
      namespace = "argocd"
    }
    spec = {
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "default"
      }
      source = {
        repoURL        = "https://github.com/Muhammad-Awab/Assesment.git"
        targetRevision = "main"
        path           = "helm-charts/apigateway"
      }
      project = "default"
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
      }
    }
  }
}

# 5. ArgoCD Application: FrontendApplication
resource "kubernetes_manifest" "frontend_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "frontendapplication"
      namespace = "argocd"
    }
    spec = {
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "default"
      }
      source = {
        repoURL        = "https://github.com/Muhammad-Awab/Assesment.git"
        targetRevision = "main"
        path           = "helm-charts/frontendapplication"
      }
      project = "default"
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
      }
    }
  }
}
