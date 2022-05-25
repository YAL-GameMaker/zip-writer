/// @lint nullToAny true
// Feather disable all
globalvar mq_zip_std_Date; mq_zip_std_Date = [undefined, /* 1:date */undefined];
globalvar mq_zip_std_haxe_class; mq_zip_std_haxe_class = [undefined, /* 1:marker */undefined, /* 2:index */0, /* 3:name */undefined, /* 4:superClass */undefined, /* 5:constructor */undefined];
globalvar zip_std_haxe_type_markerValue; zip_std_haxe_type_markerValue = [];
globalvar mt_zip_std_Date; mt_zip_std_Date = zip_std_haxe_class_create(7, "zip_std_Date");
globalvar mt_zip_std_haxe_class; mt_zip_std_haxe_class = zip_std_haxe_class_create(9, "zip_std_haxe_class");

#define zip_std_Date_create
// zip_std_Date_create(year:int, month:int, day:int, hour:int, min:int, sec:int)
var _this = [mt_zip_std_Date];
array_copy(_this, 1, mq_zip_std_Date, 1, 1);
/// @typedef {tuple<any,date:date>} zip_std_Date
_this[@1/* date */] = date_create_datetime(argument[0], argument[1] + 1, argument[2], argument[3], argument[4], argument[5]);
return _this;

#define zip_std_Date_now
// zip_std_Date_now()->zip_std_Date
var _d = zip_std_Date_create(2000, 0, 1, 0, 0, 0);
_d[@1/* date */] = date_current_datetime();
return _d;

#define zip_create
// zip_create(compressionLevel:int = -1)
var _this = array_create(4);
/// @typedef {tuple<buffer:buffer,files:ds_list<ZipEntry>,open:bool,compression_level:int>} zip
var _compressionLevel;
if (argument_count > 0) _compressionLevel = argument[0]; else _compressionLevel = -1;
_this[@2/* open */] = true;
_this[@1/* files */] = ds_list_create();
_this[@0/* buffer */] = buffer_create(128, buffer_grow, 1);
_this[@3/* compression_level */] = _compressionLevel;
return _this;

#define zip_impl_crc32
// zip_impl_crc32(buf:buffer, pos:int, len:int)->int
var _buf = argument[0], _pos = argument[1];
var _init = -1;
var _crc = _init;
var _i = _pos;
for (var __g1 = _pos + argument[2]; _i < __g1; ++_i) {
	var _tmp = ((_crc ^ buffer_peek(_buf, _i, buffer_u8)) & 255);
	if ((_tmp & 1) == 1) _tmp = ((((_tmp & $FFFFFFFF) >> 1)) ^ -306674912); else _tmp = ((_tmp & $FFFFFFFF) >> 1);
	if ((_tmp & 1) == 1) _tmp = ((((_tmp & $FFFFFFFF) >> 1)) ^ -306674912); else _tmp = ((_tmp & $FFFFFFFF) >> 1);
	if ((_tmp & 1) == 1) _tmp = ((((_tmp & $FFFFFFFF) >> 1)) ^ -306674912); else _tmp = ((_tmp & $FFFFFFFF) >> 1);
	if ((_tmp & 1) == 1) _tmp = ((((_tmp & $FFFFFFFF) >> 1)) ^ -306674912); else _tmp = ((_tmp & $FFFFFFFF) >> 1);
	if ((_tmp & 1) == 1) _tmp = ((((_tmp & $FFFFFFFF) >> 1)) ^ -306674912); else _tmp = ((_tmp & $FFFFFFFF) >> 1);
	if ((_tmp & 1) == 1) _tmp = ((((_tmp & $FFFFFFFF) >> 1)) ^ -306674912); else _tmp = ((_tmp & $FFFFFFFF) >> 1);
	if ((_tmp & 1) == 1) _tmp = ((((_tmp & $FFFFFFFF) >> 1)) ^ -306674912); else _tmp = ((_tmp & $FFFFFFFF) >> 1);
	if ((_tmp & 1) == 1) _tmp = ((((_tmp & $FFFFFFFF) >> 1)) ^ -306674912); else _tmp = ((_tmp & $FFFFFFFF) >> 1);
	_crc = ((((_crc & $FFFFFFFF) >> 8)) ^ _tmp);
}
return (((_crc ^ _init) & $FFFFFFFF));

