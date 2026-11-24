#!/bin/bash
#Na variable ruta poñemos as rutas aos arquivo OVA que queremos importar separadas por espazos

FICHEIROPLANTILLASORIXINAL="Plantillas.txt.orixinal"
FICHEIROPLANTILLAS="Plantillas.txt"
if [ -f "$FICHEIROPLANTILLASORIXINAL" ]; then 
    sed  "s/USUARIO/${USER}/g" "${FICHEIROPLANTILLASORIXINAL}" > "${FICHEIROPLANTILLAS}"   
else
    echo "Falta $FICHEIROPLANTILLASORIXINAL"
fi
