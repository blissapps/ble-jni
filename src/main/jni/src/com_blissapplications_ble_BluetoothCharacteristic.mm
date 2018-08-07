//
//  com_blissapplications_ble_BluetoothCharacteristic.m
//  ble-jni
//
//  Created by Tiago Janela on 06/08/2018.
//

#include <jni.h>
#include "com_blissapplications_ble_BluetoothCharacteristic.h"
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BJObjectBuilder.h"

JNIEXPORT jobject JNICALL Java_com_blissapplications_ble_BluetoothCharacteristic_getIdentifier
(JNIEnv *env, jobject javaCharacteristic, jlong characteristicHandle) {
    @autoreleasepool{
        CBCharacteristic* characteristic = (CBCharacteristic*) characteristicHandle;
        CBUUID *uuid = [characteristic UUID];
        return [BJObjectBuilder buildUUIDFromCBUUID:uuid env:env];
    }
}

JNIEXPORT jobjectArray JNICALL Java_com_blissapplications_ble_BluetoothCharacteristic_getDescriptors
(JNIEnv *env, jobject characteristicJava, jlong characteristicHandle){
    @autoreleasepool{
        CBCharacteristic* characteristic = (CBCharacteristic*) characteristicHandle;
        NSArray *descriptors = [characteristic descriptors];
        return [BJObjectBuilder buildDescriptorObjectArrayFrom:descriptors env:env];
    }
}

JNIEXPORT jobject JNICALL Java_com_blissapplications_ble_BluetoothCharacteristic_getProperties
(JNIEnv *env, jobject characteristicJava, jlong characteristicHandle){
    @autoreleasepool{
        CBCharacteristic* characteristic = (CBCharacteristic*) characteristicHandle;
        CBCharacteristicProperties properties = [characteristic properties];
        return [BJObjectBuilder buildCharacteristicPropertiesFrom:properties env:env];
    }
}