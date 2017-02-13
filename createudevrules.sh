#!/bin/bash
# create custom rules for udev for mbzirc hardware
sudo cp config/99-fisheye.rules /etc/udev/rules.d/
sudo cp config/99-perspective.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && udevadm trigger
