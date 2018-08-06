//
//  BJPeripheralInvoker.m
//  ble-jni
//
//  Created by Tiago Janela on 05/08/2018.
//

#import "BJPeripheralInvoker.h"
#import "BJJavaClasses.h"

@implementation BJPeripheralInvoker

+ (void) invokePeripheralDiscoveredServices:(jobject) javaPeripheral
                                      error:(jobject) javaBluetoothException
                                        env:(JNIEnv*) env{
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_DiscoveredServices_MethodName,
                                     BJBluetoothPeripheral_DiscoveredServices_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaBluetoothException);
}

+ (void) invokePeripheral:(jobject) javaPeripheral
discoveredCharacteristicsForService:(jobject)javaService
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env {
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_DiscoveredCharacteristicsForService_MethodName,
                                     BJBluetoothPeripheral_DiscoveredCharacteristicsForService_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaBluetoothException);
}

@end