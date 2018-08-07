//
//  CBDescriptor+Extension.m
//  ble-jni-xcode6
//
//  Created by Tiago Janela on 8/6/18.
//
//

#import "CBDescriptor+Extension.h"

#import <objc/runtime.h>
@implementation CBDescriptor (Extension)

- (jobject)javaDescriptor{
    void* value = [objc_getAssociatedObject(self, @selector(javaDescriptor)) pointerValue];
    return (jobject) value;
}

- (void)setJavaDescriptor:(jobject) javaDescriptor{
    NSValue* value = [NSValue valueWithPointer:javaDescriptor];
    objc_setAssociatedObject(self, @selector(javaDescriptor), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
