#include <jni.h>
#include <iostream>
#include "com_blissapplications_ble_BluetoothPeripheral.h"
#import <CoreFoundation/CoreFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BJCentralManagerDelegateImpl.h"
#import "BJObjectBuilder.h"

using namespace std;

JNIEXPORT jobject JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getIdentifier
    (JNIEnv *env, jobject, jlong peripheralHandle){
    CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
    NSUUID *uuid = [peripheral identifier];
    return [BJObjectBuilder uuidFromNSUUID:uuid env:env];
}
