import 'dart:async';
import 'dart:ffi' as ffi;

typedef NativeBinaryOp = ffi.Int32 Function(ffi.Int32, ffi.Int32);
typedef BinaryOp = int Function(int, int);

class Simple {
  static Future<String> get platformVersion async {
    final ex = ffi.DynamicLibrary.executable();
    final nativeSum = ex.lookupFunction<NativeBinaryOp, BinaryOp>("nativeSum");
    final result = nativeSum(31, 63);
    return result.toString();
  }
}
