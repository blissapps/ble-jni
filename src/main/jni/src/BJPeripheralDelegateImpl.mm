//
//  BJPeripheralDelegateImpl.m
//  ble-jni
//
//  Created by Tiago Janela on 05/08/2018.
//

#import "BJPeripheralDelegateImpl.h"
#include <iostream>

#import "BJObjectBuilder.h"
#import "BJJNIUtils.h"
#import "BJPeripheralInvoker.h"
#import "CBPeripheral+Extension.h"
#import "CBService+Extension.h"
#import "CBCharacteristic+Extension.h"

using namespace std;

@implementation BJPeripheralDelegateImpl

- (instancetype)initWithJavaPeripheral:(jobject)javaPeripheral andJavaVM:(JavaVM*)jvm
{
    self = [super init];
    if (self) {
        _javaPeripheral = javaPeripheral;
        _jvm = jvm;
    }
    return self;
}

- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral
{
    NSLog(@"Updated name");
}

- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray *)invalidatedServices
{
    NSLog(@"Modified services: %@", invalidatedServices);
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Updated RSSI: %@", error);
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];

    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }

    [BJPeripheralInvoker invokePeripheralDiscoveredServices:_javaPeripheral
                                                      error:wrappedError
                                                        env:env];

    [BJJNIUtils detachThread:_jvm];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"Discovered didDiscoverIncludedServicesForService...");
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];

    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }


    [BJPeripheralInvoker invokePeripheral:_javaPeripheral
      discoveredCharacteristicsForService:service.javaService
                                    error:wrappedError
                                      env:env];

    [BJJNIUtils detachThread:_jvm];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];
    
    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }
    
    [BJPeripheralInvoker invokePeripheral:_javaPeripheral
   discoveredDescriptorsForCharacteristic:characteristic.javaCharacteristic
                                    error:wrappedError
                                      env:env];
    
    [BJJNIUtils detachThread:_jvm];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{}
    

@end
