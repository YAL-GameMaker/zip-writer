function trace() {
	var r = string(argument[0]), i = 0;
	repeat (argument_count - 1) {
	    r += " " + string(argument[++i]);
	}
	show_debug_message(r);



}
