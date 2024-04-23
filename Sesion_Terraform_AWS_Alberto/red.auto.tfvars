ipcidr-redgeeks1 = "10.132.0.0/16" # red privada 1
ipcidr-redgeeks2 = "10.133.0.0/16" # red privada 2

vpc-id-geeks1 = "pepito"
vpc-id-geeks2 = "juanito"

subredes-geeks1 = {
  subred1 = {
    red  = "red-geeks1"
    cidr = "10.132.32.0/24"
    zone = 0
    tag  = "subred-geeks1-servidores-pro"
  },
  subred2 = {
    red  = "red-geeks1"
    cidr = "10.132.33.0/24"
    zone = 0
    tag  = "subred-geeks1-servidores-staging"
  },
  subred3 = {
    red  = "red-geeks1"
    cidr = "10.132.34.0/24"
    zone = 0
    tag  = "subred-geeks1-servidores-test"
  },
}

subredes-geeks2 = {
  subred1 = {
    red  = "red-geeks2"
    cidr = "10.133.32.0/24"
    zone = 0
    tag  = "subred-geeks2-servidores-pro"
  },
  subred2 = {
    red  = "red-geeks2"
    cidr = "10.133.33.0/24"
    zone = 0
    tag  = "subred-geeks2-servidores-staging"
  },
  subred3 = {
    red  = "red-geeks2"
    cidr = "10.133.34.0/24"
    zone = 0
    tag  = "subred-geeks2-servidores-test"
  },
}

subred-publica2-geeks1-cidr = "10.132.41.0/24"
subred-publica-geeks1-cidr  = "10.132.42.0/24"
subred-publica-geeks2-cidr  = "10.133.42.0/24"
