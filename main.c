#include <ppm.h>
#include <stdio.h>
#include "ppm_reader.h"

void dark(pixel**, int, int);

void usage(char* program_name) {
	printf("%s file_name.ppm\n", program_name);
}

int main(int argc, char** argv) {
	int c, r;
	pixval pv;
	FILE* f;
	if (argc != 2) {
		usage(argv[0]);
	}
	pixel** p = ppm_read(argv[1], &c, &r, &pv);
	dark(p, c, r);

	f = fopen("out.ppm", "wb");
	ppm_writeppm(f, p, c, r, pv, 1);
	
	return 0;
}
