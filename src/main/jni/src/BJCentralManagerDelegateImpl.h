//
//  CBCentralManagerDelegateImpl.h
//  ble-jni
//
//  Created by Tiago Janela on 09/07/2018.
//

#import <jni.h>
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "com_blissapplications_ble_BluetoothCentralManager.h"

@interface CBCentralManagerDelegateImpl : NSObject <CBCentralManagerDelegate>
{
    jobject _javaCentralManager;
    JavaVM* _jvm;
}
- (id) initWithJavaCentralManager:(jobject)javaCentralManager andJavaVM:(JavaVM*)jvm;

@end
