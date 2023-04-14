from pathlib import Path


def is_mobile_device():
    return Path("/proc/acpi/button/lid").exists()
