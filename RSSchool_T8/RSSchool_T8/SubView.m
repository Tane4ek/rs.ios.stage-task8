//
//  SubView.m
//  RSSchool_T8
//
//  Created by Татьяна Лузанова on 17.07.2021.
//

#import "SubView.h"

@implementation SubView

- (instancetype) initWithFrame:(CGRect)frame andColor:(nonnull UIColor *)color{
    self = [super initWithFrame:frame];
        if (self) {
            self.backgroundColor = color;
        }
        return self;
}

@end
