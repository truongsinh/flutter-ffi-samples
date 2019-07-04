import "dart:ffi";

import "./ffi/cstring.dart";
import "./zlib_open.dart";


@struct
class z_streamp extends Pointer<Void> {
  @IntPtr()
  int next_in;
  @Uint32()
  int avail_in;
  @Uint64()
  int total_in;

  @IntPtr()
  int next_out;
  @Uint32()
  int avail_out;
  @Uint64()
  int total_out;

  @IntPtr()
  /* CString */ int msg;

  @IntPtr()
  int zalloc;
  @IntPtr()
  int zfree;
  
  @IntPtr()
  int opaque;

  @Int32()
  int data_type;
  @Uint64()
  int adler;
  @Uint64()
  int reserved;
}

typedef Zlib_deflateInit_t = Int32 Function(z_streamp strm, Int32 level);
typedef Zlib_deflateInit_t_dart = int Function(z_streamp strm, int level);

Zlib_deflateInit_t_dart _deflateInit_c =
    zlib.lookup<NativeFunction<Zlib_deflateInit_t>>("deflate").asFunction();

int deflateInit()  {
  final strm = z_streamp();
  final ret = _deflateInit_c(strm, 2);
  return ret;
}
