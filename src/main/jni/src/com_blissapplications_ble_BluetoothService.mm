//
//  com_blissapplications_ble_BluetoothService.m
//  ble-jni
//
//  Created by Tiago Janela on 06/08/2018.
//

#include <jni.h>
#include <iostream>
#include "com_blissapplications_ble_BluetoothService.h"
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BJObjectBuilder.h"

using namespace std;

JNIEXPORT jboolean JNICALL Java_com_blissapplications_ble_BluetoothService_isPrimary
(JNIEnv *env, jobject javaService, jlong serviceHandle){
    @autoreleasepool{
        CBService *service = (CBService*) serviceHandle;
        return [service isPrimary];
    }
}

JNIEXPORT jobject JNICALL Java_com_blissapplications_ble_BluetoothService_getIdentifier
(JNIEnv * env, jobject javaService, jlong serviceHandle) {
    @autoreleasepool{
        CBService *service = (CBService*) serviceHandle;
        CBUUID *uuid = [service UUID];
        return [BJObjectBuilder buildUUIDFromCBUUID:uuid env:env];
    }
}

JNIEXPORT jobjectArray JNICALL Java_com_blissapplications_ble_BluetoothService_getCharacteristics
(JNIEnv * env, jobject javaService, jlong serviceHandle) {
    @autoreleasepool{
        CBService *service = (CBService*) serviceHandle;
        NSArray *characteristics = [service characteristics];
        return [BJObjectBuilder buildCharacteristicObjectArrayFrom:characteristics env:env];
    }
}

JNIEXPORT jobjectArray JNICALL Java_com_blissapplications_ble_BluetoothService_getIncludedServices
(JNIEnv * env, jobject javaService, jlong serviceHandle) {
    @autoreleasepool{
        CBService *service = (CBService*) serviceHandle;
        NSArray *includedServices = [service includedServices];
        return [BJObjectBuilder buildServiceObjectArrayFrom:includedServices env:env];
    }
}
