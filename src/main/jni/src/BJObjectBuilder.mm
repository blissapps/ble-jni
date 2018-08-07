//
//  BJObjectBuilder.m
//  ble-jni
//
//  Created by Tiago Janela on 11/07/2018.
//

#import <Foundation/Foundation.h>
#import "BJObjectBuilder.h"
#import "BJJavaClasses.h"
#import "CBPeripheral+Extension.h"
#import "CBService+Extension.h"
#import "CBCharacteristic+Extension.h"
#import "CBDescriptor+Extension.h"

@implementation BJObjectBuilder

+ (jobjectArray) buildPeripheralObjectArrayFrom:(NSArray *)peripherals env:(JNIEnv *)env{
    jclass cls = env->FindClass(BJBluetoothPeripheral_ClassName);
    jobjectArray result = env->NewObjectArray((jsize)peripherals.count, cls, NULL);
    UInt index = 0;
    for (CBPeripheral* peripheral in peripherals) {
        jobject peripheralJava = [BJObjectBuilder buildPeripheralFrom:peripheral env:env];
        env->SetObjectArrayElement(result, index, peripheralJava);
        index = index + 1;
    }
    return result;
}

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
    jbyteArray manufacturerDataByteArray = [self buildByteArrayFromNSData:manufacturerData env:env];

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

+ (jobject) buildBluetoothExceptionFromNSError:(NSError*)error env:(JNIEnv*)env {
    jclass cls = env->FindClass(BJBluetoothException_ClassName);
    jstring message = env->NewStringUTF([[error localizedDescription] UTF8String]);

    jmethodID constructor = env->GetMethodID(cls,
                                             BJ_Constructor_MethodName,
                                             BJBluetoothException_Constructor_Signature);
    jobject bluetoothException = env->NewObject(cls, constructor, message);

    return bluetoothException;
}

