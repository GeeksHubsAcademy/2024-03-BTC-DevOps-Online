entradas-mygeeks1-es = {

  dns1 = { managed_zone = "myredgeeks1.es", name = "web00", type = "A", ttl = "60", rrdatas = "10.132.32.180" }
  dns2 = { managed_zone = "myredgeeks1.es", name = "web", type = "CNAME", ttl = "60", rrdatas = "web00.myredgeeks1.es" }
  dns3 = { managed_zone = "myredgeeks1.es", name = "prueba", type = "A", ttl = "60", rrdatas = "10.132.32.181" }
}
