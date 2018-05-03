var z = zip_create();
//
screen_save("screen.png");
zip_add_file(z, "test.png", "screen.png");
//
var b = buffer_create(32, buffer_grow, 1);
buffer_write(b, buffer_text, "All is well!");
zip_add_buffer_ext(z, "test.txt", b, 0, buffer_tell(b));
buffer_delete(b);
//
zip_save(z, "test.zip");
zip_destroy(z);
