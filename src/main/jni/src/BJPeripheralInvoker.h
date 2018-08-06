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
discoveredCharacteristicsForService:(jobject)javaService
                    error:(jobject) javaBluetoothException
                      env:(JNIEnv*) env;
@end
