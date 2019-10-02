APP_NAME="$1"
OUTPUT_BACKUP="${APP_NAME}_backup.ab"
EXTRACTED="${APP_NAME}_extracted"
DECOMPRESSED="${APP_NAME}_decompressed.tar"


# Will prompt for a password in the phone
adb backup -f "${OUTPUT_BACKUP}" -noapk "${APP_NAME}"

# Extract
dd if="${OUTPUT_BACKUP}" bs=1 skip=24 > ${EXTRACTED}

# Decompress
printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" | cat - ${EXTRACTED} | gunzip -c > ${DECOMPRESSED}

# Untar
tar xf ${DECOMPRESSED}

# Clean
rm ${OUTPUT_BACKUP} ${EXTRACTED} ${DECOMPRESSED}

