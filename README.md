# How to use Terraform with Azure

## References:
- [HW](https://docs.microsoft.com/zh-tw/azure/virtual-machines/windows/sizes)
### VM Image Info Search
- Use azure-cli to get information from offical resource.
- Step01: authentication.
```
az login --service-principal -u "<client_id>" -p "<client_secret>" -t "<089e80f8-23b3-4c07-bca9-8f8de56eef7e>"
```
- Step02: get image from publisher list (with location)
```
az vm image list-publishers -l "Japan West" >> publisher_list.txt
```
- Step03: get offer from (publisher)
```
az vm image list-offers -l "Japan West" -p "MicrosoftWindowsServer" >> offers_list.txt
```
- Step04: get sku with (publisher + offer )
```
az vm image list-skus -l "Japan West" -p "MicrosoftWindowsServer" -f "WindowsServer" >> skus_list.txt
```

### VM size lookup
- list all size according to location.
```
az vm list-sizes -l "Japan West" >> size_list.txt
```


## Basic Files

### main.tf
- Resource list
- Variable for security reason not in git repos.

## How to use Terraform CLI

#### Step0: Create "terraform.tfvars"
- file will locate in the same folder as main.tf.
- Please copy content from [sample](docs/sample_terraform_tfvars.md)

#### Step1: CLI (init)
- download according to version.
```
terraform init
```
#### Step2: CLI (plan)
```
terraform plan
```

#### Step3: CLI (apply)
```
terraform apply
```

#### Step4: CLI (destroy)
```
terraform destroy
```

## Other Note:
- Standard_D2s_v3, Cognosys, MySQL 5.7 With CentOS 7.7
- 區域: 美國西部 2, 目前大小: Standard_D2s_v3, 映像: Windows Server 2012 R2 Datacenter
