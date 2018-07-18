//
//  BJJavaClasses.h
//  ble-jni
//
//  Created by Tiago Janela on 11/07/2018.
//

#ifndef BJJavaClasses_h
#define BJJavaClasses_h

#define Java_Lang_Namespace "java/lang/"
#define Java_String_ClassName Java_Lang_Namespace "String"

#define Java_Util_Namespace "java/util/"
#define Java_UUID_ClassName Java_Util_Namespace "UUID"

#define BJ_Namespace "com/blissapplications/ble/"
#define BJBluetoothPeripheral_ClassName BJ_Namespace "BluetoothPeripheral"
#define BJBluetoothPeripheralAdvertisementData_ClassName BJ_Namespace "BluetoothPeripheralAdvertisementData"
#define BJBluetoothServiceData_ClassName BJ_Namespace "BluetoothServiceData"

#define BJ_Constructor_MethodName "<init>"

#define BJCentralManager_UpdatedState_MethodName "updatedState"
#define BJCentralManager_UpdatedState_Signature "()V"

#define BJCentralManager_DiscoveredPeripheral_MethodName "discoveredPeripheral"
#define BJCentralManager_DiscoveredPeripheral_Signature "(" \
"L" BJBluetoothPeripheral_ClassName ";" \
"D" \
"L" BJBluetoothPeripheralAdvertisementData_ClassName ";" \
")V"

#define Java_UUID_Constructor_Signature "(JJ)V"

#define BJBluetoothPeripheral_Constructor_Signature "(J)V"

#define BJBluetoothPeripheralAdvertisementData_Constructor_Signature "()V"

#define BJBluetoothPeripheralAdvertisementData_LocalName_FieldName "localName"
#define BJBluetoothPeripheralAdvertisementData_LocalName_FieldSignature "L" Java_String_ClassName ";"

#define BJBluetoothPeripheralAdvertisementData_ManufacturerData_FieldName "manufacturerData"
#define BJBluetoothPeripheralAdvertisementData_ManufacturerData_FieldSignature "[B"

#define BJBluetoothPeripheralAdvertisementData_ServiceData_FieldName "serviceData"
#define BJBluetoothPeripheralAdvertisementData_ServiceData_FieldSignature "[L" BJBluetoothServiceData_ClassName ";"

#define BJBluetoothPeripheralAdvertisementData_ServiceUUIDs_FieldName "serviceUUIDs"
#define BJBluetoothPeripheralAdvertisementData_ServiceUUIDs_FieldSignature "[L" Java_UUID_ClassName ";"

#define BJBluetoothPeripheralAdvertisementData_OverflowServiceUUIDs_FieldName "overflowServiceUUIDs"
#define BJBluetoothPeripheralAdvertisementData_OverflowServiceUUIDs_FieldSignature "[L" Java_UUID_ClassName ";"

#define BJBluetoothPeripheralAdvertisementData_TXPowerLevel_FieldName "txPowerLevel"
#define BJBluetoothPeripheralAdvertisementData_TXPowerLevel_FieldSignature "D"

#define BJBluetoothPeripheralAdvertisementData_IsConnectable_FieldName "isConnectable"
#define BJBluetoothPeripheralAdvertisementData_IsConnectable_FieldSignature "Z"

#define BJBluetoothPeripheralAdvertisementData_SolicitedServiceUUIDs_FieldName "solicitedServiceUUIDs"
#define BJBluetoothPeripheralAdvertisementData_SolicitedServiceUUIDs_FieldSignature "[L" Java_UUID_ClassName ";"

#define BJBluetoothServiceData_Constructor_Signature "()V"

#define BJBluetoothServiceData_ServiceUUID_FieldName "serviceUUID"
#define BJBluetoothServiceData_ServiceUUID_FieldSignature "L" Java_UUID_ClassName ";"

#define BJBluetoothServiceData_Data_FieldName "data"
#define BJBluetoothServiceData_Data_FieldSignature "[B"

#endif /* BJJavaClasses_h */
