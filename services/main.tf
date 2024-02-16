# Creating namespace resources 
resource "kubernetes_namespace" "monitoring" {
  metadata {
    annotations = {
      name = "monitoring-annotation"
    }

    labels = {
      namespace = "monitoring"
    }

    name = "monitoring"
  }
}

# Creating nginx-ingress resource 
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://charts.helm.sh/stable"
  chart      = "nginx-ingress"
  version    = "1.1.2"

  namespace  = "kube-system"

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
}

# Creating cert-manager resource 
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.8.2"

  namespace = "kube-system"

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "25.11.1"

  namespace  = "monitoring"

  set {
    name  = "server.service.type"
    value = "NodePort"
  }

  set {
    name  = "server.service.nodePort"
    value = "30000"
  }
}

# External-DNS resource.
resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "5.5.1"

  namespace  = "kube-system"

  set {
    name  = "provider"
    value = "google"
  }

  set {
    name  = "google.project"
    value = "var.project_id"
  }

  #set {
    #name  = "google.serviceAccountKey"
    #value = "${file("<PATH_TO_YOUR_GCP_SERVICE_ACCOUNT_KEY_FILE>")}"
  #}

  set {
    name  = "txtOwnerId"
    value = "external-dns"
  }
}