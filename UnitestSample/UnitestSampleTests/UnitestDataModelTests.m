//
//  UnitestDataModelTests.m
//  UnitestSample
//
//  Created by Cosmade on 6/14/16.
//  Copyright © 2016 Cosmade. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UnitestSampleTests.h"
#import "DataModel.h"

//不同的单元测试，最好建立不同的测试类。
//一般推荐，一个单元测试类对应一个类。
//理论上，单元测试需要覆盖所有的方法接口。最好能够覆盖所有的情况。
//如有复杂的依赖关系，需要额外定义一些辅助的类进行测试。
@interface UnitestDataModelTests : UnitestSampleTests

//可能需要在单元测试的build phases中的compile sources添加所需测试的源文件引用。
@property (strong, nonatomic) DataModel *model;

@end

@implementation UnitestDataModelTests

- (void)setUp
{
    [super setUp];
    self.model = [[DataModel alloc] init];
    //在此处初始化测试所需数据或开始连接。
}

- (void)tearDown
{
    //在此处结束测试，清空缓存或结束连接。
    self.model = nil;
    [super tearDown];
}

- (void)testSyncMethodWithAssert
{
    //使用断言判断测试结果。
    //适用情况，当遇到某个分支情况需要立即退出测试并判断为失败时，使用断言。
    [self.model setTestValue:@(123)];
    XCTAssert([[self.model getTestValue] isEqual:@(123)]);
}

- (void)testSyncMethodWithExpectation
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"sync success"];
    //设定你所期望的结果。
    //适用情况，需要判断多个条件，或者等待异步回调结果，以判断测试结果是否成功时，使用期望。
    [self.model setTestValue:@(123)];
    
    if ([[self.model getTestValue] isEqual:@(123)])
    {
        [expectation fulfill];
    }
    
    [self waitForExpectationsWithTimeout:0.0 handler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

- (void)testAsyncMethod
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"async success"];
    //设定你所期望的结果。
    //适用情况，需要判断多个条件，或者等待异步回调结果，以判断测试结果是否成功时，使用期望。
    __weak typeof(self) weakSelf = self;
    [self.model setTestValue:@(123) withBlock:^(id callbackValue) {
        if (weakSelf == nil)return ;
        if ([[weakSelf.model getTestValue] isEqual:@(123)])
        {
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:1.1 handler:^(NSError * _Nullable error) {
        //在等待时间到达时，如仍有未满足的期望，则会判断测试失败。(如把等待时间缩短为0.5s)
        NSLog(@"%@",error);
    }];
    //在此处返回之前，就应当抛出测试出错的异常。
}

- (void)testPerformance
{
    //如有需要测试性能的，请使用以下方法。
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
