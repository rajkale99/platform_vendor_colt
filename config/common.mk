# Copyright (C) 2018 ColtOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Generic product
PRODUCT_NAME := colt
PRODUCT_BRAND := colt
PRODUCT_DEVICE := generic

COLT_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)

EXCLUDE_SYSTEMUI_TESTS := true

PRODUCT_BUILD_PROP_OVERRIDES := BUILD_DISPLAY_ID=$(TARGET_PRODUCT)-$(PLATFORM_VERSION)-$(BUILD_ID)

# Bootanimation
$(call inherit-product, vendor/colt/config/bootanimation.mk)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.com.android.dataroaming=false \
    drm.service.enabled=true \
    net.tethering.noprovisioning=true \
    persist.sys.dun.override=0 \
    ro.build.selinux=1 \
    ro.adb.secure=0 \
    ro.setupwizard.rotation_locked=true \
    ro.opa.eligible_device=true \
    persist.sys.disable_rescue=true \
    ro.config.calibration_cad=/system/etc/calibration_cad.xml

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    org.colt.fingerprint=$(PLATFORM_VERSION)-$(BUILD_ID)-$(COLT_BUILD_DATE)

PRODUCT_DEFAULT_PROPERTY_OVERRIDES := \
    ro.adb.secure=0 \
    ro.secure=0 \
    persist.service.adb.enable=1

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Common overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/colt/overlay/common
DEVICE_PACKAGE_OVERLAYS += vendor/colt/overlay/common

#Speed tuning
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI

# Speed Apps
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI

# Fix Dialer
# PRODUCT_COPY_FILES +=  \
#    vendor/colt/prebuilt/common/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Latin IME lib - gesture typing
ifeq ($(TARGET_ARCH), $(filter $(TARGET_ARCH), arm64))
PRODUCT_COPY_FILES += \
    vendor/colt/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so \
    vendor/colt/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/colt/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
endif

# APN
PRODUCT_COPY_FILES += \
    vendor/colt/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/colt/prebuilt/fonts,$(TARGET_COPY_OUT_PRODUCT)/fonts) \
	vendor/colt/prebuilt/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

# AR
PRODUCT_COPY_FILES += \
    vendor/colt/prebuilt/common/etc/calibration_cad.xml:system/etc/calibration_cad.xml

# Extra packages
PRODUCT_PACKAGES += \
    Launcher3 \
    messaging \
    ExactCalculator \
    Stk \
    Terminal

# Init.d script support
PRODUCT_COPY_FILES += \
    vendor/colt/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/colt/prebuilt/common/etc/init/colt-system.rc:system/etc/init/colt-system.rc \
    vendor/colt/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner

# Markup libs
PRODUCT_COPY_FILES += \
    vendor/colt/prebuilt/google/lib/libsketchology_native.so:system/product/lib/libsketchology_native.so \
    vendor/colt/prebuilt/google/lib64/libsketchology_native.so:system/product/lib64/libsketchology_native.so

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/colt/prebuilt/common/addon.d/50-colt.sh:system/addon.d/50-colt.sh \
    vendor/colt/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/colt/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/colt/prebuilt/common/bin/system-mount.sh:install/bin/system-mount.sh

# Priv-app config
PRODUCT_COPY_FILES += \
    vendor/colt/config/permissions/privapp-permissions-colt.xml:system/etc/permissions/privapp-permissions-colt.xml \
    vendor/colt/config/permissions/wallpaper_privapp-permissions.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/wallpaper_privapp-permissions.xml

# Colt packages
PRODUCT_PACKAGES += \
    CustomDoze \
    GalleryGoPrebuilt \
    MarkupGoogle \
    SoundPickerPrebuilt \
    PixelThemes \
    OmniStyle \
    Snap

# ThemePicker & Fonts
PRODUCT_PACKAGES += \
    ThemePicker \
    FontGoogleSansOverlay

#OmniJaws
PRODUCT_PACKAGES += \
    OmniJaws \
    WeatherIcons

# Colt Stuff - Copy to System fonts
PRODUCT_COPY_FILES += \
    vendor/colt/prebuilt/fonts/gobold/Gobold.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Gobold.ttf \
    vendor/colt/prebuilt/fonts/gobold/Gobold-Italic.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Gobold-Italic.ttf \
    vendor/colt/prebuilt/fonts/gobold/GoboldBold.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoboldBold.ttf \
    vendor/colt/prebuilt/fonts/gobold/GoboldBold-Italic.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoboldBold-Italic.ttf \
    vendor/colt/prebuilt/fonts/gobold/GoboldThinLight.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoboldThinLight.ttf \
    vendor/colt/prebuilt/fonts/gobold/GoboldThinLight-Italic.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoboldThinLight-Italic.ttf \
    vendor/colt/prebuilt/fonts/roadrage/road_rage.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/RoadRage-Regular.ttf \
    vendor/colt/prebuilt/fonts/neoneon/neoneon.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Neoneon-Regular.ttf \
    vendor/colt/prebuilt/fonts/mexcellent/mexcellent.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Mexcellent-Regular.ttf \
    vendor/colt/prebuilt/fonts/burnstown/burnstown.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Burnstown-Regular.ttf \
    vendor/colt/prebuilt/fonts/dumbledor/dumbledor.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Dumbledor-Regular.ttf \
    vendor/colt/prebuilt/fonts/PhantomBold/PhantomBold.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/PhantomBold-Regular.ttf \
    vendor/colt/prebuilt/fonts/snowstorm/snowstorm.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Snowstorm-Regular.ttf \
    vendor/colt/prebuilt/fonts/vcrosd/vcr_osd_mono.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/ThemeableFont-Regular.ttf \
    vendor/colt/prebuilt/fonts/Shamshung/Shamshung.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Shamshung.ttf \
    vendor/colt/prebuilt/fonts/Aclonica/Aclonica.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Aclonica.ttf \
    vendor/colt/prebuilt/fonts/Amarante/Amarante.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Amarante.ttf \
    vendor/colt/prebuilt/fonts/Bariol/Bariol-Regular.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Bariol.ttf \
    vendor/colt/prebuilt/fonts/Cagliostro/Cagliostro-Regular.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Cagliostro-Regular.ttf \
    vendor/colt/prebuilt/fonts/Coolstory/Coolstory-Regular.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Coolstory-Regular.ttf \
    vendor/colt/prebuilt/fonts/LGSmartGothic/LGSmartGothic.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/LGSmartGothic.ttf \
    vendor/colt/prebuilt/fonts/Rosemary/Rosemary-Regular.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Rosemary-Regular.ttf \
    vendor/colt/prebuilt/fonts/SonySketch/SonySketch.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/SonySketch.ttf \
    vendor/colt/prebuilt/fonts/Surfer/Surfer.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/Surfer.ttf

# Inclusion of colt specific files
-include vendor/colt/config/version.mk

# Enable ccache
USE_CCACHE := true
