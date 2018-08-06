//
//  BJPeripheralDelegateImpl.h
//  ble-jni
//
//  Created by Tiago Janela on 05/08/2018.
//

#import <jni.h>
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "com_blissapplications_ble_BluetoothCentralManager.h"


@interface BJPeripheralDelegateImpl : NSObject <CBPeripheralDelegate>
{
    jobject _javaPeripheral;
    JavaVM* _jvm;
}
- (id) initWithJavaPeripheral:(jobject)javaPeripheral andJavaVM:(JavaVM*)jvm;
@end