#define zip_impl_write
// zip_impl_write(dst:buffer, src:buffer, srcPos:int, srcLen:int)
var _dst = argument[0], _src = argument[1], _srcLen = argument[3];
var _dstPos = buffer_tell(_dst);
var _dstNext = _dstPos + _srcLen;
var _dstSize = buffer_get_size(_dst);
if (_dstNext > _dstSize) {
	while (true) {
		_dstSize *= 2;
		if (_dstNext <= _dstSize) break;
	}
	buffer_resize(_dst, _dstSize);
}
buffer_copy(_src, argument[2], _srcLen, _dst, _dstPos);
buffer_seek(_dst, buffer_seek_start, _dstNext);

#define zip_destroy
// zip_destroy(this:zip)
var _this = argument[0];
buffer_delete(_this[0/* buffer */]);
_this[@0/* buffer */] = -1;
ds_list_destroy(_this[1/* files */]);
_this[@1/* files */] = -1;
_this[@2/* open */] = false;

#define zip_add_buffer_ext
// zip_add_buffer_ext(this:zip, path:string, buf:buffer, pos:int, len:int, ?compressionLevel:int)
var _this = argument[0], _path1 = argument[1], _buf = argument[2], _pos = argument[3], _len = argument[4], _compressionLevel;
if (argument_count > 5) _compressionLevel = argument[5]; else _compressionLevel = undefined;
if (!_this[2/* open */]) show_error(string("Zip writer is already finalized."), false);
if (_compressionLevel == undefined) _compressionLevel = _this[3/* compression_level */];
var _compress = _compressionLevel != 0;
var _o = _this[0/* buffer */];
buffer_write(_o, buffer_s32, 67324752);
buffer_write(_o, buffer_u16, 20);
buffer_write(_o, buffer_u16, 2048);
buffer_write(_o, buffer_u16, (_compress ? 8 : 0));
var _time = zip_std_Date_now();
buffer_write(_o, buffer_u16, (((date_get_hour(_time[1/* date */]) << 11) | (date_get_minute(_time[1/* date */]) << 5)) | (date_get_second(_time[1/* date */]) >> 1)));
buffer_write(_o, buffer_u16, (((date_get_year(_time[1/* date */]) - 1980 << 9) | (date_get_month(_time[1/* date */]) - 1 + 1 << 5)) | date_get_weekday(_time[1/* date */])));
var _crc = zip_impl_crc32(_buf, _pos, _len);
var _cbuf = undefined;
var _clen = _len;
if (_compress) {
	_cbuf = buffer_compress(_buf, _pos, _len);
	_clen = buffer_get_size(_cbuf) - 6;
}
buffer_write(_o, buffer_u32, _crc);
buffer_write(_o, buffer_s32, _clen);
buffer_write(_o, buffer_s32, _len);
buffer_write(_o, buffer_u16, string_byte_length(_path1));
buffer_write(_o, buffer_u16, 0);
buffer_write(_o, buffer_text, _path1);
var _file = [/* name: */_path1, /* compressed: */_compress, /* clen: */_clen, /* size: */_len, /* crc: */_crc, /* date: */_time];
if (_compress) {
	zip_impl_write(_o, _cbuf, 2, _clen);
	buffer_delete(_cbuf);
} else zip_impl_write(_o, _buf, _pos, _len);
ds_list_add(_this[1/* files */], _file);

#define zip_add_buffer
// zip_add_buffer(this:zip, path:string, buf:buffer, ?compressionLevel:int)
var _this = argument[0], _buf = argument[2], _compressionLevel;
if (argument_count > 3) _compressionLevel = argument[3]; else _compressionLevel = undefined;
zip_add_buffer_ext(_this, argument[1], _buf, 0, buffer_get_size(_buf), _compressionLevel);

