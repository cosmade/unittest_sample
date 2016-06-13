//
//  DataModel.h
//  UnitestSample
//
//  Created by Cosmade on 6/14/16.
//  Copyright © 2016 Cosmade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AsyncCallbackBlock)(id callbackValue);

@interface DataModel : NSObject

- (void)setTestValue:(id)value;
- (id)getTestValue;

- (void)setTestValue:(id)value withBlock:(AsyncCallbackBlock)block;

@end
