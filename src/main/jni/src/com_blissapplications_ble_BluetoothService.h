/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class com_blissapplications_ble_BluetoothService */

#ifndef _Included_com_blissapplications_ble_BluetoothService
#define _Included_com_blissapplications_ble_BluetoothService
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     com_blissapplications_ble_BluetoothService
 * Method:    isPrimary
 * Signature: (J)Z
 */
JNIEXPORT jboolean JNICALL Java_com_blissapplications_ble_BluetoothService_isPrimary
  (JNIEnv *, jobject, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothService
 * Method:    getIdentifier
 * Signature: (J)Ljava/util/UUID;
 */
JNIEXPORT jobject JNICALL Java_com_blissapplications_ble_BluetoothService_getIdentifier
  (JNIEnv *, jobject, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothService
 * Method:    getCharacteristics
 * Signature: (J)[Lcom/blissapplications/ble/BluetoothCharacteristic;
 */
JNIEXPORT jobjectArray JNICALL Java_com_blissapplications_ble_BluetoothService_getCharacteristics
  (JNIEnv *, jobject, jlong);

/*
 * Class:     com_blissapplications_ble_BluetoothService
 * Method:    getIncludedServices
 * Signature: (J)[Lcom/blissapplications/ble/BluetoothService;
 */
JNIEXPORT jobjectArray JNICALL Java_com_blissapplications_ble_BluetoothService_getIncludedServices
  (JNIEnv *, jobject, jlong);

#ifdef __cplusplus
}
#endif
#endif