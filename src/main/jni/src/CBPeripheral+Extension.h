//
//  CBPeripheral+Extension.h
//  ble-jni
//
//  Created by Tiago Janela on 05/08/2018.
//


#import <jni.h>
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface CBPeripheral (Extension)

@property (nonatomic, assign) jobject javaPeripheral;

@end
