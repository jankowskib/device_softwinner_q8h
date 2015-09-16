# BoardConfig.mk
#
# Product-specific compile-time definitions.
#

include device/softwinner/polaris-common/BoardConfigCommon.mk

BOARD_USE_CUSTOM_MODULES := true

#recovery
TARGET_RECOVERY_UI_LIB := librecovery_ui_q8h

TARGET_NO_BOOTLOADER := true
TARGET_NO_RECOVERY := false
TARGET_NO_KERNEL := false

ifeq ($(BOARD_PCB_VERSION), V5)
	BOARD_WIFI_VENDOR := espressif
else ifeq ($(BOARD_PCB_VERSION), V2)
	BOARD_WIFI_VENDOR := realtek
else ifeq ($(BOARD_PCB_VERSION), V1.5)
	BOARD_WIFI_VENDOR := realtek
else ifeq ($(BOARD_PCB_VERSION), V1.2)
	BOARD_WIFI_VENDOR := rda
	BOARD_HAVE_BLUETOOTH := true
else ifeq ($(BOARD_PCB_VERSION), V1.0)
	BOARD_WIFI_VENDOR := rda
	BOARD_HAVE_BLUETOOTH := true
else 
	$(error Please set BOARD_PCB_VERSION!)
endif

ifeq ($(BOARD_WIFI_VENDOR), realtek)
    WPA_SUPPLICANT_VERSION := VER_0_8_X
    BOARD_WPA_SUPPLICANT_DRIVER := NL80211
    BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_rtl
    BOARD_HOSTAPD_DRIVER        := NL80211
    BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_rtl

    SW_BOARD_USR_WIFI := rtl8188eu
    BOARD_WLAN_DEVICE := rtl8188eu
endif

ifeq ($(BOARD_WIFI_VENDOR), espressif)
	WPA_SUPPLICANT_VERSION := VER_0_8_X
	BOARD_WPA_SUPPLICANT_DRIVER := NL80211
	BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_esp
	BOARD_HOSTAPD_DRIVER        := NL80211
	BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_esp

	SW_BOARD_USR_WIFI := esp8089
	BOARD_WLAN_DEVICE := esp8089
	
endif

ifeq ($(BOARD_WIFI_VENDOR), rda)
    WPA_SUPPLICANT_VERSION := VER_0_8_X
    BOARD_WPA_SUPPLICANT_DRIVER := WEXT

    SW_BOARD_USR_WIFI := rda5990
    BOARD_WLAN_DEVICE := rda5990
	BOARD_WLAN_RDA_COMBO := true
	
endif

