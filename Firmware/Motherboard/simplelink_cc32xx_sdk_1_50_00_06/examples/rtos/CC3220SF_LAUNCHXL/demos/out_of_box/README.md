## Example Summary

This example demonstrates the Out of Box experience with CC3220 devices.

## Peripherals Exercised

* `Board_LED0 (red LED)` - Indicates that the board was initialized within `main()`.
Since only this LED is used for status indication, similar indications may be applied in more than one occasion. To distinguish similar indications, the user needs to be aware of the executed procedure. The following table lists all options.

<table>
  <tr>
    <th>red LED indication</th>
    <th>Procedure</th> 
    <th>Interpretation</th>
  </tr>
  <tr>
    <td>Blinking once per 2 seconds</td>
    <td>Provisioning</td> 
    <td>CC3220 is being provisioned</td>
  </tr>
  <tr>
    <td>Solidly on</td>
    <td>Provisioning</td> 
    <td>Connection to Access Point is up</td>
  </tr>
  <tr>
    <td>Solidly off</td>
    <td>Provisioning</td> 
    <td>Connection to Access Point is down</td>
  </tr>
  <tr>
    <td>Blinking once per second</td>
    <td>Local network connection</td> 
    <td>For Station mode, connection to Access Point is in progress. For Access Point mode, initialization is in progress</td>
  </tr>
  <tr>
    <td>Solidly on</td>
    <td>Local network connection</td> 
    <td>For Station mode, connection to Access Point is up. For Access Point mode, initialization is done</td>
  </tr>
  <tr>
    <td>Solidly off</td>
    <td>Local network connection</td> 
    <td>Applies in Station mode only. Connection to Access Point is down</td>
  </tr>
  <tr>
    <td>Blinking 5 times per second</td>
    <td>Over the Air update</td> 
    <td>Over the Air update of CC3220 is in progress</td>
  </tr>
  <tr>
    <td>Solidly on</td>
    <td>Over the Air update</td> 
    <td>Over the Air update of CC3220 succeeded</td>
  </tr>
  <tr>
    <td>Solidly off</td>
    <td>Over the Air update</td> 
    <td>Over the Air update of CC3220 failed</td>
  </tr>
  <tr>
    <td>Blinking once per second</td>
    <td>Return to default</td> 
    <td>Return to default procedure is done. Waiting for the user to manually restart the CC3220 LaunchPad</td>
  </tr>
</table>

* `Board_initI2C (for onboard accelerometer)` - I2C interface is used for control of the CC3220 Launchpad onboard accelerometer.


## Example Usage

* Downloads and Installations.
	- Make sure you have Uniflash installed.
	- Make sure you have SimpleLink™ Wi-Fi® Starter Pro mobile application installed. This application can be downloaded and installed via the application stores. It is available both on iOS and Android. Users should look for *WiFi starter pro*.
	- In case debugging is desired (advanced user), CCS or IAR IDEs are also required.

* Checklist of required elements.
	- In case debugging is desired (advanced user)
		- Uniflash projects according to device flavor.	
		- Certificate artifacts, ca.der certificate and ca-priv-key.der private key.
	- In case debugging is not desired (basic user)
		- Uniflash precompiled image according to device flavor.

* Build the setup.
	> Make sure you have the a local AP and a mobile/tablet with SimpleLink™ Wi-Fi® Starter Pro mobile application installed.  

