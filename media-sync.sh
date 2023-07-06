#!/bin/bash
REM_PATH="charger::Media/TV/TV/"
LOC_PATH="/media/porn/NewDrive/TV/"
REM_USER="swerv"
PASS_FILE="/home/pi/rsync_pass"

TEMP_FILE="/dev/shm/rsync_temp"

echo -e "Number of files that don't exist on the Remote"
rsync -vrun --password-file="${PASS_FILE}" "${LOC_PATH}" "${REM_USER}@${REM_PATH}" | grep '[^/]&' > "${TEMP_FILE}"

difs=$(wc -l < "${TEMP_FILE}")

if (("$difs" > 3)); then
    ((difs=difs - 3))
fi

echo "$difs"

while (("$difs" > 3)); do
    read -p "Would you like to see the differences? " yn
    case $yn in
        [Yy]* ) less "$TEMP_FILE"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo -e "\n\nNumber of files that don't exist locally"
rsync -vrun --password-file="${PASS_FILE}" --exclude '.*' "${REM_USER}@${REM_PATH}" "${LOC_PATH}" | grep '[^/]$' > "${TEMP_FILE}"

difs=$(wc -l < "${TEMP_FILE}")

if (("$difs" > 3)); then
    ((difs=difs - 3))
fi

echo "$difs"

while (("$difs" > 3)); do
    read -p "Would you like to see the differences? " yn
    case $yn in
        [Yy]* ) less "$TEMP_FILE"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo -e "\n\nDiff Complete"

