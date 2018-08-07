//
//  CBDescriptor+Extension.h
//  ble-jni-xcode6
//
//  Created by Tiago Janela on 8/6/18.
//
//

#import <jni.h>
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface CBDescriptor (Extension)

@property (nonatomic, assign) jobject javaDescriptor;

@end