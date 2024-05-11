// deploy app
resource "null_resource" "app_deployment" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../k8s/deploy-app.yaml"
  }
  depends_on = [
    null_resource.grafana_service
  ]
}
# service app
resource "null_resource" "app_service" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../k8s/s-app.yaml"
  }
  depends_on = [
    null_resource.app_deployment
  ]
}
