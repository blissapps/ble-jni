//
//  BJCentralManagerInvoker.m
//  ble-jni
//
//  Created by Tiago Janela on 11/07/2018.
//

#import "BJCentralManagerInvoker.h"
#import "BJJavaClasses.h"

using namespace std;

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

@end
