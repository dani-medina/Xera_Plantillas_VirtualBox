#!/bin/bash

#Na variable ruta poñemos as rutas aos arquivo OVA que queremos importar separadas por espazos

FICHEIROPLANTILLASORIXINAL="Plantillas.txt.orixinal"
FICHEIROPLANTILLAS="Plantillas.txt"
sed  "s/USUARIO/${USER}/g" ${FICHEIROPLANTILLASORIXINAL} > ${FICHEIROPLANTILLAS}   

#Modificamos IFS para que non faga saltos no bucle cos espazos dos nomes das variables.
IFS=$'\n'


for LINEA in $(cat ${FICHEIROPLANTILLAS});
do
	for i in $(seq 1 5)
	do
		echo "*****************************************************************************"
	done
	RUTA=$(echo ${LINEA} | cut -f 1 -d :)
	NOME=$(echo ${LINEA} | cut -f 2 -d :)
	
	if [  -e ${RUTA} ]; then
		if  ! vboxmanage list vms | grep "${NOME}" > /dev/null; then
	
			
			echo "IMPORTANDO PLANTILLA ${NOME} dende arquivo ${RUTA}"
			vboxmanage import "${RUTA}"  --vsys 0 --eula accept --vsys 0 --vmname "${NOME}" --group "/Plantillas" 
			vboxmanage modifyvm "${NOME}"  --cpus 2 --boot1 none --boot2 none --boot3 none --boot4 none  
			vboxmanage modifyvm "${NOME}" --nic1 intnet --intnet1 intnet
			vboxmanage modifyvm "${NOME}" --macaddress1 auto
			vboxmanage storagectl "${NOME}" --name SATA --hostiocache on
			
		fi
	else
		echo "A ruta ${RUTA} non se atopa"
	fi
done


	
