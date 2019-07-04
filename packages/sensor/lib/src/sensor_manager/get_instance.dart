import "dart:ffi" as ffi;
import 'package:sensor/src/ffi/cstring.dart';

import "../ffi/dylib_utils.dart";

// import "./ffi/cstring.dart";

ffi.DynamicLibrary libandroid = dlopenPlatformSpecific("android");

@ffi.struct
class ASensorManager extends ffi.Pointer<ffi.Void> {}

typedef ASensorManager_getInstance_t = ASensorManager Function();

ASensorManager_getInstance_t ASensorManager_getInstance = libandroid
    .lookup<ffi.NativeFunction<ASensorManager_getInstance_t>>(
        "ASensorManager_getInstance")
    .asFunction();

final getInstance = ASensorManager_getInstance;

@ffi.struct
class ASensor extends ffi.Pointer<ffi.Void> {}

class ASensorList extends ffi.Pointer<ASensor> {}

typedef ASensorManager_getSensorList_c = ffi.Int32 Function(
    ASensorManager manager, ffi.Pointer<ASensorList> list);
typedef ASensorManager_getSensorList_dart = int Function(
    ASensorManager manager, ffi.Pointer<ASensorList> list);

ASensorManager_getSensorList_dart ASensorManager_getSensorList = libandroid
    .lookup<ffi.NativeFunction<ASensorManager_getSensorList_c>>(
        "ASensorManager_getSensorList")
    .asFunction();

typedef ASensor_getName_c = CString Function(ASensor sensor);

ASensor_getName_c ASensor_getName = libandroid
    .lookup<ffi.NativeFunction<ASensor_getName_c>>("ASensor_getName")
    .asFunction();

int getSensorList() {
  final instance = ASensorManager_getInstance();
  print('returnInt ${instance}');
  ffi.Pointer<ASensorList> list = ffi.allocate<ASensorList>(count: 30);

  final sensor_count = ASensorManager_getSensorList(instance, list);
  print('sensor_count $sensor_count list ${list}');

  final ASensorList aSensorList = list.load();

  for (var i = 0; i < sensor_count; i++) {
    CString sensor_name_1 = ASensor_getName(aSensorList.elementAt(i).load());
    String sensor_name_1_string = CString.fromUtf8(sensor_name_1);
    print('sensor_name_1 $sensor_name_1_string}');
  }

  return -127;
}
