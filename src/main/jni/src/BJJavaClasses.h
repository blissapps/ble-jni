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

#define BJBluetoothConnectPeripheralOptions_ClassName BJ_Namespace "BluetoothConnectPeripheralOptions"

#define BJBluetoothServiceData_ClassName BJ_Namespace "BluetoothServiceData"

#define BJBluetoothPeripheral_ClassName BJ_Namespace "BluetoothPeripheral"

#define BJBluetoothService_ClassName BJ_Namespace "BluetoothService"

#define BJBluetoothCharacteristic_ClassName BJ_Namespace "BluetoothCharacteristic"

#define BJBluetoothException_ClassName BJ_Namespace "BluetoothException"

#define BJ_Constructor_MethodName "<init>"

#define BJCentralManager_UpdatedState_MethodName "updatedState"
#define BJCentralManager_UpdatedState_Signature "()V"

#define BJCentralManager_ConnectedPeripheral_MethodName "connectedPeripheral"
#define BJCentralManager_ConnectedPeripheral_Signature "(" \
"L" BJBluetoothPeripheral_ClassName ";" \
")V"

#define BJCentralManager_FailedToConnectToPeripheral_MethodName "failedToConnectToPeripheral"
#define BJCentralManager_FailedToConnectToPeripheral_Signature "(" \
"L" BJBluetoothPeripheral_ClassName ";" \
"L" BJBluetoothException_ClassName ";" \
")V"

#define BJCentralManager_DisconnectedPeripheral_MethodName "disconnectedPeripheral"
#define BJCentralManager_DisconnectedPeripheral_Signature "(" \
"L" BJBluetoothPeripheral_ClassName ";" \
"L" BJBluetoothException_ClassName ";" \
")V"

#define BJCentralManager_DiscoveredPeripheral_MethodName "discoveredPeripheral"
#define BJCentralManager_DiscoveredPeripheral_Signature "(" \
"L" BJBluetoothPeripheral_ClassName ";" \
"D" \
"L" BJBluetoothPeripheralAdvertisementData_ClassName ";" \
")V"

#define Java_UUID_Constructor_Signature "(JJ)V"

#define Java_UUID_GetMostSignificantBits_MethodName "getMostSignificantBits"
#define Java_UUID_GetMostSignificantBits_Signature "()J"

#define Java_UUID_GetLeastSignificantBits_MethodName "getLeastSignificantBits"
#define Java_UUID_GetLeastSignificantBits_Signature "()J"

#define BJBluetoothPeripheral_Constructor_Signature "(J)V"

#define BJBluetoothPeripheral_DiscoveredServices_MethodName "discoveredServices"
#define BJBluetoothPeripheral_DiscoveredServices_Signature "(" \
"L" BJBluetoothException_ClassName ";" \
")V"

#define BJBluetoothPeripheral_DiscoveredCharacteristicsForService_MethodName "discoveredServices"
#define BJBluetoothPeripheral_DiscoveredCharacteristicsForService_Signature "(" \
"L" BJBluetoothException_ClassName ";" \
")V"

#define BJBluetoothService_Constructor_Signature "("\
"J"\
"L" BJBluetoothPeripheral_ClassName ";" \
")V"

#define BJBluetoothCharacteristic_Constructor_Signature "("\
"J"\
"L" BJBluetoothService_ClassName ";" \
")V"

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

#define BJBluetoothException_Constructor_Signature "("\
"L" Java_String_ClassName ";" \
")V"

#define BJBluetoothServiceData_Constructor_Signature "()V"

#define BJBluetoothServiceData_ServiceUUID_FieldName "serviceUUID"
#define BJBluetoothServiceData_ServiceUUID_FieldSignature "L" Java_UUID_ClassName ";"

#define BJBluetoothServiceData_Data_FieldName "data"
#define BJBluetoothServiceData_Data_FieldSignature "[B"

#define BJBluetoothConnectPeripheralOptions_NotifyOnDisconnection_FieldName "notifyOnDisconnection"
#define BJBluetoothConnectPeripheralOptions_NotifyOnDisconnection_FieldSignature "Z"

#define BJBluetoothConnectPeripheralOptions_NotifyOnConnection_FieldName "notifyOnConnection"
#define BJBluetoothConnectPeripheralOptions_NotifyOnConnection_FieldSignature "Z"

#define BJBluetoothConnectPeripheralOptions_NotifyOnNotification_FieldName "notifyOnNotification"
#define BJBluetoothConnectPeripheralOptions_NotifyOnNotification_FieldSignature "Z"

#endif /* BJJavaClasses_h */
