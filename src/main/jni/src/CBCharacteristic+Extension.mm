//
//  CBCharacteristic+Extension.m
//  ble-jni
//
//  Created by Tiago Janela on 06/08/2018.
//

#import "CBCharacteristic+Extension.h"

#import <objc/runtime.h>
@implementation CBCharacteristic (Extension)

- (jobject) javaCharacteristic{
    void* value = [objc_getAssociatedObject(self, @selector(javaCharacteristic)) pointerValue];
    return (jobject) value;
}

- (void)setJavaCharacteristic:(jobject) javaCharacteristic{
    NSValue* value = [NSValue valueWithPointer:javaCharacteristic];
    objc_setAssociatedObject(self, @selector(javaCharacteristic), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
