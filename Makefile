CC=gcc
AS=as

ASFLAGS=
CFLAGS=-c -Wall -pedantic --std=c99
LFLAGS=-lnetpbm -g -Wall

OBJ=main.o ppm_reader.o dark.o

all: ppmdarker

ppmdarker: $(OBJ)
	$(CC) $(OBJ) $(LFLAGS) -o ppmdarker

%.o: %.c
	$(CC) $(CFLAGS) $<

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@	

clean:
	rm -rf *.o ppmdarker

