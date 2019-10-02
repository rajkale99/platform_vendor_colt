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

COLT_TAG=Andy10
COLT_VERSION := v5.1

# COLT RELEASE VERSION
ifndef COLT_BUILD_TYPE
    COLT_BUILD_TYPE := Unofficial
endif

TARGET_PRODUCT_SHORT := $(subst colt_,,$(COLT_BUILD_TYPE))


COLT_DATE := $(shell date -u +%d-%m-%Y)

COLT_FINGERPRINT := ColtOS-Andy10-$(COLT_VERSION)/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%Y%m%d)/$(shell date -u +%H%M)

COLT_BUILD_VERSION := ColtOS-$(COLT_TAG)-$(COLT_VERSION)-$(COLT_BUILD_TYPE)-$(shell date -u +%Y%m%d)
