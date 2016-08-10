//
//  ViewControllerTests.swift
//  NetworkingEvolution
//
//  Created by Austin Feight on 8/10/16.
//  Copyright (c) 2016 Lost in Flight. All rights reserved.
//

@testable import NetworkingEvolution
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
    XCTAssertEqual(viewController.label.text, "Username: feighter09")
  }
  
  func test_failureNetworkResponse_showsErrorMessage()
  {
    let viewController = ViewController()
    viewController.fetchUser = MockFailureFetchUser()
    viewController.loadViewIfNeeded()
    XCTAssertEqual(viewController.label.text, "Request failed")
  }
}

// MARK: - Mocks
class MockSuccessFetchUser: FetchUser {
  override func perform(username: String, callback: (User?, ErrorType?) -> Void)
  {
    callback(User(name: username), nil)
  }
}

class MockFailureFetchUser: FetchUser {
  override func perform(username: String, callback: (User?, ErrorType?) -> Void)
  {
    callback(nil, NSError(domain: "", code: -1, userInfo: nil))
  }
}