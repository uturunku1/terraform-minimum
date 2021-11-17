terraform {
  cloud {
    # hostname = "tfcdev-21675e9a.ngrok.io"
    hostname     = "app.staging.terraform.io"
    organization = "example-org-6dff95"
    workspaces {
      # prefix = "app-"
      name = "terraform-minimum"
      # tags = ["app"]
    }
  }
}

# terraform {
#   backend "local" {
#     # path = "./tf.state"
#   }
# }

# hostname     = "app.staging.terraform.io"
# terraform {
#   cloud {
#     organization = "barretto"
#     workspaces {
#       name = "wk1"
#     }
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
