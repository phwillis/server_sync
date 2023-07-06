#!/bin/bash
REM_PATH="charger::Media/"          # Path to the remote media folder
LOC_PATH="/media/NewDrive/"         # Path to your local media folder
REM_USER="name"                    # your username for the remote
PASS_FILE="/home/pi/rsync_pass"     # absolute path to the rsync password

TEMP_FILE="/dev/shm/rsync_temp"

echo -e "Number of files that don't exist on the Remote"
rsync -vrun --size-only --password-file="${PASS_FILE}" "${LOC_PATH}" "${REM_USER}@${REM_PATH}" | grep '[^/]&' > "${TEMP_FILE}"

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

while (("$difs" > 3)); do
    read -p "Would you like to push to ${REM_PATH}? " yn
    case $yn in
        [Yy]* ) rsync -a -uP --size-only --password-file="${PASS_FILE}" "${LOC_PATH}" "${REM_USER}@${REM_PATH}"; break;;
        [Nn]* ) echo -e "To push a specific directory, edit the path in the following command:\nrsync -a -uP --size-only --password-file=${PASS_FILE} ${LOC_PATH} ${REM_USER}@${REM_PATH}";break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo -e "\n\nNumber of files that don't exist locally"
rsync -vrun --size-only --password-file="${PASS_FILE}" --exclude '.*' "${REM_USER}@${REM_PATH}" "${LOC_PATH}" | grep '[^/]$' > "${TEMP_FILE}"

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

while (("$difs" > 3)); do
    read -p "Would you like to pull from ${REM_PATH}? " yn
    case $yn in
        [Yy]* ) rsync -a -uP --size-only --password-file="${PASS_FILE}" "${REM_USER}@${REM_PATH}" "${LOC_PATH}"; break;;
        [Nn]* ) echo -e "To pull from a specific directory, edit the path in the following command:\nrsync -a -uP --size-only --password-file=${PASS_FILE} ${REM_USER}@${REM_PATH} ${LOC_PATH}";break;;
        * ) echo "Please answer yes or no.";;
    esac
done
