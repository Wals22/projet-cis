resource "aws_launch_template" "juice_shop_lt" {
  name          = "juice-shop-lt"
  image_id      = var.aws_ami_id
  instance_type = "t2.micro"
  key_name      = "key_pair"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.security_group_id]
  }

  metadata_options {
    http_tokens = "required"
    http_put_response_hop_limit = 2
    http_endpoint = "enabled"
  }

  block_device_mappings {
    device_name = "/dev/xvdf"
    ebs {
      volume_size           = 8
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  user_data = base64encode(<<-EOT
    #!/bin/bash
    yum update -y
    amazon-linux-extras install docker -y
    service docker start
    usermod -a -G docker ec2-user
    mkfs -t ext4 /dev/xvdf
    mkdir /data
    mount /dev/xvdf /data
    echo "/dev/xvdf /data ext4 defaults,nofail 0 2" >> /etc/fstab
    docker pull bkimminich/juice-shop
    docker run -d -p 80:3000 -v /data:/app/data bkimminich/juice-shop
  EOT
  )
}
