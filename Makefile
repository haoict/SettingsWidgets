INSTALL_TARGET_PROCESSES = Preferences
export ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SettingsWidgets

SettingsWidgets_FILES = Tweak.x SWWidgetContainerView.m SWBatteryWidgetView.m SWStorageWidgetView.m SWDiskUsageView.m
SettingsWidgets_CFLAGS = -fobjc-arc -Wno-unused-function
SettingsWidgets_FRAMEWORKS = IOKit

include $(THEOS_MAKE_PATH)/tweak.mk
#SUBPROJECTS += settingsinfoprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
