//
//  CBPeripheral+Extension.m
//  ble-jni
//
//  Created by Tiago Janela on 05/08/2018.
//

#import "CBPeripheral+Extension.h"

#import <objc/runtime.h>

const NSString* JAVA_PERIPHERAL_KEY = @"javaPeripheral";

@implementation CBPeripheral (Extension)

- (jobject)javaPeripheral{
    void* value = [objc_getAssociatedObject(self, @selector(javaPeripheral)) pointerValue];
    return (jobject) value;
}

- (void)setJavaPeripheral:(jobject) javaPeripheral{
    NSValue* value = [NSValue valueWithPointer:javaPeripheral];
    objc_setAssociatedObject(self, @selector(javaPeripheral), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
    
@end
