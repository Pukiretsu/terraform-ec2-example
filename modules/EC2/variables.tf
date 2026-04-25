variable "ec2_config" {
  description = "Configuración detallada de cada instancia EC2"
  type = map(object({
    ami           = string
    instance_type = string
    subnet_id     = string
    tagsec2       = map(string)
    role_name     = string
    policy_arn    = string 
    root_block_device = object({
      volume_size = number
      volume_type = string
      iops        = number
    })
  }))
}

variable "tags" {
  description = "Tags globales que se heredarán a todos los recursos"
  type        = map(string)
}

variable "security_group_ids" {
  description = "Mapa de IDs de Security Groups provenientes del módulo SG"
  type        = map(string)
}

variable "iam_instance_profiles" {
  description = "Mapa de nombres de Instance Profiles provenientes del módulo IAM"
  type        = map(string)
}

variable "key_name" {
  description = "Nombre que se le asignará al Key Pair en AWS"
  type        = string
}

variable "private_key_path" {
  description = "Ruta local donde se guardará el archivo .pem"
  type        = string
}