* Uniflash
	* Open Uniflash.
	* Open the relevant Uniflash project according to the device flavor and rtos. The project can be found in `\Uniflash\OOB_<Flavor>_<rtos>.zip`.
	* For basic users.
		- Program the project to the target device.  
	* For advance users, building the project is required.    
		- Use the desired IDE (CCS or IAR) to open Out of Box project, make your modifications and recompile.
		- Replace the MCU image in the project and flash it.
			> The example could be executed from the debugger as well but since it involves platform reset at the end (so the new OTA image can be tested and committed),the debugger would get disconnected.
	> More instructions can be found in paragraph 5. Flashing the Out-of-Box Project in the [Out of Box user's guide](http://www.ti.com/lit/SWRU473 "Out of Box user's guide").



* Open a serial session (e.g. `HyperTerminal`,`puTTY`, etc.) to the appropriate COM port.
	> The COM port can be determined via Device Manager in Windows or via `ls /dev/tty*` in Linux.

	The connection should have the following settings
```
    Baud-rate:    115200
    Data bits:       8
    Stop bits:       1
    Parity:       None
    Flow Control: None
```

* Run the example by pressing the reset button. The example should start running automatically when programming via Uniflash is done.

* First, the device needs to be provisioned. Connection to CC3220 can be done either by provisioning it to the local AP or by directly connecting to it while in AP mode.
	* **Provisioning**: Using SimpleLink™ Wi-Fi® Starter Pro application, users can start AP provisioning or SmartConfig™ provisioning for fast CC3220 connection. During this procedure, the Access Point credentials are decoded by CC3220, and a profile is stored on the serial flash for future connection.
	`Board_LED0 (red LED)` should blink once every 2 seconds to indicate provisioning is in progress. When provisioning is done and connection to the local AP is completed, the LED should turn solid on.
	Terminal message should show device is ready to be provisioned:
		- `[Provisioning task] Provisioning Started. Waiting to be provisioned..!!` 

		Upon successful provisioning, terminal message should show: 
		- `[Provisioning task] Provisioning completed successfully..!`
		- `[Provisioning task] IP address is`
	*  **Direct Connect as AP**: setting CC3220 as an AP is very convenient in cases where no Access Point is available. AP mode is applied by pressing the SW2 switch on the CC3220 Launch Pad. `Board_LED0 (red LED)` should turn solid on. Terminal message should show: 
		- `[WLAN EVENT] STA BSSID:` with the MAC address of the connected device.
		- `[NETAPP EVENT] IPv4 leased` with the assigned IP address.
	
		> Note: the only valid way to switch to AP mode is by using the procedure above. It is not valid to connect to the device during provisioning.

* At this point, users may proceed to the onboard peripherals demo or to the local OTA.
	> Local OTA is available via the mobile application only whereas the onboard peripherals demo is available also via the web browser.

* **Onboard peripherals demo**: users can control and get the state of the onboard sensors. These sensors include the `Board_LED0 (red LED)` and the accelerometer. Additionally, users can fetch some device specific information (SSID, Mac address and IP address). Web pages also include a 3D board movement when the device is moved.

* **Local OTA**: available only via the mobile application.
	- Click the *Check for software update* button to test whether a new software version exists.
		> It is also possible to change the cloud repository by long pressing and holding the download icon next to *Check for software update* label, and filling the new URL
	- Start the SW update by clicking *Program* button.
	- The upload progress bar appears with the following messages:
		> 		- Download started
		> 			- Uploading new SW version
		> 			- Extracting archive file
		> 			- Writing to serial flash
		> 		- Download done
		> 			- Rebooting…
		> 			- Testing new SW version
	- Upon successful update, the new version should appear under *New SW version* section. The *Upload finished!* message appears on the bottom of the screen, and the screen is enabled again. Terminal message should show: 
		- `[Link local task] sl_extLib_OtaRun: ---- Download file completed`
		- `[Common] CC3220 MCU reset request`


## Application Design Details

The following features are highlighted:


- Easy connection to CC3220 LaunchPad
	- Using SimpleLink™ Wi-Fi® Starter Pro application (available both on iOS and Android). User can use AP provisioning and/or SmartConfig™ provisioning for fast CC3220 connection.
	- Configuring the device in Access Point mode gives users direct connection to CC3220 LaunchPad.

	> Once the device is provisioned and connected to an Access Point in station mode, the profile is stored on the local file system so that any reset to CC3220 automatically connects to the Access Point.

- Easy access to CC3220 via its internal web server
	- The SimpleLink™ Wi-Fi® Starter Pro application (available both on iOS and Android).
	- Any browser, web pages stored on the serial flash are loaded on the browser, to provide ease of use.
	> This feature demonstrates configuring and reading onboard sensors.


- Over The Air (OTA) update, demonstrating an update of a full image. OTA service enables in-system update of the MCU application, CC3220 firmware releases (a.k.a. Service Pack) made available by Texas Instruments and other vendor files. An update procedure executed in a full system integrity fashion, i.e. failure in upgrading any of the image components would lead to rolling back to the previous valid version.

## Known issues and limitations

- It is not valid to connect to CC3220 during provisioning (while it is periodically configured in AP mode). Configuring CC3220 in Access Point mode is allowed via SW2 switch as described earlier.
- Configuring CC3220 in Access Point mode is not persistence. It means that manual reset of the board makes CC3220 returns to its default, configures as Station, and tries to connect to a stored profile. If unsuccessful, it is configured in provisioning mode.
- Up to 20 non-default files can be updated during Over the Air update. Default files include files that are non-secured, part of bundle, fail-safe and with the size of the original file.
- Maximal file length inside a tar is 128 bytes. It is the full path as it appears in the tar file itself (including all directories from the root).
- Rarely, after provisioning is complete the LAN and OTA tabs do not appear. If these tabs do not appear, navigate to the Devices tab and select the device by pressing and holding it.
- Rarely, it is observed that the progress bar does not start or start but freeze in the middle; however the Over the Air update procedure is successful. In these cases, red LED (D7) indication and terminal printouts show the true status of the procedure, and also the Web client or mobile application should indicates a successful process.



## References

* For full detailed user guide open the following website:
 [http://www.ti.com/lit/SWRU473](http://www.ti.com/lit/SWRU473 "Out of Box user's guide")