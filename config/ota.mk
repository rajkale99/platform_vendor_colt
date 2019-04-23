# Copyright (C) 2018 The Pixel Dust Project
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

PRODUCT_PROPERTY_OVERRIDES += \
    com.colt.fingerprint=$(BUILD_VERSION) \
    ro.colt.device=$(TARGET_DEVICE) \
    ro.colt.ota.version=$(COLT_VERSION)

ifneq ($(filter colt_taimen,$(TARGET_PRODUCT)),)

PRODUCT_PACKAGES += \
    ColtOTA

endif
