import "dart:ffi";

import "./ffi/dylib_utils.dart";
import "./ffi/cstring.dart";

DynamicLibrary sqlite = dlopenPlatformSpecific("z");

typedef Zlib_zlibVersion_t = CString Function();

Zlib_zlibVersion_t _zlibVersionC = sqlite
    .lookup<NativeFunction<Zlib_zlibVersion_t>>("zlibVersion")
    .asFunction();

final zlibVersion = () => CString.fromUtf8(_zlibVersionC());
