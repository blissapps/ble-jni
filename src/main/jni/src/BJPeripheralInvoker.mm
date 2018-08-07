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

+ (void) invokePeripheral:(jobject)javaPeripheral
discoveredIncludedServicesForService:(jobject)javaService
                    error:(jobject)javaBluetoothException
                      env:(JNIEnv *)env{
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_DiscoveredIncludedServicesForService_MethodName,
                                     BJBluetoothPeripheral_DiscoveredIncludedServicesForService_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaService, javaBluetoothException);
}

+ (void) invokePeripheral:(jobject) javaPeripheral
          modfiedServices:(jobjectArray) javaServicesObjectArray
                      env:(JNIEnv*) env{
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_ModifiedServices_MethodName,
                                     BJBluetoothPeripheral_ModifiedServices_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaServicesObjectArray);
}

+ (void) invokePeripheral:(jobject) javaPeripheral
discoveredCharacteristicsForService:(jobject)javaService
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env {
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_DiscoveredCharacteristicsForService_MethodName,
                                     BJBluetoothPeripheral_DiscoveredCharacteristicsForService_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaService, javaBluetoothException);
}

+ (void) invokePeripheral:(jobject) javaPeripheral
discoveredDescriptorsForCharacteristic:(jobject)javaCharacteristic
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env{
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_DiscoveredDescriptorsForCharacteristic_MethodName,
                                     BJBluetoothPeripheral_DiscoveredDescriptorsForCharacteristic_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaCharacteristic, javaBluetoothException);
}

+ (void)invokePeripheral:(jobject)javaPeripheral
updatedValueForCharacteristic:(jobject)javaCharacteristic
                   error:(jobject)javaBluetoothException
                     env:(JNIEnv *)env {
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_UpdatedValueForCharacteristic_MethodName,
                                     BJBluetoothPeripheral_UpdatedValueForCharacteristic_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaCharacteristic, javaBluetoothException);
}

+ (void) invokePeripheral:(jobject) javaPeripheral
updatedValueForDescriptor:(jobject) javaDesciptor
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env{
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_UpdatedValueForDescriptor_MethodName,
                                     BJBluetoothPeripheral_UpdatedValueForDescriptor_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaDesciptor, javaBluetoothException);
}

+ (void) invokePeripheral:(jobject) javaPeripheral
wroteValueForCharacteristic:(jobject) javaCharacteristic
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env{
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_WroteValueForCharacteristic_MethodName,
                                     BJBluetoothPeripheral_WroteValueForCharacteristic_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaCharacteristic, javaBluetoothException);
}

+ (void) invokePeripheral:(jobject) javaPeripheral
  wroteValueForDescriptor:(jobject) javaDesciptor
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env{
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_WroteValueForDescriptor_MethodName,
                                     BJBluetoothPeripheral_WroteValueForDescriptor_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaDesciptor, javaBluetoothException);
}

+ (void) invokePeripheral:(jobject) javaPeripheral
updatedNotificationStateForCharacteristic:(jobject) javaCharacteristic
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env{
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_UpdatedNotificationStateForCharacteristic_MethodName,
                                     BJBluetoothPeripheral_UpdatedNotificationStateForCharacteristic_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaCharacteristic, javaBluetoothException);
}

+ (void) invokePeripheralUpdatedRSSI:(jobject) javaPeripheral
                               error:(jobject) javaBluetoothException
                                 env:(JNIEnv*) env {
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_UpdatedRSSI_MethodName,
                                     BJBluetoothPeripheral_UpdatedRSSI_Signature);
    env->CallVoidMethod(javaPeripheral, mid, javaBluetoothException);
}

+ (void) invokePeripheralUpdatedName:(jobject) javaPeripheral
                                 env:(JNIEnv*) env {
    jclass peripheralCls = env->GetObjectClass(javaPeripheral);
    jmethodID mid = env->GetMethodID(peripheralCls,
                                     BJBluetoothPeripheral_UpdatedName_MethodName,
                                     BJBluetoothPeripheral_UpdatedName_Signature);
    env->CallVoidMethod(javaPeripheral, mid);
}
@end
