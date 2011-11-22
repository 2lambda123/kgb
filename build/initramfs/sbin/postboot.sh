#!/bin/sh
# Postboot script - runs at the end of init.rc

# Fake init.d support via busybox
/system/xbin/run-parts /system/etc/init.d

# Enable deep idle in sysfs, although it's currently broken
# Apparently a ROM-dependent problem. Don't set it for now
# echo 1 > /sys/class/misc/deepidle/enabled

# Reset internal storage readahead; may have been changed by some dumbfuck's init.d script
# 179:0 corresponds to mmcblk0. On SCH-I500, this is eMMC (/data etc.) and NOT /sdcard
echo 128 > /sys/devices/virtual/bdi/179:0/read_ahead_kb

# Set sdcard readahead on the correct device
# 4096 may be too high latency. 1024 is next fastest value, even better than 2048 or 3072
echo 1024 > /sys/devices/virtual/bdi/179:8/read_ahead_kb

# No need to include boot animation killer hack if the boot animation is named playlogos1
# or samsungani because the ROM kills either automatically
