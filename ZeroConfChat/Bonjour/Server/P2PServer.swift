//
//  P2PServer.swift
//  ZeroConfChat
//
//  Created by Do, Tho on 04/10/2022.
//

import Foundation
import Network
import OSLog

protocol P2PServerProtocol: AnyObject {
    func startListening()
}

class P2PServer {
    init() {
        startListening()
    }

    func startListening() {
        do {
            let parameters = NWParameters.initWithTCPOptionsOnly()
            let listener = try NWListener(using: parameters)
            listener.service = NWListener.Service(name: "server", type: BonjourServiceName)

            listener.stateUpdateHandler = { newState in
                Logger.application.info("Server stateUpdateHandler \(String(describing: newState))")
            }

            listener.newConnectionHandler = { newConnection in
                Logger.application.info("Server newConnectionHandler \(String(describing: newConnection))")
                if sharedConnection == nil {
                    sharedConnection = PeerConnection(connection: newConnection)
                } else {
                    newConnection.cancel()
                }
            }
            listener.start(queue: .main)
        } catch(let error) {
            Logger.application.error("Failed to initialized listener \(error.localizedDescription)")
        }
    }
}
