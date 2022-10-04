//
//  PeerConnection.swift
//  ZeroConfChat
//
//  Created by Do, Tho on 04/10/2022.
//

import Foundation
import Network
import OSLog

class PeerConnection {
    private let activeConnection: NWConnection

    // Outgoing connection
    init(endpoint: NWEndpoint) {
        Logger.application.info("PeerConnection is initializing outgoing connection with endpoint: \(String(describing: endpoint))")
        let parameters = NWParameters.initWithTCPOptionsOnly()
        self.activeConnection = NWConnection(to: endpoint, using: parameters)
        start()
    }

    // Incoming connection
    init(connection: NWConnection) {
        Logger.application.info("PeerConnection is initializing incoming connection with: \(String(describing: connection))")
        self.activeConnection = connection
        start()
    }

    func start() {
        activeConnection.stateUpdateHandler = { newState in
            Logger.application.info("PeerConnection is handling \(String(describing: newState))")
        }

        activeConnection.start(queue: .main)
    }
}

// MARK: - Handling incoming connection
extension PeerConnection {

}

// MARK: - Handling outcming connection
extension PeerConnection {}
