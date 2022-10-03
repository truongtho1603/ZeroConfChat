//
//  P2PBrowserTests.swift
//  ZeroConfChatTests
//
//  Created by Do, Tho on 03/10/2022.
//

import XCTest
@testable import ZeroConfChat

class P2PBrowserTests: XCTestCase {
    private func makeSUT() -> P2PBrowser {
        P2PBrowser()
    }

    func testZero() throws {
        _ = makeSUT()
    }
}
