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
#import "CBDescriptor+Extension.h"

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
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];
    
    [BJPeripheralInvoker invokePeripheralUpdatedName:_javaPeripheral
                                                 env:env];
    
    [BJJNIUtils detachThread:_jvm];
}

- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray *)invalidatedServices
{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];
    jobjectArray servicesArray = [BJObjectBuilder buildServiceObjectArrayFrom:invalidatedServices env:env];
    [BJPeripheralInvoker invokePeripheral:_javaPeripheral
                          modfiedServices:servicesArray
                                      env:env];
    [BJJNIUtils detachThread:_jvm];
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];
    
    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }
    
    [BJPeripheralInvoker invokePeripheralUpdatedRSSI:_javaPeripheral
                                               error:wrappedError
                                                 env:env];
    
    [BJJNIUtils detachThread:_jvm];
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
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];
    
    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }
    
    jobject javaService = [BJObjectBuilder buildServiceFrom:service env:env];
    
    [BJPeripheralInvoker invokePeripheral:_javaPeripheral
     discoveredIncludedServicesForService:javaService
                                    error:wrappedError
                                      env:env];
    
    [BJJNIUtils detachThread:_jvm];
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
{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];
    
    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }
    
    
    [BJPeripheralInvoker invokePeripheral:_javaPeripheral
            updatedValueForCharacteristic:characteristic.javaCharacteristic
                                    error:wrappedError
                                      env:env];
    [BJJNIUtils detachThread:_jvm];
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];
    
    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }
    
    
    [BJPeripheralInvoker invokePeripheral:_javaPeripheral
              wroteValueForCharacteristic:characteristic.javaCharacteristic
                                    error:wrappedError
                                      env:env];
    [BJJNIUtils detachThread:_jvm];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];
    
    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }
    
    
    [BJPeripheralInvoker invokePeripheral:_javaPeripheral
updatedNotificationStateForCharacteristic:characteristic.javaCharacteristic
                                    error:wrappedError
                                      env:env];
    [BJJNIUtils detachThread:_jvm];
}

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
{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];
    
    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }
    
    
    [BJPeripheralInvoker invokePeripheral:_javaPeripheral
                updatedValueForDescriptor:descriptor.javaDescriptor
                                    error:wrappedError
                                      env:env];
    [BJJNIUtils detachThread:_jvm];
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    JNIEnv* env = [BJJNIUtils attachThread:_jvm];
    
    jobject wrappedError = NULL;
    if(error != nil){
        wrappedError = [BJObjectBuilder buildBluetoothExceptionFromNSError:error env:env];
    }
    
    
    [BJPeripheralInvoker invokePeripheral:_javaPeripheral
                  wroteValueForDescriptor:descriptor.javaDescriptor
                                    error:wrappedError
                                      env:env];
    [BJJNIUtils detachThread:_jvm];
}
    

@end
