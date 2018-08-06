//
//  CBCentralManagerDelegateImpl.m
//  ble-jni
//
//  Created by Tiago Janela on 09/07/2018.
//

#import "BJCentralManagerDelegateImpl.h"
#include <iostream>

#import "BJPeripheralDelegateImpl.h"
#import "BJObjectBuilder.h"
#import "BJJNIUtils.h"
#import "BJCentralManagerInvoker.h"
#import "CBPeripheral+Extension.h"

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
/*- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict{

}*/

- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{

}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{

}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];

    jobject wrappedPeripheral = peripheral.javaPeripheral;

    if(wrappedPeripheral == NULL){
        wrappedPeripheral = [BJObjectBuilder buildPeripheralFrom:peripheral env:env];
        wrappedPeripheral = env->NewWeakGlobalRef(wrappedPeripheral);
        peripheral.javaPeripheral = wrappedPeripheral;
        if (peripheral.delegate == nil) {
            peripheral.delegate = [[BJPeripheralDelegateImpl alloc] initWithJavaPeripheral:wrappedPeripheral andJavaVM:_jvm];
        }

        [peripheral retain];
    }

    jobject wrappedAdvertisementData = [BJObjectBuilder buildAdvertisementDataFrom:advertisementData env:env];

    [BJCentralManagerInvoker invokeCentralManager:_javaCentralManager
                             discoveredPeripheral:wrappedPeripheral
                                             rssi:RSSI.doubleValue
                                advertisementData:wrappedAdvertisementData
                                              env:env];
    
    [BJJNIUtils detachThread:_jvm];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];

    jobject wrappedPeripheral = peripheral.javaPeripheral;

    [BJCentralManagerInvoker invokeCentralManager:_javaCentralManager
                              connectedPeripheral:wrappedPeripheral
                                              env:env];

    [BJJNIUtils detachThread:_jvm];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];

    NSLog(@"Failed to connect");
    jobject wrappedPeripheral = peripheral.javaPeripheral;

    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }

    [BJCentralManagerInvoker invokeCentralManager:_javaCentralManager
                      failedToConnectToPeripheral:wrappedPeripheral
                                            error:wrappedError
                                              env:env];

    [BJJNIUtils detachThread:_jvm];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];

    jobject wrappedPeripheral = peripheral.javaPeripheral;

    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }

    [BJCentralManagerInvoker invokeCentralManager:_javaCentralManager
                           disconnectedPeripheral:wrappedPeripheral
                                            error:wrappedError
                                              env:env];

    [BJJNIUtils detachThread:_jvm];
}


@end
