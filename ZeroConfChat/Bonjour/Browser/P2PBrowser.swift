//
//  P2PBrowser.swift
//  ZeroConfChat
//
//  Created by Do, Tho on 27/09/2022.
//

import Foundation
import Network
import OSLog

protocol P2PBrowserProtocol: AnyObject {
    func startBrowsing()
}

class P2PBrowser: P2PBrowserProtocol {
    init() {
        startBrowsing()
    }

    func startBrowsing() {
        let parameters = NWParameters()

        let browser = NWBrowser(for: .bonjour(type: BonjourServiceName, domain: nil), using: parameters )

        browser.stateUpdateHandler = { [weak self] newState in
            Logger.application.info("Browser stateUpdateHandler \(String(describing: newState))")
            switch newState {
            case let .failed(nwError):
                Logger.application.error("Browser failed with \(nwError.localizedDescription), restarting")
                browser.cancel()
                self? .startBrowsing()
            case .ready: break
            case .setup : break
            case let .waiting(nwError):
                Logger.application.error("Browser waiting failed with \(nwError.localizedDescription), restarting")
                browser.cancel()
                self? .startBrowsing()
            case .cancelled: break
            @unknown default: assertionFailure("Should handle new case here")
            }
        }

        browser.browseResultsChangedHandler = { results, changes in
            Logger.application.info("Received results \(results) in browseResultsChangedHandler")

            results.forEach { result in
                if case NWEndpoint.service = result.endpoint {
                    Logger.application.info("Result: \(String(describing: result)) in browseResultsChangedHandler")
                }
            }
        }

        browser.start(queue: .main)
    }
}
