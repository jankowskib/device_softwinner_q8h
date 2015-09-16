CUSTOM_FW_ID := 1.01
BOARD_PCB_VERSION := V1.2

# gms    
$(call inherit-product-if-exists, vendor/google/products/gms.mk)
# dalvik setup
$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)

PCB_PATH := $(LOCAL_PATH)/$(BOARD_PCB_VERSION)

ifneq (,$(filter V1.2 V1.0,$(BOARD_PCB_VERSION)))
	PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml
	PRODUCT_PACKAGES +=  Bluetooth
else ifeq ($(BOARD_PCB_VERSION), V5)
	$(call inherit-product-if-exists, hardware/espressif/wlan/firmware/esp8089/device-esp.mk)
endif

# init.rc, kernel
PRODUCT_COPY_FILES += \
	$(PCB_PATH)/kernel:kernel \
	device/softwinner/polaris-common/modules/modules/nand.ko:root/nand.ko \
	$(PCB_PATH)/init.sun8i.rc:root/init.sun8i.rc \
	$(LOCAL_PATH)/ueventd.sun8i.rc:root/ueventd.sun8i.rc \
	$(LOCAL_PATH)/initlogo.rle:root/initlogo.rle  \
	$(LOCAL_PATH)/fstab.sun8i:root/fstab.sun8i \
	$(LOCAL_PATH)/init.recovery.sun8i.rc:root/init.recovery.sun8i.rc

# wifi features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml

#key and tp config file
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/sunxi-keyboard.kl:system/usr/keylayout/sunxi-keyboard.kl \
	$(LOCAL_PATH)/configs/tp.idc:system/usr/idc/tp.idc \
	$(LOCAL_PATH)/configs/gsensor.cfg:system/usr/gsensor.cfg

#copy touch and keyboard driver to recovery ramdisk
PRODUCT_COPY_FILES += \
    device/softwinner/polaris-common/modules/modules/disp.ko:obj/disp.ko \
    device/softwinner/polaris-common/modules/modules/sunxi-keyboard.ko:obj/sunxi-keyboard.ko \
    device/softwinner/polaris-common/modules/modules/lcd.ko:obj/lcd.ko

    
#recovery config
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/recovery.fstab:recovery.fstab 
# camera
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/camera.cfg:system/etc/camera.cfg \
	$(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml
#	frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.timezone=Europe/Warsaw \
    persist.sys.language=en \
    persist.sys.country=US

#GPS Feature
PRODUCT_PACKAGES +=  gps.polaris
BOARD_USES_GPS_TYPE := simulator
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp,adb \
	ro.udisk.lable=Q8H \
	ro.hwa.force=true \
	rw.logger=0 \
	ro.sys.bootfast=false \
	debug.hwui.render_dirty_regions=false

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=120 \
	ro.product.firmware=v$(CUSTOM_FW_ID)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.carrier=wifi-only \
    ro.wifi.usb=true \
	ro.config.low_ram=true

$(call inherit-product, device/softwinner/polaris-common/polaris-common.mk)
$(call inherit-product, device/softwinner/polaris-common/rild/polaris_3gdongle.mk)

DEVICE_PACKAGE_OVERLAYS := \
    $(LOCAL_PATH)/overlay \
    $(DEVICE_PACKAGE_OVERLAYS)

PRODUCT_CHARACTERISTICS := tablet

# Overrides
PRODUCT_AAPT_CONFIG := xlarge hdpi xhdpi large 
PRODUCT_AAPT_PREF_CONFIG := hdpi

PRODUCT_BRAND  := Ippo
PRODUCT_NAME   := q8h
PRODUCT_DEVICE := q8h
PRODUCT_MODEL  := Ippo Q8H

CUSTOM_BUILD_NUMBER := true
CUSTOM_VERSION := $(PRODUCT_MODEL)-$(CUSTOM_FW_ID)
