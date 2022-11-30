terraform {
  cloud {
    organization = "hashicorp"
    hostname = "tfcdev-326ff8f0.ngrok.io"
    workspaces {
      name = "random-null-resources"
    }
  }
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    } 
  }
}

provider "null" {
  alias = "foo"
}

resource "null_resource" "test" {
  provider = "null.foo"
}

variable "username" {
  type = string
  default = "uturunku1"
}

resource "random_pet" "always_new_name" {
  keepers = {
    uuid = uuid() # Force a new name each time
  }
  length = 3
}

resource "random_uuid" "test" {
} #generates random uuid string that is intended to be used as unique identifiers/names for other resources


# The null_resource resource implements the standard resource lifecycle but takes no further action.
# Example, whenever a new ec2 instance resource is created, triggers will take note of the new id create, then a null_resource instance will be replaced gathering data about that ec2 instance. To gather data you could add inside the block: 
# provisioner "remote-exec" {
#   inline = [
#       "bootstrap-cluster.sh ${join(" ",
#       aws_instance.cluster.*.private_ip)}",
#     ]
# } 
# Everythime null_resource gets replaced the remote-exec provisioner will be re-run.
resource "null_resource" "username" {
  triggers = {
    # Generate a new username each time we switch the value of the variable username
    username = var.username
  }
}

resource "null_resource" "random_uuid" {
  triggers = {
    # Generate a new username each time we switch the value of the variable username
    username = "${random_uuid.test.result}-rg"
  }
}

resource "null_resource" "a" {
}

resource "null_resource" "b" {
  depends_on = [
    "null_resource.a",
    "null_resource.random_uuid"
    ] # WARNING: Quoted references are deprecated
}

output "null_resource_username_id" {
  value = "Changed to ${null_resource.username.id}"
}

output "variable_username" {
  value = "Username is ${var.username}"
}


# output "workspace_name" {
#   value = terraform.workspace
# }

output "random_resource_always_new_name_id" {
  value = { name_of_pet : random_pet.always_new_name.id }
}

# terraform {
#   backend "remote" {
#     hostname = "tfcdev-326ff8f0.ngrok.io"
#     organization = "hashicorp"

#     workspaces {
#       name = "luces-testing-wsid"
#     }
#     # required_version = ">= 1.0.7, < 1.0.9"
#   }
# }

# terraform {
#   backend "local" {
#     # path = "./tf.state"
#   }
# }

# terraform {
#   backend "pg" {
#     conn_str = "postgres://barrettclark@localhost/barrettclark?sslmode=disable"
#     workspaces {
#       name = "wk3"
#     }
#   }
# }


variable "name_length" {
  default = 4
}

# resource "random_pet" "always_error" {
#   lifecycle {
#     precondition {
#       condition     = var.name_length > 5 // false triggers error
#       error_message = "Name length must be greater than 5."
#     }

#     postcondition {
#       condition     = var.name_length > 10 // false triggers error
#       error_message = "Name length must be greater than 5."
#     }
#   }

#   keepers = {
#     uuid = uuid() # Force a new name each time
#   }
#   length = var.name_length
# }

output "pet" {
  value = random_pet.always_error.id
}
resource "random_pet" "pet" {
  prefix = "{"
}
output "fail-at-apply" {
  value = jsondecode(random_pet.pet.id)
}

# locals {
#   a = join(["foo"], "bar")
#   b = max([1, 2, 3])
#   c = abs("minus five")
#   d = jsondecode("[1, 2, 3")
# }