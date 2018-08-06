//
//  CBService+Extension.h
//  ble-jni
//
//  Created by Tiago Janela on 06/08/2018.
//

#import <jni.h>
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface CBService (Extension)

@property (nonatomic, assign) jobject javaService;

@end
