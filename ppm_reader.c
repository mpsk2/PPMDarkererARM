#include <ppm.h>
#include <stdio.h>
#include "ppm_reader.h"

pixel** ppm_read(const char* const path, int* columns, int* rows, pixval* maxvalP) {
	FILE* fb;
	pixel** pixels;
	fb = fopen(path, "rb");
	if (!fb) {
		fprintf(stderr, "file open error: %s\n", path);
		exit(1);
	}
	pixels = ppm_readppm(fb, columns, rows, maxvalP);
	return pixels;
}
