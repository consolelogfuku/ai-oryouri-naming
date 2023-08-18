serialized_data = "\x04\b{\aI\"\x10_csrf_token\x06:\x06EFI\"066EeFS5cOelfLn04a7pHgiVQby3GcriVtVBYUL0_5bM\x06;\x00FI\"\x0cuser_id\x06;\x00FI\"\a84\x06;\x00F"
deserialized_data = Marshal.load(serialized_data)
puts deserialized_data