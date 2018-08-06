//
//  BJJNIUtils.m
//  ble-jni
//
//  Created by Tiago Janela on 11/07/2018.
//

#import "BJJNIUtils.h"

@implementation BJJNIUtils

+ (JavaVM*) javaVM:(JNIEnv*)env{
    JavaVM *jvm = NULL;
    jint rs = env->GetJavaVM(&jvm);
    assert (rs == JNI_OK);
    return jvm;
}

+ (JNIEnv*) attachThread:(JavaVM*)jvm {
    JNIEnv *env = NULL;
    jint rs = jvm->AttachCurrentThread((void**)&env, NULL);
    assert (rs == JNI_OK);
    return env;
}

+ (void) detachThread:(JavaVM*)jvm {
    jint rs = jvm->DetachCurrentThread();
    assert (rs == JNI_OK);
}

@end
