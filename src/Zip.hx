package;

import gml.NativeString;
import gml.ds.ArrayList;
import gml.io.Buffer;

/**
 * ...
 * @author YellowAfterlife
 */
@:nativeGen
class Zip {
	static inline function main() { }
	
	//
	@:extern inline static var CENTRAL_DIRECTORY_RECORD_FIELDS_SIZE = 46;
	@:extern inline static var LOCAL_FILE_HEADER_FIELDS_SIZE = 30;
	
	//
	public var buffer:Buffer = new Buffer(128, Grow, 1);
	public var files:ArrayList<ZipEntry> = new ArrayList();
	public var open:Bool = true;
	public var compressionLevel:Int;
	
	@:keep @:doc public function new(compressionLevel:Int = -1) {
		this.compressionLevel = compressionLevel;
	}
	@:keep @:doc public function destroy() {
		buffer.destroy();
		buffer = Buffer.defValue;
		files.destroy();
		files = ArrayList.defValue;
		open = false;
	}
	
	#if sfgml.modern
	public static inline function crc32(buf:Buffer, pos:Int, len:Int):Int {
		return (untyped buffer_crc32)(buf, pos, len);
	}
	#else
	@:native("impl_crc32")
	public static function crc32(buf:Buffer, pos:Int, len:Int):Int {
		var init = 0xFFFFFFFF;
		var crc = init;
		for( i in pos ... pos + len ) {
			var tmp = (crc ^ buf.peekByte(i)) & 0xFF;
			for( j in 0...8 ) {
				if( tmp & 1 == 1 )
					tmp = (tmp >>> 1) ^ 0xEDB88320;
				else
					tmp >>>= 1;
			}
			crc = (crc >>> 8) ^ tmp;
		}
		return (crc ^ init) >>> 0;
	}
	#end
	
	inline function writeZipDate(o:Buffer, d:Date) {
		o.writeShort((d.getHours() << 11) | (d.getMinutes() << 5) | (d.getSeconds() >> 1));
		o.writeShort(((d.getFullYear() - 1980) << 9) | ((d.getMonth() + 1) << 5) | d.getDay());
	}
	
	@:native("impl_write")
	private static function addBufferImpl(dst:Buffer, src:Buffer, srcPos:Int, srcLen:Int) {
		var dstPos = dst.position;
		var dstNext = dstPos + srcLen;
		var dstSize = dst.size;
		if (dstNext > dstSize) {
			do {
				dstSize *= 2;
			} while (dstNext > dstSize);
			dst.resize(dstSize);
		}
		dst.copyFrom(dstPos, src, srcPos, srcLen);
		dst.position = dstNext;
	}
	
	static function adler32(buf:Buffer, pos:Int, len:Int):Int {
		var a1 = 1, a2 = 0;
		for( p in pos...pos + len ) {
			var c = buf.peekByte(pos);
			a1 = (a1 + c) % 65521;
			a2 = (a2 + a1) % 65521;
		}
		return (a2 << 16) | a1;
	}
	
	@:keep @:doc public function addBufferExt(path:String, buf:Buffer, pos:Int, len:Int, ?compressionLevel:Int) {
		if (!open) throw "Zip writer is already finalized.";
		if (compressionLevel == null) compressionLevel = this.compressionLevel;
		var compress = compressionLevel != 0;
		var o = this.buffer;
		o.writeInt(0x04034B50);
		o.writeShort(0x0014); // version
		o.writeShort(0x800); // flags = UTF8
		o.writeShort(compress ? 8 : 0);
		//
		var time = Date.now();
		writeZipDate(o, time);
		var crc = crc32(buf, pos, len);
		//
		var cbuf:Buffer = null;
		var clen = len;
		if (compress) {
			#if (sfgml_next)
			cbuf = buf.compress(pos, len);
			clen = cbuf.length - 6;
			#else
			cbuf = SfTools.raw("buffer_deflate")(buf, pos, len, compressionLevel);
			clen = cbuf.position - 6;
			#end
			//trace(cbuf.peekInt(cbuf.length - 4), adler32(cbuf, 2, cbuf.length - 6));
		}
		o.writeIntUnsigned(crc);
		o.writeInt(clen);
		o.writeInt(len);
		o.writeShort(NativeString.byteLength(path));
		o.writeShort(0);
		o.writeChars(path);
		var file:ZipEntry = {
			name : path,
			compressed : compress,
			clen : clen,
			size : len,
			crc : crc,
			date : time,
		};
		if (compress) {
			//trace(cbuf.peekShort(0));
			addBufferImpl(o, cbuf, 2, clen);
			cbuf.destroy();
		} else addBufferImpl(o, buf, pos, len);
		files.add(file);
	}
	
	@:keep @:doc public function addBuffer(path:String, buf:Buffer, ?compressionLevel:Int) {
		addBufferExt(path, buf, 0, buf.length, compressionLevel);
	}
	
	@:keep @:doc public function addFile(path:String, filePath:String, ?compressionLevel:Int) {
		var buf = Buffer.load(filePath);
		addBufferExt(path, buf, 0, buf.length, compressionLevel);
		buf.destroy();
	}
	
	function finalize() {
		open = false;
		var o = buffer;
		var cdr_size = 0;
		var cdr_offset = 0;
		for ( f in files ) {
			var namelen = NativeString.byteLength(f.name);
			var extraFieldsLength = 0;
			o.writeInt(0x02014B50); // header
			o.writeShort(0x0014); // version made-by
			o.writeShort(0x0014); // version
			o.writeShort(0x800); // flags = UTF8
			o.writeShort(f.compressed?8:0);
			writeZipDate(o, f.date);
			o.writeIntUnsigned(f.crc);
			o.writeInt(f.clen);
			o.writeInt(f.size);
			o.writeShort(namelen);
			o.writeShort(extraFieldsLength);
			o.writeShort(0); //comment length always 0
			o.writeShort(0); //disk number start
			o.writeShort(0); //internal file attributes
			o.writeInt(0); //external file attributes
			o.writeInt(cdr_offset); //relative offset of local header
			o.writeChars(f.name);
			cdr_size += CENTRAL_DIRECTORY_RECORD_FIELDS_SIZE + namelen + extraFieldsLength;
			cdr_offset += LOCAL_FILE_HEADER_FIELDS_SIZE + namelen + extraFieldsLength + f.clen;
		}
		//end of central dir signature
		o.writeInt(0x06054B50);
		//number of this disk
		o.writeShort(0);
		//number of the disk with the start of the central directory
		o.writeShort(0);
		//total number of entries in the central directory on this disk
		o.writeShort(files.length);
		//total number of entries in the central directory
		o.writeShort(files.length);
		//size of the central directory record
		o.writeInt(cdr_size);
		//offset of start of central directory with respect to the starting disk number
		o.writeInt(cdr_offset);
		// .ZIP file comment length
		o.writeShort(0);
	}
	
	/** Finalizes and saves the contents of this ZIP to given file */
	@:keep @:doc public function save(path:String) {
		if (open) finalize();
		buffer.savePart(path, 0, buffer.position);
	}
	
	/** Finalizes and returns this ZIP's buffer (note: destroyed by zip_destroy - make a copy) */
	@:keep @:doc public function getBuffer():Buffer {
		if (open) finalize();
		return buffer;
	}
}
@:nativeGen
typedef ZipEntry = {
	name : String,
	compressed : Bool,
	clen : Int,
	size : Int,
	crc : Int,
	date : Date,
}

