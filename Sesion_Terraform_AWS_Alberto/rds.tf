provider "mysql" {
  alias    = "bd-provider"
  endpoint = aws_db_instance.bd-geeks.endpoint
  username = var.master_username_cluster
  password = var.master_password_cluster
}

data "aws_subnet" "red-rds-geeks" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.red-geeks2.id]
  }

  tags = {
    Name = "subred-geeks2-servidores-pro"
  }
}

resource "aws_db_subnet_group" "rds-geeks-group" {
  name        = "geeks-group"
  description = "Terraform RDS subnet group"
  #subnet_ids  = flatten([aws_subnet.subred-publica-red-geeks2[*].id])
  #subnet_ids = [data.aws_subnet.red-rds-geeks.id]
  subnet_ids = aws_subnet.subnet-privada-k8s-geeks[*].id
  #subnet_ids  = ["${data.aws_subnet.red-rds-geeks.*.id}"]

}

resource "aws_db_parameter_group" "bd-parameters" {
  name   = "bd-parameters"
  family = "mysql5.7"

  parameter {
    name  = "max_connections"
    value = "1000"
  }

  parameter {
    name  = "wait_timeout"
    value = "120"
  }

  parameter {
    name  = "interactive_timeout"
    value = "120"
  }
}

resource "aws_db_instance" "bd-geeks" {
  identifier              = "bd-geeks"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.db_cluster_instance_class
  db_name                 = var.database_cluster_name
  availability_zone       = "${var.region}a"
  username                = var.master_username_cluster
  password                = var.master_password_cluster
  backup_retention_period = var.backup_retention_period
  backup_window           = var.preferred_backup_window
  allocated_storage       = var.allocated_storage_bd
  vpc_security_group_ids  = [aws_security_group.red-geeks2-firewall.id]
  db_subnet_group_name    = aws_db_subnet_group.rds-geeks-group.id
  parameter_group_name    = aws_db_parameter_group.bd-parameters.name
  skip_final_snapshot     = true
}

resource "mysql_user" "user-bd-replicador" {
  provider           = mysql.bd-provider
  host               = aws_db_instance.bd-geeks.address
  user               = "elche"
  plaintext_password = "Vamos-Elche"
}

resource "null_resource" "user-permisos-replica" {
  provisioner "local-exec" {
    command = "mysql -u ${var.master_username_cluster} -p${var.master_password_cluster} -h ${aws_db_instance.bd-geeks.address} -e\"grant all on \\`%\\`.* to 'elche'@'%' identified by 'Vamos-Elche';\""
  }

}
