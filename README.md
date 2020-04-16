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


## Basic Files

### main.tf
- Resource list
- Variable for security reason not in git repos.

## How to use Terraform CLI

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
