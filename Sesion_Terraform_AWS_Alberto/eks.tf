resource "aws_iam_role" "eks-master-geeks" {
  name = "eks-master-geeks"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "master-geeks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-master-geeks.name
}

resource "aws_iam_role_policy_attachment" "master-geeks-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks-master-geeks.name
}

resource "aws_iam_role_policy_attachment" "master-geeks-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-master-geeks.name
}

resource "aws_iam_role_policy_attachment" "master-geeks-AmazonEKSClusterPolicyScaler" {
  policy_arn = "arn:aws:iam::519393677523:policy/AmazonEKSClusterAutoscalerPolicy"
  role       = aws_iam_role.eks-master-geeks.name
}

resource "aws_iam_role" "nodes-geeks" {
  name = "nodes-geeks"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "autoscaler-policy-geeks" {
  name   = "autoscaler-policy-geeks"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeTags",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "nodes-geeks-AmazonEKSClusterNodePolicy" { #
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.nodes-geeks.name
}

resource "aws_iam_role_policy_attachment" "nodes-geeks-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.nodes-geeks.name
}

resource "aws_iam_role_policy_attachment" "nodes-geeks-AmazonEKSServicePolicy" { #
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.nodes-geeks.name
}

resource "aws_iam_role_policy_attachment" "nodes-geeks-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes-geeks.name
}

resource "aws_iam_role_policy_attachment" "nodes-geeks-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes-geeks.name
}

resource "aws_iam_role_policy_attachment" "nodes-geeks-AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.nodes-geeks.name
}

resource "aws_iam_role_policy_attachment" "nodes-geeks-AmazonEC2ContainerRegistryReadOnly" { #
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes-geeks.name
}

resource "aws_iam_role_policy_attachment" "nodes-geeks-x-ray" {
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
  role       = aws_iam_role.nodes-geeks.name
}
resource "aws_iam_role_policy_attachment" "nodes-geeks-s3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.nodes-geeks.name
}

resource "aws_iam_role_policy_attachment" "nodes-geeks-autoscaler" {
  policy_arn = aws_iam_policy.autoscaler-policy-geeks.arn
  role       = aws_iam_role.nodes-geeks.name
}

resource "aws_iam_role_policy_attachment" "nodes-geeks-AmazonEC2ContainerScalerPolicy" {
  policy_arn = "arn:aws:iam::519393677523:policy/AmazonEKSClusterAutoscalerPolicy"
  role       = aws_iam_role.nodes-geeks.name
}


resource "aws_iam_instance_profile" "nodes-geeks" {
  depends_on = [aws_iam_role.nodes-geeks]
  name       = "nodes-geeks-new-profile"
  role       = aws_iam_role.nodes-geeks.name
}

resource "aws_security_group" "reglas-fw-eks-cluster-geeks" {
  name   = "reglas-fw-eks-cluster-geeks"
  vpc_id = aws_vpc.red-geeks2.id
  # Outbound Rule
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  # Inbound Rule
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_subnet" "subnet-publica-k8s-geeks" {
  count             = var.count-eks-zones-geeks
  vpc_id            = aws_vpc.red-geeks2.id
  cidr_block        = cidrsubnet(var.eks-subredes-publica-geeks, 1, count.index)
  availability_zone = var.eks-zone-geeks[count.index]

  private_dns_hostname_type_on_launch = "ip-name"

  tags = {
    "Name"                                    = "publica-eks-geek-${var.region}"
    "Tipo"                                    = "eks"
    "kubernetes.io/role/elb"                  = 1
    "kubernetes.io/cluster/eks-cluster-geeks" = "owned"
  }
}

resource "aws_subnet" "subnet-privada-k8s-geeks" {
  count             = var.count-eks-zones-geeks
  vpc_id            = aws_vpc.red-geeks2.id
  cidr_block        = cidrsubnet(var.eks-subredes-privada-geeks, 1, count.index)
  availability_zone = var.eks-zone-geeks[count.index]

  private_dns_hostname_type_on_launch = "ip-name"

  tags = {
    "Name"                                    = "private-eks-geek-${var.region}"
    "Tipo"                                    = "eks"
    "kubernetes.io/role/internal-elb"         = 1
    "kubernetes.io/cluster/eks-cluster-geeks" = "owned"
  }
}

resource "aws_route_table_association" "tabla-rutas-eks-privada-geeks2" {
  count          = var.count-eks-zones-geeks
  subnet_id      = aws_subnet.subnet-privada-k8s-geeks[count.index].id
  route_table_id = aws_route_table.routing-red-geeks2-privada.id
}

