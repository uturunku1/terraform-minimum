# variable "username" {
# }
#
# resource "null_resource" "random" {
#   triggers = {
#     username = var.username
#   }
# }
#
# output "random" {
#   value = "Changed to ${null_resource.random.id}"
# }
#
# output "username" {
#   value = "Username is ${var.username}. Extra text???"
# }
#

output "val" {
  value = terraform.workspace
}

# resource "random_pet" "always_new" {
#   keepers = {
#     uuid = uuid() # Force a new name each time
#   }
#   length = 3
# }
#
# output "pet" {
#   value = { name_of_pet : random_pet.always_new.id }
# }
