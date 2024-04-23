locals {
  ingress-geeks = {
    for rule in keys(var.reglasBal-geeks-ingress) :
    rule => lookup(var.reglasBal-geeks-ingress, rule)
  }
}

locals {
  egress-geeks = {
    for rule in keys(var.reglasBal-geeks-egress) :
    rule => lookup(var.reglasBal-geeks-egress, rule)
  }
}

resource "aws_subnet" "subred-publica2-red-geeks1" {
  vpc_id                  = aws_vpc.red-geeks1.id
  cidr_block              = var.subred-publica2-geeks1-cidr
  availability_zone       = data.aws_availability_zones.available-zones.names[1]
  map_public_ip_on_launch = true # ip publica
  tags = {
    Name = "subred-red-geeks1-publica2"
    Tipo = "publica"
  }
}

resource "aws_route_table_association" "tabla-rutas-geeks1-subred-publica2" {
  subnet_id      = aws_subnet.subred-publica2-red-geeks1.id
  route_table_id = aws_route_table.routing-red-geeks1-publica.id
}

resource "aws_security_group" "balanceador-firewall" {
  name        = "balanceador-firewall"
  description = "trafico permitido balanceador"
  vpc_id      = aws_vpc.red-geeks1.id

  dynamic "ingress" {
    for_each = local.ingress-geeks
    content {
      from_port   = lookup(ingress.value, "from_port", null)
      to_port     = lookup(ingress.value, "to_port", null)
      protocol    = lookup(ingress.value, "protocol", null)
      cidr_blocks = lookup(ingress.value, "cidr", null)
      description = lookup(ingress.value, "description", null)
    }
  }

  dynamic "egress" {
    for_each = local.egress-geeks
    content {
      from_port   = lookup(egress.value, "from_port", null)
      to_port     = lookup(egress.value, "to_port", null)
      protocol    = lookup(egress.value, "protocol", null)
      cidr_blocks = lookup(egress.value, "cidr", null)
      description = lookup(egress.value, "description", null)
    }
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_alb" "balanceador-geeks" {
  name            = "balanceador-geeks"
  security_groups = ["${aws_security_group.balanceador-firewall.id}"]
  subnets         = flatten([aws_subnet.subred-publica-red-geeks1[*].id, aws_subnet.subred-publica2-red-geeks1[*].id])

  enable_cross_zone_load_balancing = true
  desync_mitigation_mode           = "monitor"

  tags = {
    Name = "balanceador-geeks"
  }
}

resource "aws_alb_target_group" "balanceador-geeks-target-group1" {
  name     = "balanceador-geeks-target-group1"
  port     = var.target_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.red-geeks1.id

  #stickiness {
  #       type            = "lb_cookie"
  #       cookie_duration = 1800
  #       enabled         = "${var.target_group_sticky}"
  #}

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
    protocol            = var.target_protocol
    path                = "/"
    port                = var.target_port
    matcher             = "200-499"
  }
}

resource "aws_alb_target_group" "balanceador-geeks-target-group2" {
  name     = "balanceador-geeks-target-group2"
  port     = var.target_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.red-geeks1.id

  #stickiness {
  #       type            = "lb_cookie"
  #       cookie_duration = 1800
  #       enabled         = "${var.target_group_sticky}"
  #}

  deregistration_delay = 60

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    #timeout = var.timeout
    interval = var.interval
    protocol = var.target_protocol
    path     = "/"
    port     = var.target_port
    matcher  = "200-499"
  }
}


resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_alb.balanceador-geeks.arn
  port              = var.target_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.balanceador-geeks-target-group1.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "paths-group1" {
  count    = length(var.paths-group1)
  priority = count.index + 1

  listener_arn = aws_alb_listener.listener_http.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.balanceador-geeks-target-group1.arn
  }

  condition {
    host_header {
      values = [element(var.paths-group1, count.index)]
    }
  }
}


resource "aws_lb_listener_rule" "paths-group2" {
  count    = length(var.paths-group2)
  priority = count.index + 100 # peso 100 por detras anteriores

  listener_arn = aws_alb_listener.listener_http.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.balanceador-geeks-target-group2.arn
  }

  condition {
    host_header {
      values = [element(var.paths-group2, count.index)]
    }
  }
}

resource "aws_lb_target_group_attachment" "attached-balanceador-group1" {
  target_group_arn = aws_alb_target_group.balanceador-geeks-target-group1.arn
  target_id        = aws_instance.servidor-web-geeks1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attached-balanceador-group2" {
  target_group_arn = aws_alb_target_group.balanceador-geeks-target-group2.arn
  target_id        = aws_instance.servidor-web-geeks1.id
  port             = 80
}
