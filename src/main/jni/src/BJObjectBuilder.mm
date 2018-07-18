//
//  BJObjectBuilder.m
//  ble-jni
//
//  Created by Tiago Janela on 11/07/2018.
//

#import <Foundation/Foundation.h>
#import "BJObjectBuilder.h"
#import "BJJavaClasses.h"

@implementation BJObjectBuilder

+ (jobject) buildPeripheralFrom:(CBPeripheral*)peripheral env:(JNIEnv*)env{
    jclass cls = env->FindClass(BJBluetoothPeripheral_ClassName);
    jmethodID constructor = env->GetMethodID(cls,
                                             BJ_Constructor_MethodName,
                                             BJBluetoothPeripheral_Constructor_Signature);
    jobject wrappedPeripheral = env->NewObject(cls, constructor, (jlong) peripheral);
    return wrappedPeripheral;
}

+ (jobject) buildAdvertisementDataFrom:(NSDictionary*)advertisementData env:(JNIEnv*)env{
    jclass cls = env->FindClass(BJBluetoothPeripheralAdvertisementData_ClassName);
    jmethodID constructor = env->GetMethodID(cls,
                                             BJ_Constructor_MethodName,
                                             BJBluetoothPeripheralAdvertisementData_Constructor_Signature);
    jobject wrappedPeripheralAdvertisementData = env->NewObject(cls, constructor);

    jstring localName = env->NewStringUTF([advertisementData[CBAdvertisementDataLocalNameKey] UTF8String]);

    jfieldID localNameField = env->GetFieldID(cls,
                    BJBluetoothPeripheralAdvertisementData_LocalName_FieldName,
                    BJBluetoothPeripheralAdvertisementData_LocalName_FieldSignature);
    env->SetObjectField(wrappedPeripheralAdvertisementData,
                        localNameField,
                        localName);


    NSData *manufacturerData = advertisementData[CBAdvertisementDataManufacturerDataKey];
    jbyteArray manufacturerDataByteArray = [self byteArrayFromNSData:manufacturerData env:env];

    jfieldID manufacturerDataField = env->GetFieldID(cls,
                                                     BJBluetoothPeripheralAdvertisementData_ManufacturerData_FieldName,
                                                     BJBluetoothPeripheralAdvertisementData_ManufacturerData_FieldSignature);

    env->SetObjectField(wrappedPeripheralAdvertisementData,
                        manufacturerDataField,
                        manufacturerDataByteArray);

    NSDictionary *serviceData = advertisementData[CBAdvertisementDataServiceDataKey];
    jobjectArray serviceDataObjectArray = [self serviceDataObjectArrayFromServiceDataDictionary:serviceData env:env];

    jfieldID serviceDataField = env->GetFieldID(cls,
                                                BJBluetoothPeripheralAdvertisementData_ServiceData_FieldName,
                                                BJBluetoothPeripheralAdvertisementData_ServiceData_FieldSignature);

    env->SetObjectField(wrappedPeripheralAdvertisementData,
                        serviceDataField,
                        serviceDataObjectArray);

    NSArray* serviceUUIDs = advertisementData[CBAdvertisementDataServiceUUIDsKey];
    jobjectArray serviceUUIDsObjectArray = [self uuidsObjectArrayFromUUIDsArray:serviceUUIDs env:env];
    jfieldID serviceUUIDsField = env->GetFieldID(cls,
                                                BJBluetoothPeripheralAdvertisementData_ServiceUUIDs_FieldName,
                                                BJBluetoothPeripheralAdvertisementData_ServiceUUIDs_FieldSignature);

    env->SetObjectField(wrappedPeripheralAdvertisementData,
                        serviceUUIDsField,
                        serviceUUIDsObjectArray);

    NSArray* overflowServiceUUIDs = advertisementData[CBAdvertisementDataOverflowServiceUUIDsKey];
    jobjectArray overflowServiceUUIDsObjectArray = [self uuidsObjectArrayFromUUIDsArray:overflowServiceUUIDs env:env];
    jfieldID overflowServiceUUIDsField = env->GetFieldID(cls,
                                                 BJBluetoothPeripheralAdvertisementData_OverflowServiceUUIDs_FieldName,
                                                 BJBluetoothPeripheralAdvertisementData_OverflowServiceUUIDs_FieldSignature);

    env->SetObjectField(wrappedPeripheralAdvertisementData,
                        overflowServiceUUIDsField,
                        overflowServiceUUIDsObjectArray);

    NSNumber* txPowerLevel = advertisementData[CBAdvertisementDataTxPowerLevelKey];
    jfieldID txPowerLevelField = env->GetFieldID(cls,
                                                         BJBluetoothPeripheralAdvertisementData_TXPowerLevel_FieldName,
                                                         BJBluetoothPeripheralAdvertisementData_TXPowerLevel_FieldSignature);
    env->SetDoubleField(wrappedPeripheralAdvertisementData,
                        txPowerLevelField,
                        txPowerLevel.doubleValue);

    NSNumber* isConnectable = advertisementData[CBAdvertisementDataIsConnectable];
    jfieldID isConnectableField = env->GetFieldID(cls,
                                                 BJBluetoothPeripheralAdvertisementData_IsConnectable_FieldName,
                                                 BJBluetoothPeripheralAdvertisementData_IsConnectable_FieldSignature);
    env->SetBooleanField(wrappedPeripheralAdvertisementData,
                        isConnectableField,
                        isConnectable.boolValue);


    NSArray* solicitedServiceUUIDs = advertisementData[CBAdvertisementDataSolicitedServiceUUIDsKey];
    jobjectArray solicitedServiceUUIDsObjectArray = [self uuidsObjectArrayFromUUIDsArray:solicitedServiceUUIDs env:env];
    jfieldID solicitedServiceUUIDsField = env->GetFieldID(cls,
                                                         BJBluetoothPeripheralAdvertisementData_SolicitedServiceUUIDs_FieldName,
                                                         BJBluetoothPeripheralAdvertisementData_SolicitedServiceUUIDs_FieldSignature);

    env->SetObjectField(wrappedPeripheralAdvertisementData,
                        solicitedServiceUUIDsField,
                        solicitedServiceUUIDsObjectArray);

    return wrappedPeripheralAdvertisementData;
}

