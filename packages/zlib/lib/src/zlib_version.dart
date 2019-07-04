
import "dart:ffi";

import "./ffi/cstring.dart";
import "./zlib_open.dart";

typedef Zlib_zlibVersion_t = CString Function();

Zlib_zlibVersion_t _zlibVersion_c = zlib
    .lookup<NativeFunction<Zlib_zlibVersion_t>>("zlibVersion")
    .asFunction();

final zlibVersion = () => CString.fromUtf8(_zlibVersion_c());
