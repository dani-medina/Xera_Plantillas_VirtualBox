# Xera_Plantillas_VirtualBox
Un script que importa máquinas segundo unha arquivo cunha táboa cos datos das máquinas que hai que importar.

O script utiliza o arquivo Plantillas.txt.orixinal, que ven sendo un CSV en formato táboa:

| RUTA                                                                                                          | NOME                                |
|---------------------------------------------------------------------------------------------------------------|-------------------------------------|
| /media/TEIS/USUARIO/virtual/VirtualBox/Maquinas_creadas/GNU_Linux_Debian/Debian_12/Debian_12_Server.ova       | Debian 12 Server - Plantilla        |
| /media/TEIS/USUARIO/virtual/VirtualBox/Maquinas_creadas/Windows11/Windows11_23H2/Windows_11_23H2.ova           | Windows 11 Pro - Plantilla          |
| /media/TEIS/USUARIO/virtual/VirtualBox/Maquinas_creadas/GNU_Linux_Ubuntu/Ubuntu_24.04_Desktop/Ubuntu_Desktop_24.04.ova | Ubuntu 24.04 Desktop - Plantilla    |
| /media/TEIS/USUARIO/virtual/VirtualBox/Maquinas_creadas/WindowsServer2022/Windows_2022_Server.ova              | Windows 2022 Sever - Plantilla      |


O script reempraza a palabra USUARIO polo usuario que executa o script no campo ruta.

Depois, se atopa o arquivo o importa en VirtualBox e finalmente, fai as seguintes configuracións:

- Pon dúas 2 CPUs.
- Desactiva calquera dispoistivo de inicio.
- Pon a tarxeta en rede interna.
- Xera unha MAC aleatoria para a plantilla.
- Activa o hostiocache.

## Para executalo:

```bash 
bash Crea_Plantillas.bash
```

