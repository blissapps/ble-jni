#include <jni.h>
#include <iostream>
#include "com_blissapplications_ble_BluetoothPeripheral.h"
#import <CoreFoundation/CoreFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BJCentralManagerDelegateImpl.h"
#import "BJObjectBuilder.h"

using namespace std;

JNIEXPORT jobject JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getIdentifier
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle){
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        NSUUID *uuid = [peripheral identifier];
        return [BJObjectBuilder buildUUIDFromNSUUID:uuid env:env];
    }
}

JNIEXPORT jstring JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getName
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle) {
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        NSString* name = [peripheral name];
        return [BJObjectBuilder buildStringFrom:name env:env];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_discoverServices
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle, jobjectArray services){
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        NSArray* serviceUUIDs = [BJObjectBuilder buildCBUUIDArrayFromUUIDObjectArray:services env:env];
        [peripheral discoverServices:serviceUUIDs];
    }
    
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_discoverIncludedServices
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle, jobjectArray services, jlong serviceHandle) {
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        CBService *service = (CBService*) serviceHandle;
        NSArray* serviceUUIDs = [BJObjectBuilder buildCBUUIDArrayFromUUIDObjectArray:services env:env];
        [peripheral discoverIncludedServices:serviceUUIDs forService:service];
    }
}

JNIEXPORT jobjectArray JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getServices
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle) {
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        NSArray* services = [peripheral services];
        return [BJObjectBuilder buildServiceObjectArrayFrom:services env:env];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_discoverCharacteristicsForService
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle, jobjectArray characteristics, jlong serviceHandle) {
    @autoreleasepool{
        NSArray* characteristicUUIDs = [BJObjectBuilder buildCBUUIDArrayFromUUIDObjectArray:characteristics env:env];
        characteristicUUIDs = characteristicUUIDs.count == 0 ? nil : characteristicUUIDs;
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        CBService *service = (CBService*) serviceHandle;
        [peripheral discoverCharacteristics:characteristicUUIDs forService:service];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_discoverDescriptorsForCharacteristic
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle, jlong characteristicHandle){
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        CBCharacteristic *characteristic = (CBCharacteristic*) characteristicHandle;
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_readValueForCharacteristic
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle, jlong characteristicHandle) {
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        CBCharacteristic *characteristic = (CBCharacteristic*) characteristicHandle;
        [peripheral readValueForCharacteristic:characteristic];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_readValueForDescriptor
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle, jlong descriptorHandle){
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        CBDescriptor *descriptor = (CBDescriptor*) descriptorHandle;
        [peripheral readValueForDescriptor:descriptor];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_writeValueForCharacteristic
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle, jbyteArray javaValue, jlong characteristicHandle, jobject writeTypeJava){
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        CBCharacteristic *characteristic = (CBCharacteristic*) characteristicHandle;
        NSData *value = [BJObjectBuilder buildNSDataFromByteArray:javaValue env:env];
        CBCharacteristicWriteType writeType = [BJObjectBuilder buildCBCharacteristicWriteTypeFromWriteType:writeTypeJava env:env];
        [peripheral writeValue:value forCharacteristic:characteristic type:writeType];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_writeValueForDescriptor
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle, jbyteArray javaValue, jlong descriptorHandle) {
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        CBDescriptor *descriptor = (CBDescriptor*) descriptorHandle;
        NSData *value = [BJObjectBuilder buildNSDataFromByteArray:javaValue env:env];
        [peripheral writeValue:value forDescriptor:descriptor];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_setNotifyValueForCharacteristic
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle, jlong characteristicHandle, jboolean value){
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        CBCharacteristic *characteristic = (CBCharacteristic*) characteristicHandle;
        [peripheral setNotifyValue:value forCharacteristic:characteristic];
    }
}

JNIEXPORT jint JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getState
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle) {
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        return [peripheral state];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_readRSSI
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle){
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        [peripheral readRSSI];
    }
}

JNIEXPORT jdouble JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getRSSI
(JNIEnv *env, jobject javaPeripheral, jlong peripheralHandle){
    @autoreleasepool{
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        double rssi = [[peripheral RSSI] doubleValue];
        return rssi;
    }
}
