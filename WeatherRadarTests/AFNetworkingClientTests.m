//
//  AFNetworkingClientTests.m
//  WeatherRadarTests
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AFNetworkingClient.h"

@interface AFNetworkingClientTests : XCTestCase
@property (nonatomic) AFNetworkingClient *httpClient;
@end

@implementation AFNetworkingClientTests

- (void)setUp {
    [super setUp];
    self.httpClient = [AFNetworkingClient sharedInstance];
}

- (void)tearDown {
    self.httpClient = nil;
    [super tearDown];
}

- (void)testShareInstanse {
    XCTAssertNotNil(self.httpClient);
    
}
- (void)testGetRequestInvokesCompletionHandlerWithResponseObjectOnSuccess {
    __block id blockResponseObject = nil;
    __block id blockError = nil;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    
    [self.httpClient GET:@"https://itunes.apple.com/search/media=music&entity=song&term=adele" withParameters:nil completion:^(id _Nullable responseObject, NSError * _Nonnull error) {
        blockResponseObject = responseObject;
        blockError = error;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNil(blockError);
    XCTAssertNotNil(blockResponseObject);
}

- (void)testGetRequestInvokesFailureCompletionBlockWithErrorOnFailure {
    __block id blockError = nil;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    
    [self.httpClient GET:@"https://it.apple.com/search/media=music&entity=song&term=adele" withParameters:nil completion:^(id _Nullable responseObject, NSError * _Nonnull error) {
        blockError = error;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    XCTAssertNotNil(blockError);
}

- (void)testDownloadTaskInvokesCompletionHandlerWithErrorOnFailure {
    
    __block id blockError = nil;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    
    [self.httpClient downloadImage:@"https://gal.yopriceville.com/var/albums/Free-Clipart-Pictures/Cartoons-PNG/Cute_White_Mouse_Cartoon_Free_Clipart.png?m=1434276645" completion:^(id _Nullable image, NSError * _Nullable error) {
        blockError = error;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNotNil(blockError);
    
}

- (void)testDownloadTaskInvokesCompletionHandlerWithResponseObjectOnSuccess {
    __block id blockResponse = nil;
    __block id blockError = nil;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    
    [self.httpClient downloadImage:@"https://gallery.yopriceville.com/var/albums/Free-Clipart-Pictures/Cartoons-PNG/Cute_White_Mouse_Cartoon_Free_Clipart.png?m=1434276645" completion:^(id _Nullable image, NSError * _Nullable error) {
        blockResponse = image;
        blockError = error;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
    XCTAssertNil(blockError);
    XCTAssertNotNil(blockResponse);
    
}

@end
