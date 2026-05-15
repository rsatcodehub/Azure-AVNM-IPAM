az account set --subscription "az-cloud-tst-sub"

 
## AVNM

az group create --name rg-tst-atpy --location australiaeast

az deployment group create \
   --resource-group rg-tst-atpy \
   --template-file avnm.bicep \
   --parameters avnm.bicepparam --debug

az deployment group create --resource-group rg-tst-ase-autoipam-003  --template-file avnm.bicep    --parameters tst.bicepparam --debug


##### REGIONAL ROOT




az deployment group create \
   --resource-group rg-tst-ae-avnm \
   --template-file regionalroot.bicep \
   --parameters regionalroot.bicepparam --debug

az deployment group create --resource-group rg-tst-ae-avnm  --template-file regionalroot.bicep --parameters regionalroot.bicepparam  --debug


####


pwsh -c 'Get-ChildItem -Path . -Filter *.bicepparam -Recurse | ForEach-Object { az bicep format --file $_.FullName }'

pwsh -c 'Get-ChildItem -Path . -Filter *.bicep -Recurse | ForEach-Object { az bicep format --file $_.FullName }'