+ (jobjectArray) uuidsObjectArrayFromUUIDsArray:(NSArray*)uuidsArray env:(JNIEnv*)env{
    jclass cls = env->FindClass(Java_UUID_ClassName);
    jobjectArray uuidsObjectArray = env->NewObjectArray((jsize)[uuidsArray count], cls, NULL);
    jsize index = 0;
    for (CBUUID *uuid in uuidsArray) {
        jobject wrappedUUID = [self uuidFromCBUUID:uuid env:env];
        env->SetObjectArrayElement(uuidsObjectArray, index, wrappedUUID);
        index = index + 1;
    }
    return uuidsObjectArray;
}

+ (jobjectArray) serviceDataObjectArrayFromServiceDataDictionary:(NSDictionary*)serviceData env:(JNIEnv*)env {
    jclass cls = env->FindClass(BJBluetoothServiceData_ClassName);
    jobjectArray serviceDataObjectArray = env->NewObjectArray((jsize)[serviceData count], cls, NULL);
    jsize index = 0;
    for (CBUUID *serviceDataUUID in serviceData.allKeys) {
        NSData *serviceDataForUUID = serviceData[serviceDataUUID];
        jobject wrappedServiceData = [self serviceDataFromServiceUUID:serviceDataUUID data:serviceDataForUUID env:env];
        env->SetObjectArrayElement(serviceDataObjectArray, index, wrappedServiceData);
        index = index + 1;
    }
    return serviceDataObjectArray;
}

+ (jobject) serviceDataFromServiceUUID:(CBUUID*)serviceDataUUID data:(NSData*)data env:(JNIEnv*)env{
    jclass cls = env->FindClass(BJBluetoothServiceData_ClassName);
    jmethodID constructor = env->GetMethodID(cls,
                                             BJ_Constructor_MethodName,
                                             BJBluetoothServiceData_Constructor_Signature);
    jobject wrappedServiceData = env->NewObject(cls, constructor);

    jobject serviceUUID = [self uuidFromCBUUID:serviceDataUUID env:env];
    jfieldID serviceUUIDField = env->GetFieldID(cls,
                                                BJBluetoothServiceData_ServiceUUID_FieldName,
                                                BJBluetoothServiceData_ServiceUUID_FieldSignature);

    env->SetObjectField(wrappedServiceData,
                        serviceUUIDField,
                        serviceUUID);

    jbyteArray dataByteArray = [self byteArrayFromNSData:data env:env];
    jfieldID dataField = env->GetFieldID(cls,
                                         BJBluetoothServiceData_Data_FieldName,
                                         BJBluetoothServiceData_Data_FieldSignature);

    env->SetObjectField(wrappedServiceData,
                        dataField,
                        dataByteArray);

    return wrappedServiceData;
}

