//
//  Homework_5_2Tests.swift
//  Homework-5.2Tests
//
//  Created by Мария Коханчик on 28.03.2022.
//

import XCTest
@testable import Homework_5_2

final class NetworkServiceTests: XCTestCase {

    var sut: NetworkService<MockNetworkClient<Item>>!
    var client: MockNetworkClient<Item>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        client = MockNetworkClient<Item>()
        sut = NetworkService<MockNetworkClient<Item>>(client: client)
    }

    override func tearDownWithError() throws {
        client = nil
        sut = nil
        
        try super.tearDownWithError()
    }

    func testServiceCanReceiveResult() {
        let expectedItem = Item()
        var resultItem: Item?
        client.stubResponse = expectedItem
        sut.fetchItem(at: 0) { (item, _) in
            resultItem = item
        }
        XCTAssertEqual(expectedItem, resultItem)
    }

    func testFailedServiceCanReceiveResult() {
        let expectedItem = Item()
        var resultItem: Item?
        client.stubResponse = expectedItem
        client.stubError = true
        
        let failedFetchItem = expectation(description: "Fetch item failure")
        
        sut.fetchItem(at: 0) { (item, error) in
            resultItem = item
            guard resultItem == nil else {
                XCTFail("Must have failed but not: \(String(describing: resultItem))")
                return
            }
            XCTAssertEqual(
                error as? MockNetworkClient<Item>.MockNetworkClientError,
                MockNetworkClient<Item>.MockNetworkClientError.stubError
            )
            failedFetchItem.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
}
