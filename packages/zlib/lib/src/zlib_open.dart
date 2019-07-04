import "dart:ffi";

import "./ffi/dylib_utils.dart";

DynamicLibrary zlib = dlopenPlatformSpecific("z");
