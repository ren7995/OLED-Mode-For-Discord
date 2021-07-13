ARCHS = armv7 arm64 arm64e
TARGET := iphone:clang:latest:6.0
INSTALL_TARGET_PROCESSES = Discord
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = OLEDModeforDiscord

OLEDModeforDiscord_FILES = $(wildcard Hooks/*.m)
OLEDModeforDiscord_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
