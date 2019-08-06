//
//  NSObject+BIYCrashProtect.m
//  BIYong
//
//  Created by baige on 2018/8/20.
//

#import "NSObject+BIYCrashProtect.h"
#import <objc/runtime.h>

//提示框--->UIAlertController
#define ALERT_VIEW(Title,Message,Controller) {UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:UIAlertControllerStyleAlert];        [alertVc addAction:action];[Controller presentViewController:alertVc animated:YES completion:nil];}

static NSString *_errorFunctionName;
void dynamicMethodIMP(id self,SEL _cmd){
    
#ifdef DEBUG
    //搞定它
//    BIYAppDelegate *delegate = (BIYAppDelegate *)[UIApplication sharedApplication].delegate;
//    UIViewController *currentRootViewController = delegate.window.rootViewController;
//    NSString *error = [NSString stringWithFormat:@"请给程序员看（不要点击）： errorClass->:%@\n errorFuction->%@\n errorReason->UnRecognized Selector",NSStringFromClass([self class]),_errorFunctionName];
//    ALERT_VIEW(@"程序异常",error,currentRootViewController);
#else
    //upload error
    
#endif
    
}

#pragma mark 方法调换
static inline void change_method(Class _originalClass ,SEL _originalSel,Class _newClass ,SEL _newSel){
    Method methodOriginal = class_getInstanceMethod(_originalClass, _originalSel);
    Method methodNew = class_getInstanceMethod(_newClass, _newSel);
    method_exchangeImplementations(methodOriginal, methodNew);
}


@implementation NSObject (BIYCrashProtect)


+ (void)load{
    
    change_method([self class], @selector(methodSignatureForSelector:), [self class], @selector(BIY_methodSignatureForSelector:));
    
    change_method([self class], @selector(forwardInvocation:), [self class], @selector(BIY_forwardInvocation:));
}

- (NSMethodSignature *)BIY_methodSignatureForSelector:(SEL)aSelector{
    if (![self respondsToSelector:aSelector]) {
        _errorFunctionName = NSStringFromSelector(aSelector);
        NSMethodSignature *methodSignature = [self BIY_methodSignatureForSelector:aSelector];
        if (class_addMethod([self class], aSelector, (IMP)dynamicMethodIMP, "v@:")) {//方法参数的获取存在问题
            NSLog(@"临时方法添加成功！");
        }
        if (!methodSignature) {
            methodSignature = [self BIY_methodSignatureForSelector:aSelector];
        }
        
        return methodSignature;
        
    }else{
        return [self BIY_methodSignatureForSelector:aSelector];
    }
}

- (void)BIY_forwardInvocation:(NSInvocation *)anInvocation{
    SEL selector = [anInvocation selector];
    if ([self respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:self];
    }else{
        [self BIY_forwardInvocation:anInvocation];
    }
}

@end
