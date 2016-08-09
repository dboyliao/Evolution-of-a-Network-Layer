//
//  ViewControllerTests.swift
//  NetworkingEvolution
//
//  Created by Austin Feight on 8/10/16.
//  Copyright (c) 2016 Lost in Flight. All rights reserved.
//

@testable import NetworkingEvolution
import PromiseKit
import SwiftyJSON
import XCTest

class ViewControllerTests: XCTestCase {}

// MARK: Tests
extension ViewControllerTests {
  func test_successNetworkResponse_showsUsername()
  {
    let viewController = ViewController()
    viewController.fetchUser = MockSuccessFetchUser()
    viewController.loadViewIfNeeded()
    
    let expectation = expectationWithDescription("Label set")
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10), dispatch_get_main_queue()) {
      XCTAssertEqual(viewController.label.text, "Username: feighter09")
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(0.0001, handler: nil)
  }
  
  func test_failureNetworkResponse_showsErrorMessage()
  {
    let viewController = ViewController()
    viewController.fetchUser = MockFailureFetchUser()
    viewController.loadViewIfNeeded()
    
    let expectation = expectationWithDescription("Label set")
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10), dispatch_get_main_queue()) { 
      XCTAssertEqual(viewController.label.text, "Request failed")
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(0.0001, handler: nil)
  }
}

// MARK: - Mocks
class MockSuccessFetchUser: FetchUser {
  override func perform(username: String) -> Promise<User>
  {
    return Promise(User(name: username))
  }
}

class MockFailureFetchUser: FetchUser {
  override func perform(username: String) -> Promise<User>
  {
    return Promise(error: NSError(domain: "", code: -1, userInfo: nil))
  }
}