variable "cuenta" {
  type = string
}

variable "proyecto" {
  type = string
}

variable "key_name" {
  description = "Nombre de keypair"
  type        = string
}

variable "private_key_path" {
  description = "Ruta para guardar la llave privada"
  type        = string
}

variable "tags" {
  description = "tags para despliegue"
  type        = map(string)
}

variable "ec2_config" {
  description = "Configuración de las instancias EC2"
  type = map(object({
    role_name     = string
    ami           = string
    instance_type = string
    subnet_id     = string
    tagsec2       = map(string)
    policy_arn    = string
    policy_arn1   = string
    root_block_device = object({
      volume_size = number
      volume_type = string
      iops        = number
    })
  }))
}

variable "sg_config" {
  description = "Configuración de los Segurity Group"
  type = map(object({
    name                 = string
    description          = string
    vpc_id               = string
    projectsecuritygroup = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}

variable "vpc_id" {
  type = string
}