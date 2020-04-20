# Sample of "terraform.tfvars" file

```

## IAM
client_id       = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
client_secret   = "bbbbbb-bbbbbbbbb-bbbbbbbbbbbb--b"
tenant_id       = "cccccccc-cccc-cccc-cccc-cccccccccccc"
subscription_id = "dddddddd-dddd-dddd-dddd-dddddddddddd"

## Resource Group
web_server_location         = "Japan West"
#web_server_location         = "westus2"
web_server_rg               = "web_server_rg"

## VNET
resource_prefix             = "web_server"
web_server_address_space    = "1.0.0.0/22"
web_server_address_prefix   = "1.0.1.0/24"
web_server_name             = "web-01"

## Other
environment                 = "production"  # Stage

## admin
super_username              = "webserver"
super_password              = "Passw0rd1234"

```