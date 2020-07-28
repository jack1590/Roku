# Description

This is an application for Roku platform using brightscript, scenegraph, deeplink.

## Main feature

+ Main scene displaying  movies and series
+ Login view to authenticate the users of the application
+ Detail screen with video player 
+ Deeplink implementation
+ Video progress maintained
+ Remember me implementation 

## roRegistrySection
Transient section was used so if you want to login again please reboot your device.

## Installation

### Using global variables * (optional)

To deploy this app easier you can configure the following variables:

```bash
export DEVPASSWORD="{ROKU_DEV_PASSWORD} ex: pass"
export ROKU_DEV_TARGET="{ROKU_DEVICE_IP} ex: 192.168.1.185"
```
### Launch App

Under root app folder run:

```bash
bash deploy.sh
```
> deploy.sh is an script to launch the app. It will ask for:
> 

+ **IP TO DEPLOY**: Set Roku ip, default is based on `ROKU_DEV_TARGET` property.
+ **ROKU PASSWORD TO DEPLOY**: Set Roku password, default is based on `DEVPASSWORD` property.

### Design

|Screen| - |
|------| - |
|Splash| ![](https://drive.google.com/uc?export=view&id=1ONGxiuy7_5nIClKTYm7COX-8jhqSt4Vd) |
|Login| ![](https://drive.google.com/uc?export=view&id=1TwlQIY2MplfUl2tqNCmeLB9ekYJ5SmYe) | 
|Login failed| ![](https://drive.google.com/uc?export=view&id=1DDobEB_6SEq6DGlhywNNd7Hdu6lbzXc3) | 
|Home| ![](https://drive.google.com/uc?export=view&id=1YLZHI6_dKs5NWwI16HrzrV7P1pU858sm) | 
|Detail| ![](https://drive.google.com/uc?export=view&id=1ye2OuPTF-IyX4T2pXPY_8ATpjESh_bKJ) | 
|Videoplayer| ![](https://drive.google.com/uc?export=view&id=1HUr3ltsp5ifAUBWIL2J2fQ2pPOpliFHx) | 

### Deeplink
To test deeplink use curl command

```
curl -d '' "http://<ROKU_DEVICE_IP>:8060/launch/dev?contentId=urn%3Ahbo%3Atile%3AGXfGGmgzDUsJ_LwEAAAIz%3Atype%3Aseries%3Aview%3Ahome&mediaType=series"

```