//
//  BJJNIUtils.h
//  ble-jni
//
//  Created by Tiago Janela on 11/07/2018.
//

#import <Foundation/Foundation.h>
#import <jni.h>

@interface BJJNIUtils : NSObject

+ (JavaVM*) javaVM:(JNIEnv*)env;
+ (JNIEnv*) attachThread:(JavaVM*)jvm;
+ (void) detachThread:(JavaVM*)jvm;

@end
