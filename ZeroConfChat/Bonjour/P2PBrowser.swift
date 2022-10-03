//
//  P2PBrowser.swift
//  ZeroConfChat
//
//  Created by Do, Tho on 27/09/2022.
//

import Foundation
import Network

protocol P2PBrowserProtocol: AnyObject {
    func startBrowsing()
}

class P2PBrowser: P2PBrowserProtocol {
    init() {}

    func startBrowsing() {
        let parameters = NWParameters()
        _ = parameters
    }
}
