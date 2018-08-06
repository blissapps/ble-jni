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
        NSLog(@"characteristics: %@", characteristics);
        return [BJObjectBuilder buildCharacteristicObjectArrayFrom:characteristics env:env];
    }
}
