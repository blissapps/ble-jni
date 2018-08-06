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
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        NSUUID *uuid = [peripheral identifier];
        return [BJObjectBuilder buildUUIDFromNSUUID:uuid env:env];
    }
}

JNIEXPORT jint JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getState
(JNIEnv *env, jobject peripheral, jlong peripheralHandle) {
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        return [peripheral state];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_discoverServices
(JNIEnv *env, jobject peripheral, jlong peripheralHandle, jobjectArray services){
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        NSArray* serviceUUIDs = [BJObjectBuilder buildCBUUIDArrayFromUUIDObjectArray:services env:env];
        [peripheral discoverServices:serviceUUIDs];
    }

}

JNIEXPORT jobjectArray JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getServices
(JNIEnv *env, jobject peripheral, jlong peripheralHandle) {
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        NSArray* services = [[peripheral services] retain];
        return [BJObjectBuilder buildServiceObjectArrayFrom:services env:env];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_discoverCharacteristicsForService
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle, jobjectArray characteristics, jlong serviceHandle) {
    CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
    CBService *service = (CBService*) serviceHandle;
    NSArray* characteristicUUIDs = [BJObjectBuilder buildCBUUIDArrayFromUUIDObjectArray:characteristics env:env];
    [peripheral discoverCharacteristics:nil forService:service];
}
