//
//  com_blissapplications_ble_BluetoothDescriptor.m
//  ble-jni-xcode6
//
//  Created by Tiago Janela on 8/6/18.
//
//

#include <jni.h>
#include "com_blissapplications_ble_BluetoothDescriptor.h"
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BJObjectBuilder.h"

JNIEXPORT jobject JNICALL Java_com_blissapplications_ble_BluetoothDescriptor_getIdentifier
(JNIEnv *env, jobject javaDescriptor, jlong descriptorHandle){
    @autoreleasepool{
        CBDescriptor* descriptor = (CBDescriptor*) descriptorHandle;
        CBUUID *uuid = [descriptor UUID];
        return [BJObjectBuilder buildUUIDFromCBUUID:uuid env:env];
    }
}