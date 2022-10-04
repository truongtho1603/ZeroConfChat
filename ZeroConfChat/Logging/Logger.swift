//
//  Logger.swift
//  ZeroConfChat
//
//  Created by Do, Tho on 04/10/2022.
//

import Foundation
import OSLog

extension Logger {
    static var bundleIdentifier: String {
        switch Bundle.main.bundleIdentifier {
        case .none: return "com.thodo.ZeroConfChat"
        // identifier empty when testing
        case let identifier?: return identifier.isEmpty ? "com.thodo.ZeroConfChat" : identifier
        }
    }

    static let networking = Logger(subsystem: bundleIdentifier, category: "networking")
    static let application = Logger(subsystem: bundleIdentifier, category: "application")
}
