variable "tf-sa" {
  type = string
  default = "aje67dved3mdr8nvt0o4"
}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "default_zone" {
  type    = string
}

variable "bucket_name" {
  type    = string
  default = "ser-diplom-bucket"
}

variable "a_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "b_zone" {
  type    = string
  default = "ru-central1-b"
}

variable "d_zone" {
  type    = string
  default = "ru-central1-d"
}

variable "vpc_name" {
  type    = string
  default = "net"
}

variable "vm_resources" {
  type = map(any)
  default = {
    default = {
      "cores"     = 2
      "memory"        = 2
      "core_fraction" = 20
    }
    master = {
      "cores"     = 2
      "memory"        = 2
      "core_fraction" = 20
    }
    worker = {
      "cores"     = 2
      "memory"        = 2
      "core_fraction" = 20
    }
  }
}
