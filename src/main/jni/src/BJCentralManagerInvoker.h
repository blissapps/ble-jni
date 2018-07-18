//
//  BJCentralManagerInvoker.h
//  ble-jni
//
//  Created by Tiago Janela on 11/07/2018.
//

#import <Foundation/Foundation.h>
#import <jni.h>
@interface BJCentralManagerInvoker : NSObject

+ (void) invokeCentralManagerDidUpdateState:(jobject)javaCentralManager
                                        env:(JNIEnv*)env;

+ (void) invokeCentralManager:(jobject)javaCentralManager
         discoveredPeripheral:(jobject)peripheral
                         rssi:(double)rssi
            advertisementData:(jobject)advertisementData
                          env:(JNIEnv*)env;

@end
