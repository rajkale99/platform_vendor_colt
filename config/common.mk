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

# Common overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/colt/overlay/common
DEVICE_PACKAGE_OVERLAYS += vendor/colt/overlay/common

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/colt/prebuilt/common/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

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

# AR
PRODUCT_COPY_FILES += \
    vendor/colt/prebuilt/common/etc/calibration_cad.xml:system/etc/calibration_cad.xml

# Extra packages
PRODUCT_PACKAGES += \
    Launcher3 \
    messaging \
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
    vendor/colt/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions

# Priv-app config
PRODUCT_COPY_FILES += \
    vendor/colt/config/permissions/privapp-permissions-colt.xml:system/etc/permissions/privapp-permissions-colt.xml

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/colt/config/permissions/colt-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/colt-hiddenapi-package-whitelist.xml


# Colt packages
PRODUCT_PACKAGES += \
    GalleryGoPrebuilt \
    MarkupGoogle \
    SoundPickerPrebuilt

# ThemePicker
PRODUCT_PACKAGES += \
    ThemePicker

# Accents
PRODUCT_PACKAGES += \
    AccentColorYellowOverlay \
    AccentColorVioletOverlay \
    AccentColorTealOverlay \
    AccentColorRedOverlay \
    AccentColorQGreenOverlay \
    AccentColorPinkOverlay \
    AccentColorLightPurpleOverlay \
    AccentColorIndigoOverlay \
    AccentColorFlatPinkOverlay \
    AccentColorCyanOverlay \
    AccentColorBlueGrayOverlay

#OmniJaws
PRODUCT_PACKAGES += \
    OmniJaws \
    WeatherIcons

# Inclusion of colt specific files
-include vendor/colt/config/version.mk
