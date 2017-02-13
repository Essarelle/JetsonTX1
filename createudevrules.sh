#!/bin/bash
# create custom rules for udev for mbzirc hardware
sudo cp config/99-fisheye.rules /etc/udev/rules.d/
sudo cp config/99-perspective.rules /etc/udev/rules.d/
sudo cp config/99-RTK_GPS.rules /etc/udev/rules.d/

# trigger changes to take effect
sudo udevadm control --reload-rules && udevadm trigger
