UniFlash Project Generator
======

Author: Danil Shalumov

Date: August 2017


Description
-----------

The `uniflash_project_generator` is a simple way to generate and flash UniFlash projects for CC3220SF and CC3220.`uniflash_project_generator` located at ```[sdk_install_path]\tools\cc32xx_tools\uniflash-project-generator```

Generated project includes:
* Service Pack file from ```sdk_install_path\tools\cc32xx_tools\servicepack-cc3x20```
* Trusted Root-Certificate Catalog from ```sdk_install_path\tools\cc32xx_tools\certificate-playground```
* Dummy Root-Certificate and Dummy User-Certificate from ```sdk_install_path\tools\cc32xx_tools\certificate-playground```

Requirements
-----------

| Application | Version |
| --- |  --- |
| UniFlash | 4.2.0.1435 |
| SLImageCreator | 1.0.17.7 |


Synopsis
-----------

```batch
uniflash_project_generator --name [PROJ_NAME] --device [DEV_TYPE] --mcu_bin [BIN_FILE] [EXTRA_OPTIONS]
```

Options
-----------

**--name**
: Unique project name

**--device**
: LaunchPad type. Available options : CC3220SF or CC3220

**--mcu_bin**
: MCU image file

**--debug**
: Enable debug prints

**--flash**
: Flash device after creating a project 

**--help**
: Show help options


Examples
-----------

Creating uniflash project for network_terminal demo on CC3220SF lauchped without flashing the device

```batch
uniflash_project_generator --name network_terminal --device CC3220SF --mcu_bin <path_to_network_terminal_bin>
```

Creating and flashing uniflash project for network_terminal demo on CC3220SF lauchped 

```batch
uniflash_project_generator --name network_terminal --device CC3220SF --mcu_bin <path_to_network_terminal_bin> --flash
```

Creating and flashing uniflash project for network_terminal demo on CC3220SF lauchped with debug prints

```batch
uniflash_project_generator --name network_terminal --device CC3220SF --mcu_bin <path_to_network_terminal_bin> --flash --debug
```

