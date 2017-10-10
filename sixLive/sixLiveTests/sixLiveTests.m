//
//  sixLiveTests.m
//  sixLiveTests
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface sixLiveTests : XCTestCase

@end

@implementation sixLiveTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testReadPlist {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tabBar_button_info" ofType:@"plist"];
    NSArray<NSDictionary *> *arrDic = [NSArray arrayWithContentsOfFile:filePath];
    XCTAssert(arrDic, " read plist faile");
    NSLog(@"%@", arrDic);
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
