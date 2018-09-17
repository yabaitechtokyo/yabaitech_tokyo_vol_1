
all: maswag-deps
	cd main && satysfi -b template.saty -o ../template.pdf
maswag-deps:
	make -C MasWag deps
