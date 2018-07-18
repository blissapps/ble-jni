#include <jni.h>
#include <iostream>
#include "com_blissapplications_ble_BluetoothCentralManager.h"
#import <CoreFoundation/CoreFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BJCentralManagerDelegateImpl.h"
#import "BJJNIUtils.h"

using namespace std;

JNIEXPORT jlong JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_initialize (JNIEnv* env, jobject javaCentralManager){
    JavaVM* jvm = [BJJNIUtils javaVM:env];

    jobject javaCentralManagerGlobalRef = env->NewGlobalRef(javaCentralManager);

    CBCentralManagerDelegateImpl *delegateImpl = [[CBCentralManagerDelegateImpl alloc] initWithJavaCentralManager:javaCentralManagerGlobalRef andJavaVM:jvm];
    dispatch_queue_t queue = dispatch_get_main_queue();
    CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:delegateImpl queue:queue];
    return (jlong) centralManager;
}

JNIEXPORT jint JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_getState
(JNIEnv *, jobject, jlong centralManagerHandle){
    CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;
    return [centralManager state];
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_startScanPeripherals
(JNIEnv *, jobject, jlong centralManagerHandle){
    CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;
    [centralManager scanForPeripheralsWithServices:@[] options:@{}];
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_stopScanPeripherals
(JNIEnv *, jobject, jlong centralManagerHandle){
    CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;
    [centralManager stopScan];
}

JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothCentralManager_deinitialize
  (JNIEnv *, jobject, jlong centralManagerHandle){
  CBCentralManager *centralManager = (CBCentralManager*) centralManagerHandle;
  [centralManager release];
}

