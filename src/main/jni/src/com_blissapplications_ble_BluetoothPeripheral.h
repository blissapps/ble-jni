/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class com_blissapplications_ble_BluetoothPeripheral */

#ifndef _Included_com_blissapplications_ble_BluetoothPeripheral
#define _Included_com_blissapplications_ble_BluetoothPeripheral
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    getIdentifier
 * Signature: (J)Ljava/util/UUID;
 */
JNIEXPORT jobject JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getIdentifier
  (JNIEnv *, jobject, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    getName
 * Signature: (J)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getName
  (JNIEnv *, jobject, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    discoverServices
 * Signature: (J[Ljava/util/UUID;)V
 */
JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_discoverServices
  (JNIEnv *, jobject, jlong, jobjectArray);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    discoverIncludedServices
 * Signature: (J[Ljava/util/UUID;J)V
 */
JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_discoverIncludedServices
  (JNIEnv *, jobject, jlong, jobjectArray, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    getServices
 * Signature: (J)[Lcom/blissapplications/ble/BluetoothService;
 */
JNIEXPORT jobjectArray JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getServices
  (JNIEnv *, jobject, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    discoverCharacteristicsForService
 * Signature: (J[Ljava/util/UUID;J)V
 */
JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_discoverCharacteristicsForService
  (JNIEnv *, jobject, jlong, jobjectArray, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    discoverDescriptorsForCharacteristic
 * Signature: (JJ)V
 */
JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_discoverDescriptorsForCharacteristic
  (JNIEnv *, jobject, jlong, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    readValueForCharacteristic
 * Signature: (JJ)V
 */
JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_readValueForCharacteristic
  (JNIEnv *, jobject, jlong, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    readValueForDescriptor
 * Signature: (JJ)V
 */
JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_readValueForDescriptor
  (JNIEnv *, jobject, jlong, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    writeValueForCharacteristic
 * Signature: (J[BJLcom/blissapplications/ble/BluetoothCharacteristicWriteType;)V
 */
JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_writeValueForCharacteristic
  (JNIEnv *, jobject, jlong, jbyteArray, jlong, jobject);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    writeValueForDescriptor
 * Signature: (J[BJ)V
 */
JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_writeValueForDescriptor
  (JNIEnv *, jobject, jlong, jbyteArray, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    setNotifyValueForCharacteristic
 * Signature: (JJZ)V
 */
JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_setNotifyValueForCharacteristic
  (JNIEnv *, jobject, jlong, jlong, jboolean);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    getState
 * Signature: (J)I
 */
JNIEXPORT jint JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getState
  (JNIEnv *, jobject, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    readRSSI
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_readRSSI
  (JNIEnv *, jobject, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothPeripheral
 * Method:    getRSSI
 * Signature: (J)D
 */
JNIEXPORT jdouble JNICALL Java_com_blissapplications_ble_BluetoothPeripheral_getRSSI
  (JNIEnv *, jobject, jlong);

#ifdef __cplusplus
}
#endif
#endif
