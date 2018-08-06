#include <jni.h>
#include <iostream>
#include "com_blissapplications_ble_BluetoothCentralManager.h"
#import <CoreFoundation/CoreFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BJCentralManagerDelegateImpl.h"
#import "BJJNIUtils.h"
#import "BJObjectBuilder.h"
#import "BJJavaClasses.h"

using namespace std;

JNIEXPORT jlong JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_initialize
(JNIEnv* env, jobject javaCentralManager){
    @autoreleasepool{
        JavaVM* jvm = [BJJNIUtils javaVM:env];
        jobject javaCentralManagerGlobalRef = env->NewGlobalRef(javaCentralManager);
        CBCentralManagerDelegateImpl *delegateImpl = [[CBCentralManagerDelegateImpl alloc] initWithJavaCentralManager:javaCentralManagerGlobalRef andJavaVM:jvm];
        dispatch_queue_t queue = dispatch_queue_create("BLE-JNI", DISPATCH_QUEUE_SERIAL);
        __block CBCentralManager *centralManager = NULL;
        dispatch_sync(dispatch_get_main_queue(), ^{
            centralManager = [[CBCentralManager alloc] initWithDelegate:delegateImpl queue:queue];
        });

        return (jlong) centralManager;
    }
}

JNIEXPORT jint JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_getState
(JNIEnv *, jobject, jlong centralManagerHandle){
    @autoreleasepool{
        CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;
        return [centralManager state];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_startScanPeripherals
(JNIEnv *, jobject, jlong centralManagerHandle){
    @autoreleasepool{
        CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;
        [centralManager scanForPeripheralsWithServices:@[] options:@{}];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_stopScanPeripherals
(JNIEnv *, jobject, jlong centralManagerHandle){
    @autoreleasepool{
        CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;
        [centralManager stopScan];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_connectPeripheral
(JNIEnv *env, jobject, jlong centralManagerHandle, jlong peripheralHandle, jobject options){
    @autoreleasepool{
        CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        NSDictionary *optionsDictionary = [BJObjectBuilder buildPeripheralConnectionOptionsFrom:options env:env];
        [centralManager connectPeripheral:peripheral options:optionsDictionary];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_cancelPeripheralConnection
(JNIEnv *env, jobject, jlong centralManagerHandle, jlong peripheralHandle){
    @autoreleasepool{
        CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;
        CBPeripheral *peripheral = (CBPeripheral*) peripheralHandle;
        [centralManager cancelPeripheralConnection:peripheral];
    }
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_deinitialize
(JNIEnv *, jobject, jlong centralManagerHandle){
    @autoreleasepool{
        CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;
        [centralManager release];
    }
}

JNIEXPORT jobjectArray JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_retrievePeripheralsWithIdentifiers
(JNIEnv *env, jobject, jlong centralManagerHandle, jobjectArray identifiers){
    @autoreleasepool{
        CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;
        NSArray *identifiersUUIDs = [BJObjectBuilder buildCBUUIDArrayFromUUIDObjectArray:identifiers env:env];
        NSArray* peripherals = [centralManager retrievePeripheralsWithIdentifiers:identifiersUUIDs];
        jobjectArray result = [BJObjectBuilder buildPeripheralObjectArrayFrom:peripherals env:env];
        return result;
    }
}

JNIEXPORT jobjectArray JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_retrieveConnectedPeripheralsWithServices
(JNIEnv *env, jobject, jlong centralManagerHandle, jobjectArray services){
    @autoreleasepool{
        CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;

        NSArray *serviceUUIDs = [BJObjectBuilder buildCBUUIDArrayFromUUIDObjectArray:services env:env];
        NSArray* peripherals = [centralManager retrieveConnectedPeripheralsWithServices:serviceUUIDs];
        jobjectArray result = [BJObjectBuilder buildPeripheralObjectArrayFrom:peripherals env:env];

        return result;
    }
}



