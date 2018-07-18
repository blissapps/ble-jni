//
//  BJObjectBuilder.h
//  ble-jni
//
//  Created by Tiago Janela on 11/07/2018.
//

#import <jni.h>
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BJObjectBuilder : NSObject

+ (jobject) buildPeripheralFrom:(CBPeripheral*)peripheral env:(JNIEnv*)env;
+ (jobject) buildAdvertisementDataFrom:(NSDictionary*)advertisementData env:(JNIEnv*)env;
+ (jobject) uuidFromNSUUID:(NSUUID*)uuid env:(JNIEnv*)env;

@end
