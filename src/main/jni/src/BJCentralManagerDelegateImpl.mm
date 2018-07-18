//
//  CBCentralManagerDelegateImpl.m
//  ble-jni
//
//  Created by Tiago Janela on 09/07/2018.
//

#import "BJCentralManagerDelegateImpl.h"
#include <iostream>

#import "BJObjectBuilder.h"
#import "BJJNIUtils.h"
#import "BJCentralManagerInvoker.h"

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
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];

    [BJCentralManagerInvoker invokeCentralManagerDidUpdateState:_javaCentralManager
                                                            env:env];

    [BJJNIUtils detachThread:_jvm];
}

/*
 CBCentralManagerRestoredStatePeripheralsKey An array (an instance of NSArray)
 of CBPeripheral objects that contains all of the peripherals that were
 connected to the central manager (or had a connection pending) at the time
 the app was terminated by the system.

 CBCentralManagerRestoredStateScanServicesKey An array (an instance of NSArray)
 of service UUIDs (represented by CBUUID objects) that contains all the services
 the central manager was scanning for at the time the app was terminated by the
 system.

 CBCentralManagerRestoredStateScanOptionsKey A dictionary (an instance of
 NSDictionary) that contains all of the peripheral scan options that were being
 used by the central manager at the time the app was terminated by the system.
 */
- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict{

}

- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{

}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{

}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];

    jobject wrappedPeripheral = [BJObjectBuilder buildPeripheralFrom:peripheral env:env];
    jobject wrappedAdvertisementData = [BJObjectBuilder buildAdvertisementDataFrom:advertisementData env:env];

    [BJCentralManagerInvoker invokeCentralManager:_javaCentralManager
                             discoveredPeripheral:wrappedPeripheral
                                             rssi:RSSI.doubleValue
                                advertisementData:wrappedAdvertisementData
                                              env:env];
    
    [BJJNIUtils detachThread:_jvm];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{

}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{

}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{

}


@end
