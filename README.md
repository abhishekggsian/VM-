✅ README.md for Modular Terraform Azure Setup
markdown
Copy
Edit
# 🌐 Azure 3-Tier Architecture Deployment using Modular Terraform

This project deploys a complete 3-tier architecture on **Microsoft Azure** using **Terraform modules**. It includes reusable and parameterized modules for each Azure service like resource group, virtual network, subnets, NSG, VMs, public IPs, and Azure SQL Database.

---

## 📦 Project Structure

inframodules/
├── infra_parant/
│   ├── common.tf
│   ├── provider.tf
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   └── modules/
│       ├── azurerm_network_interface/
│       ├── azurerm_network_security_grp/
│       ├── azurerm_public_IP/
│       ├── azurerm_resource_group/
│       ├── azurerm_sql_database/
│       ├── azurerm_sql_server/
│       ├── azurerm_subnet/
│       ├── azurerm_virtual_machine/
│       └── azurerm_virtual_network/
🧱 Architecture Diagram (Logical)

Resource Group: abhi-todo-rg
└── Virtual Network: abhivnet1
    ├── Subnet: frontend (with NSG)
    │   └── VM: abhi-vm1 (with Public IP abhi-pip)
    ├── Subnet: backend (with NSG)
    │   └── VM: abhi-vm2 (with Public IP abhi-pip1)
└── Azure SQL Server: todo-sql-server3
    └── Database: todosqldb
🧰 Modules Implemented
Each resource is deployed using reusable modules:

Module	Resource
azurerm_resource_group	Azure Resource Group
azurerm_virtual_network	Virtual Network
azurerm_subnet	Subnets (frontend, backend)
azurerm_network_interface	NICs for each VM
azurerm_public_IP	Public IPs for SSH
azurerm_virtual_machine	Ubuntu Linux VMs
azurerm_sql_server	Azure SQL Logical Server
azurerm_sql_database	Azure SQL Database
azurerm_network_security_grp	NSG with rules for SSH

🚀 How to Deploy
1️⃣ Initialize Terraform

terraform init
2️⃣ Plan the Infrastructure

terraform plan
3️⃣ Apply the Configuration

terraform apply
📤 Output (Example)

Apply complete! Resources:
  - abhi-todo-rg
  - abhivnet1 with 2 subnets
  - abhi-vm1 (frontend) - Public IP: <ip1>
  - abhi-vm2 (backend) - Public IP: <ip2>
  - Azure SQL Server + Database
🔐 Security Notes
SSH (port 22) is open — restrict to specific IPs in azurerm_network_security_grp.


✍ Example Module Call (From common.tf)

module "todo-rg" {
  source         = "../modules/azurerm_resource_group"
  resource_group = "abhi-todo-rg"
  location       = "Central India"
}
