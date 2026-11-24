# Importador de plantillas OVA para VirtualBox

Dous scripts en Bash para **importar automaticamente a VirtualBox un conxunto de máquinas virtuais (arquivos OVA)** como plantillas, con rutas personalizadas segundo o usuario que executa o script.

Pensado para preparar contornos de aula ou laboratorio onde cada usuario precisa as mesmas plantillas, cunha configuración común (CPUs, rede interna, arranque, etc.).

## Contido do repositorio

| Arquivo | Descrición |
|---|---|
| `Plantillas.txt.orixinal` | Modelo da lista de plantillas. Contén o marcador `USUARIO`, que se substitúe polo nome do usuario actual. |
| `01_Prepara_Contorna.bash` | Xera `Plantillas.txt` a partir do modelo, substituíndo `USUARIO` por `$USER`. |
| `02_Xera-Plantillas.bash` | Le `Plantillas.txt` e importa a VirtualBox cada OVA que aínda non estea importado. |

> Os nomes dos scripts son orientativos; axústaos aos nomes reais do teu repositorio.

## Requisitos

- Linux (ou calquera sistema con Bash e `sed`)
- [VirtualBox](https://www.virtualbox.org/) con `vboxmanage` dispoñible no `PATH`
- Os arquivos `.ova` descargados nas rutas indicadas

## Formato de `Plantillas.txt.orixinal`

Unha plantilla por liña, co formato:

```
RUTA_AO_OVA:NOME_DA_MAQUINA
```

O marcador `USUARIO` substituirase polo nome do usuario que execute o script. Exemplo:

```
/home/USUARIO/OVAs/debian12.ova:Plantilla-Debian12
/home/USUARIO/OVAs/ubuntu 24.ova:Plantilla-Ubuntu24
```

Con `USER=maria`, o ficheiro xerado `Plantillas.txt` quedaría así:

```
/home/maria/OVAs/debian12.ova:Plantilla-Debian12
/home/maria/OVAs/ubuntu 24.ova:Plantilla-Ubuntu24
```

Notas sobre o formato:

- As rutas poden levar espazos.
- O separador é `:`, polo que **non debe aparecer `:` dentro da ruta nin do nome** (por exemplo, rutas tipo `C:\...`).

## Uso

### 1. Xerar `Plantillas.txt`

```bash
chmod +x 01_Prepara_Contorna.bash importar_plantillas.sh
./01_Prepara_Contorna.bash.bash
```

Isto crea `Plantillas.txt` a partir de `Plantillas.txt.orixinal` (o orixinal non se modifica).

### 2. Importar as plantillas

O script de importación usa a variable `FICHEIROPLANTILLAS`, que debe apuntar ao ficheiro xerado:

```bash
export FICHEIROPLANTILLAS=Plantillas.txt
./02_Xera-Plantillas.bash
```

Alternativamente, podes executar ambos co mesmo contexto de variables:

```bash
source ./01_Prepara_Contorna.bash.sh
./02_Xera-Plantillas.bash
```

> Se `FICHEIROPLANTILLAS` non está definida, o bucle non procesará ningunha liña.

## Que fai a importación

Para cada liña de `Plantillas.txt`:

1. Comproba que a ruta do OVA existe. Se non, avisa con `A ruta ... non se atopa`.
2. Comproba se xa existe unha VM con ese nome en VirtualBox. Se existe, **omítea**.
3. Se non existe, importa o OVA e aplica esta configuración:

| Axuste | Valor |
|---|---|
| Nome da VM | O indicado en `Plantillas.txt` |
| Grupo | `/Plantillas` |
| EULA | Aceptada automaticamente |
| CPUs | 2 |
| Orde de arranque | Ningún dispositivo (`boot1`–`boot4` en `none`) |
| Rede (NIC 1) | Rede interna `intnet` |
| Enderezo MAC | Xerado automaticamente |
| Controladora SATA | Caché de E/S do host activada |

Podes cambiar estes valores editando as chamadas a `vboxmanage modifyvm` e `vboxmanage storagectl` no script de importación.

## Personalización

- **Máis marcadores:** encadea substitucións en `sed`, por exemplo:
  ```bash
  sed -e "s/USUARIO/${USER}/g" -e "s/MAQUINA/$(hostname)/g" Plantillas.txt.orixinal > Plantillas.txt
  ```
- **Máis CPUs, memoria ou outra rede:** modifica as opcións de `vboxmanage modifyvm` (por exemplo `--memory 2048` ou `--nic1 nat`).
- **Outro grupo de VirtualBox:** cambia o valor de `--group`.

## Limitacións coñecidas

- A comprobación de existencia de VM usa coincidencia parcial de nome: se existe `Plantilla-Debian12-v2`, a plantilla `Plantilla-Debian12` considerarase xa importada.
- O formato `RUTA:NOME` non admite `:` dentro dos campos.
- Probado con VirtualBox 7; a sintaxe de `vboxmanage` pode variar noutras versións.

## Licenza

Engade aquí a licenza do proxecto (por exemplo, MIT ou GPL-3.0).