read_string(String) :- current_input(Stream),
                       read_line_to_codes(Stream, Input),
                       string_codes(String, Input).