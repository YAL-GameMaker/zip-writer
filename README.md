# zip-writer

**Quick links:** [itch.io page](https://yellowafterlife.itch.io/gamemaker-zip)

An adaptation of Haxe's standard library zip writer for use with GameMaker.

GMS2 version uses the buffer_compress function and is pure-GML (so should work on all platforms).  
GMS1 version requires my free buffer_zlib extension.

## Functions

- **zip_create(?compression_level)**  
  Creates a new Zip archive structure. Compression level can be 1..9 (from faster to better compression ratio), 0 (to skip compression), or -1 (to let runtime pick).  
  GMS2 version assumes all non-zero compression levels to be -1 because buffer_compress doesn't have an argument for compression level (you can also import the GMS1 version and buffer_zlib though).
- **zip_destroy(zip)**  
  Destroys a previously created Zip archive structure. Don't forget!
- **zip_add_file(zip, path, file_path)**  
  Adds a copy of the given file to a to a Zip structure.
  For nesting, include slashes in path (e.g. "dir/test.txt").
- **zip_add_buffer(zip, path, buffer)**  
  Adds a copy of the given buffer to a Zip structure.  
  Path handling is the same as with zip_add_file.
- **zip_add_buffer_ext(zip, path, buffer, pos, length)**  
  Same as zip_add_buffer but allows to only add a section of a buffer.
- **zip_save(zip, path)**  
  Finalizes the Zip structure (meaning that no new files can be written to it) and saves the archive to the given path.
- **zip_get_buffer(zip)**  
  Finalizes the Zip structure and returns it's internal buffer.  
  Current size will be indicated by the buffer's writing position (buffer_tell).  
  Note that the buffer will be destroyed by zip_destroy.
