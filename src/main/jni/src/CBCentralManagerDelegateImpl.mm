//
//  CBCentralManagerDelegateImpl.m
//  ble-jni
//
//  Created by Tiago Janela on 09/07/2018.
//

#import "CBCentralManagerDelegateImpl.h"
#include <iostream>

using namespace std;

@implementation CBCentralManagerDelegateImpl

- (instancetype)initWithJavaCentralManager:(jobject)javaCentralManager andJavaVM:(JavaVM*)jvm
{
    self = [super init];
    if (self) {
        _javaCentralManager = javaCentralManager;
        _jvm = jvm;
    }
    return self;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{

}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict{

}

- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{

}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{

}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"%@ (%@ dB): %@", peripheral.identifier, RSSI, advertisementData);
    JNIEnv *env = NULL;
    jint rs = _jvm->AttachCurrentThread((void**)&env, NULL);
    assert (rs == JNI_OK);

    jclass cls = env->FindClass("com/blissapplications/ble/BluetoothPeripheral");
    jmethodID constructor = env->GetMethodID(cls, "<init>", "(J)V");
    jobject object = env->NewObject(cls, constructor, (jlong) peripheral);
    if(env->ExceptionOccurred()){
        env->ExceptionDescribe();
        env->ExceptionClear();
    }
    jclass centralCls = env->GetObjectClass(_javaCentralManager);
    jmethodID mid = env->GetMethodID(centralCls, "discoveredPeripheral", "(Lcom/blissapplications/ble/BluetoothPeripheral;D)V");
    env->CallVoidMethod(_javaCentralManager, mid, object, RSSI.doubleValue);
    if(env->ExceptionOccurred()){
        env->ExceptionDescribe();
        env->ExceptionClear();
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{

}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{

}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{

}


@end
