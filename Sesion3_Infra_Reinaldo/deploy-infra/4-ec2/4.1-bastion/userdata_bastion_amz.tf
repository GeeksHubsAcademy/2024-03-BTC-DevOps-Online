locals {
  user_data = <<-EOF

#!/bin/bash
yum update -y

EOF
}