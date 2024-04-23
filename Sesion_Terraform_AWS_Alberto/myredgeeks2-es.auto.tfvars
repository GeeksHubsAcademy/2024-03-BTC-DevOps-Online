entradas-mygeeks2-es = {

  dns1 = { managed_zone = "myredgeeks2.es", name = "web00", type = "A", ttl = "60", rrdatas = "10.133.32.14" }
  dns2 = { managed_zone = "myredgeeks2.es", name = "web", type = "CNAME", ttl = "60", rrdatas = "web00.myredgeeks2.es" }
  dns3 = { managed_zone = "myredgeeks2.es", name = "prueba", type = "A", ttl = "60", rrdatas = "10.133.32.15" }
}
