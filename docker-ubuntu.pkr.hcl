packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:latest"
  commit = true
}

build {
  name = "packer-ubuntu"
  sources = [
    "source.docker.ubuntu"
  ]
  provisioner "ansible" {
    playbook_file = "./playbook.yml"
  }
}
