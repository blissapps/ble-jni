#include <jni.h>
#include <iostream>
#include "com_blissapplications_ble_BluetoothPeripheral.h"
#import <CoreFoundation/CoreFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "CBCentralManagerDelegateImpl.h"

using namespace std;

JNIEXPORT jstring JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getIdentifier
(JNIEnv * env, jobject, jlong peripheralHandle){
    CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
    NSUUID *uuid = [peripheral identifier];
    NSString *string = [uuid UUIDString];
    jstring result = env->NewStringUTF([string UTF8String]);
    if(env->ExceptionOccurred()){
        env->ExceptionDescribe();
        env->ExceptionClear();
    }
    return result;
}
