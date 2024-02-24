arduino-cli compile --verbose --fqbn m5stack:esp32:m5stack_cardputer ./Launcher/Launcher.ino --output-dir ./support_files
arduino-cli compile --verbose --fqbn m5stack:esp32:m5stack_cardputer ./StartApp/StartApp.ino  --output-dir ./support_files
cd ./support_files
esptool -p COMx \
        -b 460800 \
        --before default_reset \
        --after hard_reset \
        --chip esp32s3 write_flash \
        --flash_mode dio \
        --flash_freq 80m \
        --flash_size detect 0x0 bootloader_CP.bin 0x8000 partition-table_8Mb.bin 0xe000 ota_data_initial.bin 0x10000 Launcher.ino.bin  0xf0000 StartApp.ino.bin
