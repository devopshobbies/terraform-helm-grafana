# resource "helm_release" "grafana" {
#   name       = "grafana"
#   chart      = "grafana/grafana"
#   version    = "6.1.17"
#   namespace  = "monitoring"
#   wait       = "false"
#   depends_on = [null_resource.grafana_community,kubernetes_namespace.prometheus_namespace]

#   values = [<<EOF
# image:
#   tag: 7.3.6
# # nodeSelector:
# #   purpose: monitoring
# # tolerations:
# # - key: "monitoringonly"
# #   operator: "Equal"
# #   value: "true"
# #   effect: "NoSchedule"
# adminPassword: Your_Password
# ingress:
#   enabled: true
#   annotations: 
#     kubernetes.io/ingress.class: traefik
#   hosts: ["example.com"]
# datasources: 
#   datasources.yaml:
#     apiVersion: 1
#     datasources:
#     - name: DEVQA
#       type: prometheus
#       url: http://prometheus-operator-kube-p-prometheus:9090
#       access: proxy
#       isDefault: true
# plugins:
#   - grafana-piechart-panel
# notifiers:
#   notifiers.yaml:
#     notifiers:
#     - name: slack-notifier
#       type: slack
#       uid: slack1
#       is_default: true
#       settings:
#         url: Slack_URL
#         recipient: '#grafana-alerts'
# sidecar:
#   image: 
#     repository: kiwigrid/k8s-sidecar
#     tag: 1.3.0
#   dashboards:
#     enabled: true
#     label: grafana_dashboard
#     folder: /tmp/dashboards
#     defaultFolderName: null
# EOF
#   ]
# }

#cutomize dashboard
# resource "kubernetes_config_map" "volumes-dashboard" {
#   metadata {
#     name = "volumes-dashboard-alerting"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "dashboard.json"   = "${file("${path.module}/grafana-dashboard/volume-alerting.json")}"
#   }
# }

# #other dashboard
# resource "kubernetes_config_map" "node" {
#   metadata {
#     name      = "node"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "node.json" = "${file("${path.module}/grafana-dashboard/node.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "coredns" {
#   metadata {
#     name      = "coredns"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "coredns.json" = "${file("${path.module}/grafana-dashboard/coredns.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "api" {
#   metadata {
#     name      = "api"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "api.json" = "${file("${path.module}/grafana-dashboard/api.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "kubelet" {
#   metadata {
#     name      = "kubelet"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "kubelet.json" = "${file("${path.module}/grafana-dashboard/kubelet.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "proxy" {
#   metadata {
#     name      = "proxy"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "proxy.json" = "${file("${path.module}/grafana-dashboard/proxy.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "statefulsets" {
#   metadata {
#     name      = "statefulsets"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "statefulsets.json" = "${file("${path.module}/grafana-dashboard/statefulsets.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "persistent-volumes" {
#   metadata {
#     name      = "persistent-volumes"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "persistent-volumes.json" = "${file("${path.module}/grafana-dashboard/persistent-volumes.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "prometheous-overview" {
#   metadata {
#     name      = "prometheous-overview"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "prometheous-overview.json" = "${file("${path.module}/grafana-dashboard/prometheous-overview.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "use-method-cluster" {
#   metadata {
#     name      = "use-method-cluster"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "use-method-cluster.json" = "${file("${path.module}/grafana-dashboard/use-method-cluster.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "use-method-node" {
#   metadata {
#     name      = "use-method-node"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "use-method-node.json" = "${file("${path.module}/grafana-dashboard/use-method-node.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# #compute resources dashboard
# resource "kubernetes_config_map" "compute-resources-cluster" {
#   metadata {
#     name      = "compute-resources-cluster"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "compute-resources-cluster.json" = "${file("${path.module}/grafana-dashboard/compute-resources-cluster.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "compute-resources-node-pods" {
#   metadata {
#     name      = "compute-resources-node-pods"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "compute-resources-node-pods.json" = "${file("${path.module}/grafana-dashboard/compute-resources-node-pods.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "compute-resources-pod" {
#   metadata {
#     name      = "compute-resources-pod"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "compute-resources-pod.json" = "${file("${path.module}/grafana-dashboard/compute-resources-pod.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "compute-resources-workload" {
#   metadata {
#     name      = "compute-resources-workload"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "compute-resources-workload.json" = "${file("${path.module}/grafana-dashboard/compute-resources-workload.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "compute-resources-namespace-workloads" {
#   metadata {
#     name      = "compute-resources-namespace-workloads"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "compute-resources-namespace-workloads.json" = "${file("${path.module}/grafana-dashboard/compute-resources-namespace-workloads.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "computer-resources-namespace-pods" {
#   metadata {
#     name      = "computer-resources-namespace-pods"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "computer-resources-namespace-pods.json" = "${file("${path.module}/grafana-dashboard/computer-resources-namespace-pods.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }

# #networking dashboard
# resource "kubernetes_config_map" "networking-namespace-pods" {
#   metadata {
#     name      = "networking-namespace-pods"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "networking-namespace-pods.json" = "${file("${path.module}/grafana-dashboard/networking-namespace-pods.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "networking-namespace-workload" {
#   metadata {
#     name      = "networking-namespace-workload"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "networking-namespace-workload.json" = "${file("${path.module}/grafana-dashboard/networking-namespace-workload.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "networking-cluster" {
#   metadata {
#     name      = "networking-cluster"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "networking-cluster.json" = "${file("${path.module}/grafana-dashboard/networking-cluster.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "networking-pods" {
#   metadata {
#     name      = "networking-pods"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "networking-pods.json" = "${file("${path.module}/grafana-dashboard/networking-pods.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }
# resource "kubernetes_config_map" "networking-workload" {
#   metadata {
#     name      = "networking-workload"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "networking-workload.json" = "${file("${path.module}/grafana-dashboard/networking-workload.json")}"
#   }
#   depends_on = [kubernetes_namespace.prometheus_namespace]
# }

# #Istio dashboard
# resource "kubernetes_config_map" "istio-control-plane" {
#   metadata {
#     name = "istio-control-plane"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "istio-control-plane.json"   = "${file("${path.module}/grafana-dashboard/istio-control-plane.json")}"
#   }
# }
# resource "kubernetes_config_map" "istio-mesh" {
#   metadata {
#     name = "istio-mesh"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "istio-mesh.json"   = "${file("${path.module}/grafana-dashboard/istio-mesh.json")}"
#   }
# }
# resource "kubernetes_config_map" "istio-performance" {
#   metadata {
#     name = "istio-performance"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "istio-performance.json"   = "${file("${path.module}/grafana-dashboard/istio-performance.json")}"
#   }
# }
# resource "kubernetes_config_map" "istio-service" {
#   metadata {
#     name = "istio-service"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "istio-service.json"   = "${file("${path.module}/grafana-dashboard/istio-service.json")}"
#   }
# }
# resource "kubernetes_config_map" "istio-workload" {
#   metadata {
#     name = "istio-workload"
#     namespace = "monitoring"
#     labels = {
#       grafana_dashboard = "dashboard"
#     }
#   }
#   data = {
#     "istio-workload.json"   = "${file("${path.module}/grafana-dashboard/istio-workload.json")}"
#   }
# }