resource "aws_route_table_association" "tabla-rutas-eks-publica-geeks2" {
  count          = var.count-eks-zones-geeks
  subnet_id      = aws_subnet.subnet-publica-k8s-geeks[count.index].id
  route_table_id = aws_route_table.routing-red-geeks2-publica.id
}


resource "aws_eks_cluster" "eks-cluster-geeks" {
  name     = "eks-cluster-geeks"
  role_arn = aws_iam_role.eks-master-geeks.arn
  version  = var.eks-version-geeks

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids              = flatten([aws_subnet.subnet-publica-k8s-geeks[*].id, aws_subnet.subnet-privada-k8s-geeks[*].id])
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = var.eks-cidr-access-geeks
    security_group_ids      = ["${aws_security_group.reglas-fw-eks-cluster-geeks.id}"]
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.service-cidr-eks-geeks
  }

  timeouts {
    delete = "15m"
  }
  tags = {
    Name         = "Pro"
    Environtment = "eks-cluster-geeks"
  }

  depends_on = [
    aws_iam_role_policy_attachment.master-geeks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.master-geeks-AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.master-geeks-AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_node_group" "eks-cluster-geeks-ingress" {
  cluster_name    = aws_eks_cluster.eks-cluster-geeks.name
  node_group_name = "cluster-eks-geeks-nodes-ingress"
  node_role_arn   = aws_iam_role.nodes-geeks.arn
  subnet_ids      = aws_subnet.subnet-privada-k8s-geeks[*].id
  version         = var.eks-version-geeks

  tags = {
    Name         = "Pro"
    Environtment = "eks-cluster-geeks-ingress"
  }

  labels = {
    "env"         = "pro"
    "cpd"         = "aws"
    "node-system" = "true"
  }

  taint {
    key    = "node-system"
    value  = "true"
    effect = "NO_SCHEDULE"
  }
  scaling_config {
    desired_size = var.desire-size-eks-geeks-ingress
    max_size     = var.max-size-eks-geeks-ingress
    min_size     = var.min-size-eks-geeks-ingress
  }

  ami_type = "AL2_x86_64"
  #ami_type       = "AL2_ARM_64"
  #capacity_type  = "SPOT"
  capacity_type  = "ON_DEMAND"
  instance_types = var.type-eks-geeks-ingress

  lifecycle {
    create_before_destroy = true
  }

  launch_template {
    id      = aws_launch_template.s3-paquetes-geeks.id
    version = aws_launch_template.s3-paquetes-geeks.latest_version
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEKSClusterNodePolicy,
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEKSVPCResourceController,
  ]

}

resource "aws_eks_node_group" "eks-cluster-geeks-nodes" {
  cluster_name    = aws_eks_cluster.eks-cluster-geeks.name
  node_group_name = "eks-cluster-geeks-nodes"
  node_role_arn   = aws_iam_role.nodes-geeks.arn
  subnet_ids      = aws_subnet.subnet-privada-k8s-geeks[*].id
  version         = var.eks-version-geeks

  tags = {
    Name         = "Pro"
    Environtment = "eks-cluster-geeks-nodes"
  }

  labels = {
    "env"     = "pro"
    "cpd"     = "aws"
    "project" = "true"
  }

  scaling_config {
    desired_size = var.desire-size-eks-geeks-nodes
    max_size     = var.max-size-eks-geeks-nodes
    min_size     = var.min-size-eks-geeks-nodes
  }
  ami_type = "AL2_x86_64"
  #ami_type       = "AL2_ARM_64"
  #capacity_type  = "SPOT"
  capacity_type  = "ON_DEMAND"
  instance_types = var.type-eks-geeks-nodes

  lifecycle {
    #create_before_destroy   = true
    ignore_changes = [scaling_config[0].desired_size]
  }

  launch_template {
    id      = aws_launch_template.s3-paquetes-geeks.id
    version = aws_launch_template.s3-paquetes-geeks.latest_version
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEKSClusterNodePolicy,
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.nodes-geeks-AmazonEKSVPCResourceController,
    #aws_iam_role_policy_attachment.nodes-geeks-AmazonEC2ContainerScalerPolicy
  ]
}


resource "aws_launch_template" "s3-paquetes-geeks" {

  name = "geeks-web-plantilla"
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.disk-size-eks-geeks
    }
  }

  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.reglas-fw-eks-cluster-geeks.id]
  #user_data = data.template_cloudinit_config.config-geeks.rendered
}

data "template_cloudinit_config" "config-geeks" { # monte S3 repositorio-datos en /mnt/s3/
  gzip          = false
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/x-shellscript"
    content      = data.template_file.s3geeks.rendered
  }
}

data "template_file" "s3geeks" {
  template = file("templates/s3-paquetesgeeks.sh")
}




