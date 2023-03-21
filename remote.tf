terraform {
  cloud {
    organization = "lucesorg-only-applylimitflag"
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
resource "random_uuid" "test2" {
}

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

# output "null_resource_username_id" {
#   value = "Changed to ${null_resource.username.id}"
# }

# output "variable_username" {
#   value = "Username is ${var.username}"
# }

# output "random_resource_always_new_name_id" {
#   value = { name_of_pet : random_pet.always_new_name.id }
# }

variable "name_length" {
  default = 4
}
variable "name_length2" {
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

# output "pet" {
#   value = random_pet.always_error.id
# }
# resource "random_pet" "pet" {
#   prefix = "{"
# }
# output "fail-at-apply" {
#   value = jsondecode(random_pet.pet.id)
# }

# locals {
#   a = join(["foo"], "bar")
#   b = max([1, 2, 3])
#   c = abs("minus five")
#   d = jsondecode("[1, 2, 3")
# }