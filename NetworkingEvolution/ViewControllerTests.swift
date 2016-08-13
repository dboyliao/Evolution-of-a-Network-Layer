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

class ViewControllerTests: XCTestCase {
  var viewController: ViewController!
  
  override func setUp()
  {
    super.setUp()
    
    viewController = ViewController()
  }
}

// MARK: Tests
extension ViewControllerTests {
  func test_successNetworkResponse_showsUsername()
  {
    viewController.networkClient = MockSuccessNetworkClient()
    viewController.loadViewIfNeeded()
    XCTAssertEqual(viewController.label.text, "Username: feighter09")
  }
  
  func test_failureNetworkResponse_showsErrorMessage()
  {
    viewController.networkClient = MockFailureNetworkClient()
    viewController.loadViewIfNeeded()
    XCTAssertEqual(viewController.label.text, "Request failed")
  }
}

// MARK: - Mocks
struct MockSuccessNetworkClient: NetworkClientType {
  func fetchUsername(callback: (String?, ErrorType?) -> Void)
  {
    callback("feighter09", nil)
  }
  
  func makeRequest(url: String,
                   params: [String : AnyObject],
                   callback: (JSON?, ErrorType?) -> Void)
  {}
}

struct MockFailureNetworkClient: NetworkClientType {
  func fetchUsername(callback: (String?, ErrorType?) -> Void)
  {
    callback(nil, NSError(domain: "", code: -1, userInfo: nil))
  }
  
  func makeRequest(url: String,
                   params: [String : AnyObject],
                   callback: (JSON?, ErrorType?) -> Void)
  {}
}