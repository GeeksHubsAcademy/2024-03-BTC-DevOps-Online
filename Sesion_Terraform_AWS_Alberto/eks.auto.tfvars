eks-redes-geeks            = ["10.133.128.0/20", "10.133.144.0/20"]
service-cidr-eks-geeks     = "172.16.64.0/23"
eks-subredes-privada-geeks = "10.133.128.0/20"
eks-subredes-publica-geeks = "10.133.144.0/20"
eks-zone-geeks             = ["eu-west-3a", "eu-west-3b"]
count-eks-zones-geeks      = 2

eks-cidr-access-geeks         = ["0.0.0.0/0"]
desire-size-eks-geeks-ingress = "1"
max-size-eks-geeks-ingress    = "2"
min-size-eks-geeks-ingress    = "1"
disk-size-eks-geeks           = "25"
type-eks-geeks-ingress        = ["t3a.medium"]
eks-version-geeks             = "1.28"

desire-size-eks-geeks-nodes = "1"
max-size-eks-geeks-nodes    = "2"
min-size-eks-geeks-nodes    = "1"
type-eks-geeks-nodes        = ["t3a.medium"]