#define zip_add_file
// zip_add_file(this:zip, path:string, filePath:string, ?compressionLevel:int)
var _this = argument[0], _compressionLevel;
if (argument_count > 3) _compressionLevel = argument[3]; else _compressionLevel = undefined;
var _buf = buffer_load(argument[2]);
zip_add_buffer_ext(_this, argument[1], _buf, 0, buffer_get_size(_buf), _compressionLevel);
buffer_delete(_buf);

#define zip_finalize
// zip_finalize(this:zip)
var _this = argument[0];
_this[@2/* open */] = false;
var _o = _this[0/* buffer */];
var _cdr_size = 0;
var _cdr_offset = 0;
var __g_list = _this[1/* files */];
var __g_index = 0;
while (__g_index < ds_list_size(__g_list)) {
	var _f = __g_list[|__g_index++];
	var _namelen = string_byte_length(_f[0/* name */]);
	var _extraFieldsLength = 0;
	buffer_write(_o, buffer_s32, 33639248);
	buffer_write(_o, buffer_u16, 20);
	buffer_write(_o, buffer_u16, 20);
	buffer_write(_o, buffer_u16, 2048);
	buffer_write(_o, buffer_u16, (_f[1/* compressed */] ? 8 : 0));
	var _d = _f[5/* date */];
	buffer_write(_o, buffer_u16, (((date_get_hour(_d[1/* date */]) << 11) | (date_get_minute(_d[1/* date */]) << 5)) | (date_get_second(_d[1/* date */]) >> 1)));
	buffer_write(_o, buffer_u16, (((date_get_year(_d[1/* date */]) - 1980 << 9) | (date_get_month(_d[1/* date */]) - 1 + 1 << 5)) | date_get_weekday(_d[1/* date */])));
	buffer_write(_o, buffer_u32, _f[4/* crc */]);
	buffer_write(_o, buffer_s32, _f[2/* clen */]);
	buffer_write(_o, buffer_s32, _f[3/* size */]);
	buffer_write(_o, buffer_u16, _namelen);
	buffer_write(_o, buffer_u16, _extraFieldsLength);
	buffer_write(_o, buffer_u16, 0);
	buffer_write(_o, buffer_u16, 0);
	buffer_write(_o, buffer_u16, 0);
	buffer_write(_o, buffer_s32, 0);
	buffer_write(_o, buffer_s32, _cdr_offset);
	buffer_write(_o, buffer_text, _f[0/* name */]);
	_cdr_size += 46 + _namelen + _extraFieldsLength;
	_cdr_offset += 30 + _namelen + _extraFieldsLength + _f[2/* clen */];
}
buffer_write(_o, buffer_s32, 101010256);
buffer_write(_o, buffer_u16, 0);
buffer_write(_o, buffer_u16, 0);
buffer_write(_o, buffer_u16, ds_list_size(_this[1/* files */]));
buffer_write(_o, buffer_u16, ds_list_size(_this[1/* files */]));
buffer_write(_o, buffer_s32, _cdr_size);
buffer_write(_o, buffer_s32, _cdr_offset);
buffer_write(_o, buffer_u16, 0);

#define zip_save
// zip_save(this:zip, path:string)
var _this = argument[0];
if (_this[2/* open */]) zip_finalize(_this);
buffer_save_ext(_this[0/* buffer */], argument[1], 0, buffer_tell(_this[0/* buffer */]));

#define zip_get_buffer
// zip_get_buffer(this:zip)->buffer
var _this = argument[0];
if (_this[2/* open */]) zip_finalize(_this);
return _this[0/* buffer */];

#define zip_std_haxe_class_create
// zip_std_haxe_class_create(id:int, name:string)
var _this = ["mt_zip_std_haxe_class"];
array_copy(_this, 1, mq_zip_std_haxe_class, 1, 5);
/// @typedef {tuple<any,marker:any,index:int,name:string,superClass:haxe_class<any>,constructor:any>} zip_std_haxe_class
_this[@4/* superClass */] = undefined;
_this[@1/* marker */] = zip_std_haxe_type_markerValue;
_this[@2/* index */] = argument[0];
_this[@3/* name */] = argument[1];
return _this;

/// @typedef {any} ZipEntry