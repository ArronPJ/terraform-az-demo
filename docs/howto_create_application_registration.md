# Azure SPN 

* SPN(Service Principle Name)
* 提供 AAA 需要手動製造

## Step1: Tenant = Azure AD

* AD = Active Directory

## Step2: Subscription 綁定一個 AD, 

* 但是 Azure AD 可以綁定多個 Subscription.

## Step3: 

* Home-> Azure Active Directory -> App registrations(應用程式註冊) -> New registration(新增註冊) -> (name=terraform)+single tenant -> “Register” (註冊)
    * EX:
        * 應用程式 (用戶端) 識別碼:aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa
        * 目錄 (租用戶) 識別碼:cccccccc-cccc-cccc-cccc-cccccccccccc
        * 物件識別碼:eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee
    * SPN , Application_ID = > client_id
    * SPN , Directory_ID = > tenant_id


## Step4: 

* Home-> Azure Active Directory->  App registrations(應用程式註冊)-> name= terraform -> Certificate & Secrete (憑證與秘密) -> New Client Secrete(新增用戶端密碼)
    * client_secrete = VALUE , with EXPIRES (1year)
    * (client_secrete) EX: terraform , (11/2/3333) , Value = bbbbbb-bbbbbbbbb-bbbbbbbbbbbb--b

## Step5:

* Home->Subscriptions(訂用帳戶) -> Subscription_id = dddddddd-dddd-dddd-dddd-dddddddddddd

## Step6:

* Home->Subscriptions(訂用帳戶 -> 免費試用版 -> IAM ->
    * Add(新增) -> Add role assignment(新增角色指派) -> 
        * Role = Contributor
        * Assign Access to = Azure AD user , group, or service pincipal
        * Select = terraform (我們取的名字)
        * 按 Save (儲存)



    
    
    
    