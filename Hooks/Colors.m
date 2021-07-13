//
//  OLED Mode for Discord
//
//  Created by ren7995 on 2021-07-12 20:04:50
//

#import <UIKit/UIKit.h>
#include <objc/runtime.h>
#include <substrate.h>

// RCTView - (void)setBackgroundColor:(UIColor *)color
static void (*orig_RCTView_setBackgroundColor)(UIView *, SEL, UIColor *);
static void hooked_RCTView_setBackgroundColor(UIView *self, SEL _cmd, UIColor *color) {
    if(![color isEqual:[UIColor clearColor]]) {
        CGFloat red = 0, green = 0, blue = 0, alpha = 0;
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
        if(red < 0.25 && green < 0.25 && blue < 0.25)
            color = [UIColor colorWithRed:red / 5 green:green / 5 blue:blue / 5 alpha:alpha];
    }
    orig_RCTView_setBackgroundColor(self, _cmd, color);
}

// UIView - (void)setBackgroundColor:(UIColor *)color
static void (*orig_UIView_setBackgroundColor)(UIView *, SEL, UIColor *);
static void hooked_UIView_setBackgroundColor(UIView *self, SEL _cmd, UIColor *color) {
    if(![color isEqual:[UIColor clearColor]] && ![self isKindOfClass:[UILabel class]]) {
        color = [UIColor blackColor];
    }
    orig_UIView_setBackgroundColor(self, _cmd, color);
}

__attribute__((constructor)) static void initalize() {
    MSHookMessageEx([UIView class],
                    @selector(setBackgroundColor:),
                    (IMP)&hooked_UIView_setBackgroundColor,
                    (IMP *)&orig_UIView_setBackgroundColor);
    MSHookMessageEx(objc_getClass("RCTView"),
                    @selector(setBackgroundColor:),
                    (IMP)&hooked_RCTView_setBackgroundColor,
                    (IMP *)&orig_RCTView_setBackgroundColor);
}
