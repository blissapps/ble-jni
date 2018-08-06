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

//Java builders
+ (jobjectArray) buildPeripheralObjectArrayFrom:(NSArray*)peripherals env:(JNIEnv*)env;
+ (jobject) buildPeripheralFrom:(CBPeripheral*)peripheral env:(JNIEnv*)env;
+ (jobject) buildAdvertisementDataFrom:(NSDictionary*)advertisementData env:(JNIEnv*)env;
+ (jobject) buildBluetoothExceptionFromNSError:(NSError*)error env:(JNIEnv*)env;
+ (jobject) buildUUIDFromNSUUID:(NSUUID*)uuid env:(JNIEnv*)env;
+ (jobject) buildUUIDFromCBUUID:(CBUUID*)uuid env:(JNIEnv*)env;
+ (jbyteArray) buildByteArrayFromNSData:(NSData*)data env:(JNIEnv*)env;
+ (jobjectArray) buildServiceObjectArrayFrom:(NSArray*)services env:(JNIEnv*)env;
+ (jobject) buildServiceFrom:(CBService*)service env:(JNIEnv*)env;
+ (jobjectArray) buildCharacteristicObjectArrayFrom:(NSArray*)characteristics env:(JNIEnv*)env;
+ (jobject) buildCharacteristicFrom:(CBCharacteristic*)characteristic env:(JNIEnv*)env;

//ObjC bbuilders

+ (NSDictionary*) buildPeripheralConnectionOptionsFrom:(jobject)options env:(JNIEnv*)env;
+ (NSArray*) buildCBUUIDArrayFromUUIDObjectArray:(jobjectArray)uuidArray env:(JNIEnv*)env;
+ (CBUUID*) buildCBUUIDFromUUID:(jobject)uuid env:(JNIEnv*)env;

@end
