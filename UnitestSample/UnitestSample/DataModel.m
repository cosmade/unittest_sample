//
//  DataModel.m
//  UnitestSample
//
//  Created by Cosmade on 6/14/16.
//  Copyright © 2016 Cosmade. All rights reserved.
//

#import "DataModel.h"

@interface DataModel ()

@property (strong, nonatomic) id value;

@end

@implementation DataModel

- (id)init
{
    self = [super init];
    _value = nil;
    return self;
}

- (void)setTestValue:(id)value
{
    self.value = value;
}

- (id)getTestValue
{
    return self.value;
}

- (void)setTestValue:(id)value withBlock:(AsyncCallbackBlock)block
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf == nil) return ;
        weakSelf.value = value;
        block(weakSelf.value);
    });
}

@end

