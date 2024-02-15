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