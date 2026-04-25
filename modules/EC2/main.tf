resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.this.private_key_pem
  filename = var.private_key_path
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "this" {
  for_each               = var.ec2_config
  # Replaces the value with the data source
  ami = each.value.ami == "amazon-linux-2023" ? data.aws_ami.amazon_linux_2023.id : each.value.ami 
  instance_type          = each.value.instance_type
  vpc_security_group_ids = [var.security_group_ids[each.key]]
  iam_instance_profile   = var.iam_instance_profiles[each.key]
  key_name               = aws_key_pair.this.key_name
  subnet_id              = each.value.subnet_id
  root_block_device {
    volume_size = each.value.root_block_device.volume_size
    volume_type = each.value.root_block_device.volume_type
    iops        = each.value.root_block_device.iops
  }
  volume_tags = merge(
    each.value.tagsec2,
    var.tags
  )
  tags = merge(
    each.value.tagsec2,
    var.tags
  )
}