/// @author YellowAfterlife

#include "stdafx.h"
#include "zlib.h"
#include <stdio.h>

#define dllx extern "C" __declspec(dllexport)
#define trace(...) { printf(__VA_ARGS__); printf("\n"); fflush(stdout); }

#pragma region Status
int buffer_zlib_status = Z_OK;
dllx double buffer_zlib_get_status() { return buffer_zlib_status; }
///:
enum buffer_zlib_status {
    buffer_zlib_status_ok = 0,
    buffer_zlib_status_stream_error = -2,
    buffer_zlib_status_data_error = -3,
    buffer_zlib_status_memory_error = -4,
    buffer_zlib_status_buffer_error = -5,
};
#pragma endregion

#pragma region Deflate
z_stream buffer_deflate_stream;
dllx double buffer_deflate_raw1(char* source, double offset, double length, double level) {
    buffer_zlib_status = deflateInit(&buffer_deflate_stream, (int)level);
    if (buffer_zlib_status != Z_OK) return 0;
    buffer_deflate_stream.avail_in = (uInt)length;
    buffer_deflate_stream.next_in = (Byte*)(source + (size_t)offset);
    return 1;
}
dllx double buffer_deflate_raw2(char* out, double start, double till) {
    uInt pos = (uInt)start;
    uInt size = (uInt)till - pos;
    buffer_deflate_stream.avail_out = size;
    buffer_deflate_stream.next_out = (Byte*)(out + (size_t)pos);
    buffer_zlib_status = deflate(&buffer_deflate_stream, Z_FINISH);
    if (buffer_zlib_status == Z_STREAM_ERROR) {
        deflateEnd(&buffer_deflate_stream);
        return -1;
    }
    if (buffer_deflate_stream.avail_out != 0) deflateEnd(&buffer_deflate_stream);
    return buffer_deflate_stream.avail_out;
}
#pragma endregion

#pragma region Inflate
z_stream buffer_inflate_stream;
dllx double buffer_inflate_raw1(char* source, double offset, double size) {
    buffer_zlib_status = inflateInit(&buffer_inflate_stream);
    if (buffer_zlib_status != Z_OK) return 0;
    buffer_inflate_stream.avail_in = (uInt)size;
    buffer_inflate_stream.next_in = (Byte*)(source + (size_t)offset);
    return 1;
}
dllx double buffer_inflate_raw2(char* out, double start, double till) {
    uInt pos = (uInt)start;
    uInt size = (uInt)till - pos;
    buffer_inflate_stream.avail_out = size;
    buffer_inflate_stream.next_out = (Byte*)(out + (size_t)pos);
    buffer_zlib_status = inflate(&buffer_inflate_stream, Z_NO_FLUSH);
    switch (buffer_zlib_status) {
        case Z_NEED_DICT:
        case Z_DATA_ERROR:
        case Z_MEM_ERROR:
        case Z_STREAM_ERROR:
            inflateEnd(&buffer_inflate_stream);
            return -1;
    }
    if (buffer_inflate_stream.avail_out != 0) inflateEnd(&buffer_inflate_stream);
    return buffer_inflate_stream.avail_out;
}
#pragma endregion

dllx double buffer_zlib_init_raw() {
    buffer_deflate_stream.zalloc = Z_NULL;
    buffer_deflate_stream.zfree = Z_NULL;
    buffer_deflate_stream.opaque = Z_NULL;
    buffer_inflate_stream.zalloc = Z_NULL;
    buffer_inflate_stream.zfree = Z_NULL;
    buffer_inflate_stream.opaque = Z_NULL;
    return 1;
}