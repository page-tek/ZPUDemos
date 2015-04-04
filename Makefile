
all:
	make -C Dhrystone_fast/Firmware
	make -C Dhrystone_min/Firmware
	make -C HelloTinyROM/Firmware
	make -C HelloWorld/Firmware
	make -C HelloTinyZPU/Firmware
	make -C Interrupt/Firmware
	make -C RS232Bootstrap/Firmware
	make -C SDBootstrap/Firmware
	make -C SDRAM/Firmware
	make -C VGA/Firmware
	make -C TFT/Firmware
	make -C TFT/Software
	make -C Apps

clean:
	make -C Dhrystone_fast/Firmware clean
	make -C Dhrystone_min/Firmware clean
	make -C HelloTinyROM/Firmware clean
	make -C HelloWorld/Firmware clean
	make -C HelloTinyZPU/Firmware clean
	make -C Interrupt/Firmware clean
	make -C RS232Bootstrap/Firmware clean
	make -C SDBootstrap/Firmware clean
	make -C SDRAM/Firmware clean
	make -C VGA/Firmware clean
	make -C TFT/Firmware clean
	make -C TFT/Software clean
	make -C Apps clean