+ (jobject) uuidFromCBUUID:(CBUUID*)uuid env:(JNIEnv*)env{
    jclass cls = env->FindClass(Java_UUID_ClassName);
    jmethodID constructor = env->GetMethodID(cls,
                                             BJ_Constructor_MethodName,
                                             Java_UUID_Constructor_Signature);

    NSData *uuidData = [uuid data];
    UInt8* uuidBytes = (UInt8*) uuidData.bytes;
    UInt64 mostSignificantBits = 0x0000000000000000;
    mostSignificantBits =  ((UInt64)uuidBytes[0] << 56) & 0xff00000000000000;
    mostSignificantBits |= ((UInt64)uuidBytes[1] << 48) & 0x00ff000000000000;
    mostSignificantBits |= ((UInt64)uuidBytes[2] << 40) & 0x0000ff0000000000;
    mostSignificantBits |= ((UInt64)uuidBytes[3] << 32) & 0x000000ff00000000;
    mostSignificantBits |= ((UInt64)uuidBytes[4] << 24) & 0x00000000ff000000;
    mostSignificantBits |= ((UInt64)uuidBytes[5] << 16) & 0x0000000000ff0000;
    mostSignificantBits |= ((UInt64)uuidBytes[6] <<  8) & 0x000000000000ff00;
    mostSignificantBits |= ((UInt64)uuidBytes[7] <<  0) & 0x00000000000000ff;

    UInt64 leastSignificantBits = 0x0000000000000000;
    leastSignificantBits =  ((UInt64)uuidBytes[8]  << 56) & 0xff00000000000000;
    leastSignificantBits |= ((UInt64)uuidBytes[9]  << 48) & 0x00ff000000000000;
    leastSignificantBits |= ((UInt64)uuidBytes[10] << 40) & 0x0000ff0000000000;
    leastSignificantBits |= ((UInt64)uuidBytes[11] << 32) & 0x000000ff00000000;
    leastSignificantBits |= ((UInt64)uuidBytes[12] << 24) & 0x00000000ff000000;
    leastSignificantBits |= ((UInt64)uuidBytes[13] << 16) & 0x0000000000ff0000;
    leastSignificantBits |= ((UInt64)uuidBytes[14] <<  8) & 0x000000000000ff00;
    leastSignificantBits |= ((UInt64)uuidBytes[15] <<  0) & 0x00000000000000ff;

    jobject wrappedUUID = env->NewObject(cls, constructor, mostSignificantBits, leastSignificantBits);
    return wrappedUUID;
}

+ (jobject) uuidFromNSUUID:(NSUUID*)uuid env:(JNIEnv*)env{
    jclass cls = env->FindClass(Java_UUID_ClassName);
    jmethodID constructor = env->GetMethodID(cls,
                                             BJ_Constructor_MethodName,
                                             Java_UUID_Constructor_Signature);

    UInt8 uuidBytes[16];
    [uuid getUUIDBytes:(unsigned char *)&uuidBytes];

    UInt64 mostSignificantBits = 0x0000000000000000;
    mostSignificantBits =  ((UInt64)uuidBytes[0] << 56) & 0xff00000000000000;
    mostSignificantBits |= ((UInt64)uuidBytes[1] << 48) & 0x00ff000000000000;
    mostSignificantBits |= ((UInt64)uuidBytes[2] << 40) & 0x0000ff0000000000;
    mostSignificantBits |= ((UInt64)uuidBytes[3] << 32) & 0x000000ff00000000;
    mostSignificantBits |= ((UInt64)uuidBytes[4] << 24) & 0x00000000ff000000;
    mostSignificantBits |= ((UInt64)uuidBytes[5] << 16) & 0x0000000000ff0000;
    mostSignificantBits |= ((UInt64)uuidBytes[6] <<  8) & 0x000000000000ff00;
    mostSignificantBits |= ((UInt64)uuidBytes[7] <<  0) & 0x00000000000000ff;

    UInt64 leastSignificantBits = 0x0000000000000000;
    leastSignificantBits =  ((UInt64)uuidBytes[8]  << 56) & 0xff00000000000000;
    leastSignificantBits |= ((UInt64)uuidBytes[9]  << 48) & 0x00ff000000000000;
    leastSignificantBits |= ((UInt64)uuidBytes[10] << 40) & 0x0000ff0000000000;
    leastSignificantBits |= ((UInt64)uuidBytes[11] << 32) & 0x000000ff00000000;
    leastSignificantBits |= ((UInt64)uuidBytes[12] << 24) & 0x00000000ff000000;
    leastSignificantBits |= ((UInt64)uuidBytes[13] << 16) & 0x0000000000ff0000;
    leastSignificantBits |= ((UInt64)uuidBytes[14] <<  8) & 0x000000000000ff00;
    leastSignificantBits |= ((UInt64)uuidBytes[15] <<  0) & 0x00000000000000ff;

    jobject wrappedUUID = env->NewObject(cls, constructor, mostSignificantBits, leastSignificantBits);
    return wrappedUUID;
}

+ (jbyteArray) byteArrayFromNSData:(NSData*)data env:(JNIEnv*)env{
    NSUInteger dataLength = data == nil ? 0 : [data length];
    jbyteArray dataByteArray = env->NewByteArray((jsize)dataLength);
    if(data != nil){
        env->SetByteArrayRegion(dataByteArray,
                                0,
                                (jsize)dataLength,
                                (const jbyte*) [data bytes]);
    }
    return dataByteArray;
}

@end
