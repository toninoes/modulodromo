#!/bin/bash
# Obtener la lista de VMs que coinciden con la etiqueta
vm_ids=$(az vm list --query "[?tags.project=='my-azure-iac'].id" -o tsv)

# Crear el archivo de inventario de Ansible
echo "[azure_vms]" > hosts

# Iterar sobre los IDs de las VMs y obtener sus IPs públicas
for vm_id in $vm_ids; do
  vm_ip=$(az vm list-ip-addresses --ids $vm_id --query "[].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)
  echo "$vm_ip ansible_user=adminuser ansible_ssh_private_key_file=~/.ssh/toninoes" >> hosts
done
