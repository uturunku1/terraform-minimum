#!/bin/bash

~/go/bin/terraform init
# ~/go/bin/terraform apply -auto-approve
~/go/bin/terraform workspace new aaa2
~/go/bin/terraform apply -auto-approve
~/go/bin/terraform workspace new bbb2
~/go/bin/terraform apply -auto-approve
