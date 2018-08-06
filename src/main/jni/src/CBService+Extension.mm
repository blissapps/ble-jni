//
//  CBService+Extension.m
//  ble-jni
//
//  Created by Tiago Janela on 06/08/2018.
//

#import "CBService+Extension.h"

#import <objc/runtime.h>
@implementation CBService (Extension)

- (jobject)javaService{
    void* value = [objc_getAssociatedObject(self, @selector(javaService)) pointerValue];
    return (jobject) value;
}

- (void)setJavaService:(jobject) javaService{
    NSValue* value = [NSValue valueWithPointer:javaService];
    objc_setAssociatedObject(self, @selector(javaService), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