+ (jobjectArray) uuidsObjectArrayFromUUIDsArray:(NSArray*)uuidsArray env:(JNIEnv*)env{
    jclass cls = env->FindClass(Java_UUID_ClassName);
    jobjectArray uuidsObjectArray = env->NewObjectArray((jsize)[uuidsArray count], cls, NULL);
    jsize index = 0;
    for (CBUUID *uuid in uuidsArray) {
        jobject wrappedUUID = [self buildUUIDFromCBUUID:uuid env:env];
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

    jobject serviceUUID = [self buildUUIDFromCBUUID:serviceDataUUID env:env];
    jfieldID serviceUUIDField = env->GetFieldID(cls,
                                                BJBluetoothServiceData_ServiceUUID_FieldName,
                                                BJBluetoothServiceData_ServiceUUID_FieldSignature);

    env->SetObjectField(wrappedServiceData,
                        serviceUUIDField,
                        serviceUUID);

    jbyteArray dataByteArray = [self buildByteArrayFromNSData:data env:env];
    jfieldID dataField = env->GetFieldID(cls,
                                         BJBluetoothServiceData_Data_FieldName,
                                         BJBluetoothServiceData_Data_FieldSignature);

    env->SetObjectField(wrappedServiceData,
                        dataField,
                        dataByteArray);

    return wrappedServiceData;
}

+ (jobject) buildUUIDFromCBUUID:(CBUUID*)uuid env:(JNIEnv*)env{
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

+ (jobject) buildUUIDFromNSUUID:(NSUUID*)uuid env:(JNIEnv*)env{
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

+ (jbyteArray) buildByteArrayFromNSData:(NSData*)data env:(JNIEnv*)env{
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

+ (jobjectArray) buildServiceObjectArrayFrom:(NSArray*)services env:(JNIEnv*)env{
    jclass cls = env->FindClass(BJBluetoothService_ClassName);
    jobjectArray result = env->NewObjectArray((jsize)services.count, cls, NULL);
    UInt index = 0;
    for (CBService* service in services) {
        jobject serviceJava = [BJObjectBuilder buildServiceFrom:service env:env];
        env->SetObjectArrayElement(result, index, serviceJava);
        index = index + 1;
    }
    return result;
}

+ (jobject) buildServiceFrom:(CBService*)service env:(JNIEnv*)env{
    jobject serviceJava = service.javaService;
    
    if(serviceJava == NULL){
        jclass cls = env->FindClass(BJBluetoothService_ClassName);
        jmethodID constructor = env->GetMethodID(cls,
                                                 BJ_Constructor_MethodName,
                                                 BJBluetoothService_Constructor_Signature);
        jobject wrappedPeripheral = service.peripheral.javaPeripheral;
        serviceJava = env->NewObject(cls, constructor, (jlong) service, (jlong) wrappedPeripheral);
        serviceJava = env->NewGlobalRef(serviceJava);
        service.javaService = serviceJava;
    }
    
    return serviceJava;
}

+ (jobjectArray) buildCharacteristicObjectArrayFrom:(NSArray*)characteristics env:(JNIEnv*)env{
    jclass cls = env->FindClass(BJBluetoothCharacteristic_ClassName);
    jobjectArray result = env->NewObjectArray((jsize)characteristics.count, cls, NULL);
    UInt index = 0;
    for (CBCharacteristic* characteristic in characteristics) {
        jobject characteristicJava = [BJObjectBuilder buildCharacteristicFrom:characteristic env:env];
        env->SetObjectArrayElement(result, index, characteristicJava);
        index = index + 1;
    }
    return result;
}
+ (jobject) buildCharacteristicFrom:(CBCharacteristic*)characteristic env:(JNIEnv*)env{
    
    jobject characteristicJava = characteristic.javaCharacteristic;
    
    if(characteristicJava == NULL){
        jclass cls = env->FindClass(BJBluetoothCharacteristic_ClassName);
        jmethodID constructor = env->GetMethodID(cls,
                                                 BJ_Constructor_MethodName,
                                                 BJBluetoothCharacteristic_Constructor_Signature);
        jobject wrappedService = characteristic.service.javaService;
        characteristicJava = env->NewObject(cls, constructor, (jlong) characteristic, (jlong) wrappedService);
        characteristicJava = env->NewGlobalRef(characteristicJava);
        characteristic.javaCharacteristic = characteristicJava;
    }
    
    return characteristicJava;
}


;

+ (jobjectArray) buildDescriptorObjectArrayFrom:(NSArray*)descriptors env:(JNIEnv*)env{
    jclass cls = env->FindClass(BJBluetoothDescriptor_ClassName);
    jobjectArray result = env->NewObjectArray((jsize)descriptors.count, cls, NULL);
    UInt index = 0;
    for (CBDescriptor* descriptor in descriptors) {
        jobject descriptorJava = [BJObjectBuilder buildDescriptorFrom:descriptor env:env];
        env->SetObjectArrayElement(result, index, descriptorJava);
        index = index + 1;
    }
    return result;
}

+ (jobject) buildDescriptorFrom:(CBDescriptor*)descriptor env:(JNIEnv*)env{
    jobject descriptorJava = descriptor.javaDescriptor;
    
    if(descriptorJava == NULL){
        jclass cls = env->FindClass(BJBluetoothDescriptor_ClassName);
        jmethodID constructor = env->GetMethodID(cls,
                                                 BJ_Constructor_MethodName,
                                                 BJBluetoothDescriptor_Constructor_Signature);
        jobject wrappedCharacteristic = descriptor.characteristic.javaCharacteristic;
        descriptorJava = env->NewObject(cls, constructor, (jlong) descriptor, (jlong) wrappedCharacteristic);
        descriptorJava = env->NewGlobalRef(descriptorJava);
        descriptor.javaDescriptor = descriptorJava;
    }
    
    return descriptorJava;
}

+ (jobject) buildCharacteristicPropertiesFrom:(CBCharacteristicProperties)properties env:(JNIEnv*)env {
    jclass cls = env->FindClass(BJBluetoothCharacteristicProperties_ClassName);
    jmethodID constructor = env->GetMethodID(cls,
                                             BJ_Constructor_MethodName,
                                             BJBluetoothCharacteristicProperties_Constructor_Signature);
 
    jobject wrappedCharacteristicProperties = env->NewObject(cls, constructor);


    BOOL canBroadcast = (properties & CBCharacteristicPropertyBroadcast) == CBCharacteristicPropertyBroadcast;
    jfieldID canBroadcastField = env->GetFieldID(cls,
                                                 BJBluetoothCharacteristicProperties_CanBroadcast_FieldName,
                                                 BJBluetoothCharacteristicProperties_CanBroadcast_FieldSignature);
    env->SetBooleanField(wrappedCharacteristicProperties,
                         canBroadcastField,
                         canBroadcast);
    
    BOOL canRead = (properties & CBCharacteristicPropertyRead) == CBCharacteristicPropertyRead;
    jfieldID canReadField = env->GetFieldID(cls,
                                            BJBluetoothCharacteristicProperties_CanRead_FieldName,
                                            BJBluetoothCharacteristicProperties_CanRead_FieldSignature);
    env->SetBooleanField(wrappedCharacteristicProperties,
                         canReadField,
                         canRead);
    
    BOOL canBeWrittenWithoutResponse = (properties & CBCharacteristicPropertyWriteWithoutResponse) == CBCharacteristicPropertyWriteWithoutResponse;
    jfieldID canBeWrittenWithoutResponseField = env->GetFieldID(cls,
                                                                BJBluetoothCharacteristicProperties_CanBeWrittenWithoutResponse_FieldName,
                                                                BJBluetoothCharacteristicProperties_CanBeWrittenWithoutResponse_FieldSignature);
    env->SetBooleanField(wrappedCharacteristicProperties,
                         canBeWrittenWithoutResponseField,
                         canBeWrittenWithoutResponse);
    
    BOOL canBeWritten = (properties & CBCharacteristicPropertyWrite) == CBCharacteristicPropertyWrite;
    jfieldID canBeWrittenField = env->GetFieldID(cls,
                                                 BJBluetoothCharacteristicProperties_CanBeWritten_FieldName,
                                                 BJBluetoothCharacteristicProperties_CanBeWritten_FieldSignature);
    env->SetBooleanField(wrappedCharacteristicProperties,
                         canBeWrittenField,
                         canBeWritten);
    
    BOOL canNotify = (properties & CBCharacteristicPropertyNotify) == CBCharacteristicPropertyNotify;
    jfieldID canNotifyField = env->GetFieldID(cls,
                                              BJBluetoothCharacteristicProperties_CanNotify_FieldName,
                                              BJBluetoothCharacteristicProperties_CanNotify_FieldSignature);
    env->SetBooleanField(wrappedCharacteristicProperties,
                         canNotifyField,
                         canNotify);
    
    BOOL canIndicate = (properties & CBCharacteristicPropertyIndicate) == CBCharacteristicPropertyIndicate;
    jfieldID canIndicateField = env->GetFieldID(cls,
                                                BJBluetoothCharacteristicProperties_CanIndicate_FieldName,
                                                BJBluetoothCharacteristicProperties_CanIndicate_FieldSignature);
    env->SetBooleanField(wrappedCharacteristicProperties,
                         canIndicateField,
                         canIndicate);
    
    BOOL authenticatedSignedWrites = (properties & CBCharacteristicPropertyAuthenticatedSignedWrites) == CBCharacteristicPropertyAuthenticatedSignedWrites;
    jfieldID authenticatedSignedWritesField = env->GetFieldID(cls,
                                                              BJBluetoothCharacteristicProperties_AuthenticatedSignedWrites_FieldName,
                                                              BJBluetoothCharacteristicProperties_AuthenticatedSignedWrites_FieldSignature);
    env->SetBooleanField(wrappedCharacteristicProperties,
                         authenticatedSignedWritesField,
                         authenticatedSignedWrites);
    
    BOOL hasExtendedProperties = (properties & CBCharacteristicPropertyExtendedProperties) == CBCharacteristicPropertyExtendedProperties;
    jfieldID hasExtendedPropertiesField = env->GetFieldID(cls,
                                                          BJBluetoothCharacteristicProperties_HasExtendedProperties_FieldName,
                                                          BJBluetoothCharacteristicProperties_HasExtendedProperties_FieldSignature);
    env->SetBooleanField(wrappedCharacteristicProperties,
                         hasExtendedPropertiesField,
                         hasExtendedProperties);
    
    BOOL indicateEncryptionRequired = (properties & CBCharacteristicPropertyIndicateEncryptionRequired) == CBCharacteristicPropertyIndicateEncryptionRequired;
    jfieldID indicateEncryptionRequiredField = env->GetFieldID(cls,
                                                               BJBluetoothCharacteristicProperties_IndicateEncryptionRequired_FieldName,
                                                               BJBluetoothCharacteristicProperties_IndicateEncryptionRequired_FieldSignature);
    env->SetBooleanField(wrappedCharacteristicProperties,
                         indicateEncryptionRequiredField,
                         indicateEncryptionRequired);
    
    BOOL notifyEncryptionRequired = (properties & CBCharacteristicPropertyNotifyEncryptionRequired) == CBCharacteristicPropertyNotifyEncryptionRequired;
    jfieldID notifyEncryptionRequiredField = env->GetFieldID(cls,
                                                               BJBluetoothCharacteristicProperties_NotifyEncryptionRequired_FieldName,
                                                               BJBluetoothCharacteristicProperties_NotifyEncryptionRequired_FieldSignature);
    env->SetBooleanField(wrappedCharacteristicProperties,
                         notifyEncryptionRequiredField,
                         notifyEncryptionRequired);
    
    return wrappedCharacteristicProperties;
}

#pragma mark - ObjC Builder

+ (NSDictionary*) buildPeripheralConnectionOptionsFrom:(jobject)options env:(JNIEnv*)env{

    jclass cls = env->FindClass(BJBluetoothConnectPeripheralOptions_ClassName);


    jfieldID fieldId = env->GetFieldID(cls,
                              BJBluetoothConnectPeripheralOptions_NotifyOnDisconnection_FieldName,
                              BJBluetoothConnectPeripheralOptions_NotifyOnDisconnection_FieldSignature);
    jboolean notifyOnDisconnection = env->GetBooleanField(options, fieldId);

    //10.13 only
    /*fieldId = env->GetFieldID(cls,
                              BJBluetoothConnectPeripheralOptions_NotifyOnConnection_FieldName,
                              BJBluetoothConnectPeripheralOptions_NotifyOnConnection_FieldSignature);
    jboolean notifyOnConnection = env->GetBooleanField(options, fieldId);

    fieldId = env->GetFieldID(cls,
                              BJBluetoothConnectPeripheralOptions_NotifyOnNotification_FieldName,
                              BJBluetoothConnectPeripheralOptions_NotifyOnNotification_FieldSignature);
    jboolean notifyOnNotification = env->GetBooleanField(options, fieldId);*/
    return @{

             CBConnectPeripheralOptionNotifyOnDisconnectionKey: @(notifyOnDisconnection)
             //10.13 only
             //CBConnectPeripheralOptionNotifyOnConnectionKey: @(notifyOnConnection),
             //CBConnectPeripheralOptionNotifyOnNotificationKey: @(notifyOnNotification)
             };
}

+ (NSArray*) buildCBUUIDArrayFromUUIDObjectArray:(jobjectArray)uuidArray env:(JNIEnv*)env{
    UInt servicesCount = env->GetArrayLength(uuidArray);
    NSMutableArray *serviceUUIDs = [NSMutableArray arrayWithCapacity:servicesCount];

    for (UInt i = 0; i < servicesCount; i++) {
        jobject uuidJava = env->GetObjectArrayElement(uuidArray, i);
        CBUUID *uuid = [BJObjectBuilder buildCBUUIDFromUUID:uuidJava env:env];
        [serviceUUIDs addObject:uuid];
    }

    return serviceUUIDs;
}

+ (CBUUID*) buildCBUUIDFromUUID:(jobject)uuid env:(JNIEnv*)env{
    jclass cls = env->FindClass(Java_UUID_ClassName);


    jmethodID methodId = env->GetMethodID(cls,
                                       Java_UUID_GetMostSignificantBits_MethodName,
                                       Java_UUID_GetMostSignificantBits_Signature);
    jlong mostSignificantBits = env->CallLongMethod(uuid, methodId);

    methodId = env->GetMethodID(cls,
                                Java_UUID_GetLeastSignificantBits_MethodName,
                                Java_UUID_GetLeastSignificantBits_Signature);
    jlong leastSignificantBits = env->CallLongMethod(uuid, methodId);

    UInt8 uuidBytes[16];

    uuidBytes[0] = (UInt8) ((mostSignificantBits & 0xff00000000000000) >> 56);
    uuidBytes[1] = (UInt8) ((mostSignificantBits & 0x00ff000000000000) >> 48);
    uuidBytes[2] = (UInt8) ((mostSignificantBits & 0x0000ff0000000000) >> 40);
    uuidBytes[3] = (UInt8) ((mostSignificantBits & 0x000000ff00000000) >> 32);
    uuidBytes[4] = (UInt8) ((mostSignificantBits & 0x00000000ff000000) >> 24);
    uuidBytes[5] = (UInt8) ((mostSignificantBits & 0x0000000000ff0000) >> 16);
    uuidBytes[6] = (UInt8) ((mostSignificantBits & 0x000000000000ff00) >> 8);
    uuidBytes[7] = (UInt8) ((mostSignificantBits & 0x00000000000000ff) >> 0);

    uuidBytes[8]  = (UInt8) ((leastSignificantBits & 0xff00000000000000) >> 56);
    uuidBytes[9]  = (UInt8) ((leastSignificantBits & 0x00ff000000000000) >> 48);
    uuidBytes[10] = (UInt8) ((leastSignificantBits & 0x0000ff0000000000) >> 40);
    uuidBytes[11] = (UInt8) ((leastSignificantBits & 0x000000ff00000000) >> 32);
    uuidBytes[12] = (UInt8) ((leastSignificantBits & 0x00000000ff000000) >> 24);
    uuidBytes[13] = (UInt8) ((leastSignificantBits & 0x0000000000ff0000) >> 16);
    uuidBytes[14] = (UInt8) ((leastSignificantBits & 0x000000000000ff00) >> 8);
    uuidBytes[15] = (UInt8) ((leastSignificantBits & 0x00000000000000ff) >> 0);

    NSData *uuidData = [NSData dataWithBytes:uuidBytes length:16];

    return [CBUUID UUIDWithData:uuidData];
}

@end
