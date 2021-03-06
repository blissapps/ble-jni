//
//  BJCentralManagerInvoker.m
//  ble-jni
//
//  Created by Tiago Janela on 11/07/2018.
//

#import "BJCentralManagerInvoker.h"
#import "BJJavaClasses.h"

@implementation BJCentralManagerInvoker

+ (void) invokeCentralManager:(jobject)javaCentralManager
         discoveredPeripheral:(jobject)peripheral
                         rssi:(double)rssi
            advertisementData:(jobject)advertisementData
                          env:(JNIEnv*)env {

    jclass centralCls = env->GetObjectClass(javaCentralManager);
    jmethodID mid = env->GetMethodID(centralCls,
                                     BJCentralManager_DiscoveredPeripheral_MethodName,
                                     BJCentralManager_DiscoveredPeripheral_Signature);
    env->CallVoidMethod(javaCentralManager, mid, peripheral, rssi, advertisementData);

}

+ (void) invokeCentralManagerDidUpdateState:(jobject)javaCentralManager
                                        env:(JNIEnv*)env{
    jclass centralCls = env->GetObjectClass(javaCentralManager);
    jmethodID mid = env->GetMethodID(centralCls,
                                     BJCentralManager_UpdatedState_MethodName,
                                     BJCentralManager_UpdatedState_Signature);
    env->CallVoidMethod(javaCentralManager, mid);
}

+ (void) invokeCentralManager:(jobject)javaCentralManager
          connectedPeripheral:(jobject)peripheral
                          env:(JNIEnv*)env{
    jclass centralCls = env->GetObjectClass(javaCentralManager);
    jmethodID mid = env->GetMethodID(centralCls,
                                     BJCentralManager_ConnectedPeripheral_MethodName,
                                     BJCentralManager_ConnectedPeripheral_Signature);
    env->CallVoidMethod(javaCentralManager, mid, peripheral);
}

+ (void) invokeCentralManager:(jobject)javaCentralManager
  failedToConnectToPeripheral:(jobject)peripheral
                        error:(jobject)error
                          env:(JNIEnv*)env{
    jclass centralCls = env->GetObjectClass(javaCentralManager);
    jmethodID mid = env->GetMethodID(centralCls,
                                     BJCentralManager_FailedToConnectToPeripheral_MethodName,
                                     BJCentralManager_FailedToConnectToPeripheral_Signature);
    env->CallVoidMethod(javaCentralManager, mid, peripheral, error);
}

+ (void) invokeCentralManager:(jobject)javaCentralManager
       disconnectedPeripheral:(jobject)peripheral
                        error:(jobject)error
                          env:(JNIEnv*)env {
    jclass centralCls = env->GetObjectClass(javaCentralManager);
    jmethodID mid = env->GetMethodID(centralCls,
                                     BJCentralManager_DisconnectedPeripheral_MethodName,
                                     BJCentralManager_DisconnectedPeripheral_Signature);
    env->CallVoidMethod(javaCentralManager, mid, peripheral, error);
}

@end
