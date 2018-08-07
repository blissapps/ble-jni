//
//  BJPeripheralInvoker.h
//  ble-jni
//
//  Created by Tiago Janela on 05/08/2018.
//

#import <jni.h>
#import <Foundation/Foundation.h>

@interface BJPeripheralInvoker : NSObject

+ (void) invokePeripheralDiscoveredServices:(jobject) javaPeripheral
                                      error:(jobject) javaBluetoothException
                                        env:(JNIEnv*) env;

+ (void) invokePeripheral:(jobject) javaPeripheral
discoveredIncludedServicesForService:(jobject) javaService
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env;


+ (void) invokePeripheral:(jobject) javaPeripheral
          modfiedServices:(jobjectArray) javaServicesObjectArray
                      env:(JNIEnv*) env;

+ (void) invokePeripheral:(jobject) javaPeripheral
discoveredCharacteristicsForService:(jobject) javaService
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env;

+ (void) invokePeripheral:(jobject) javaPeripheral
discoveredDescriptorsForCharacteristic:(jobject) javaCharacteristic
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env;

+ (void) invokePeripheral:(jobject) javaPeripheral
updatedValueForCharacteristic:(jobject) javaCharacteristic
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env;

+ (void) invokePeripheral:(jobject) javaPeripheral
updatedValueForDescriptor:(jobject) javaDesciptor
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env;

+ (void) invokePeripheral:(jobject) javaPeripheral
wroteValueForCharacteristic:(jobject) javaCharacteristic
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env;

+ (void) invokePeripheral:(jobject) javaPeripheral
  wroteValueForDescriptor:(jobject) javaDesciptor
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env;

+ (void) invokePeripheral:(jobject) javaPeripheral
updatedNotificationStateForCharacteristic:(jobject) javaCharacteristic
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env;


+ (void) invokePeripheralUpdatedRSSI:(jobject) javaPeripheral
                               error:(jobject) javaBluetoothException
                                 env:(JNIEnv*) env;

+ (void) invokePeripheralUpdatedName:(jobject) javaPeripheral
                                 env:(JNIEnv*) env;
@end
