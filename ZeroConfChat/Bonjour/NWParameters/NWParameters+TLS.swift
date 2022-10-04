//
//  NWParameters+TLS.swift
//  ZeroConfChat
//
//  Created by Do, Tho on 04/10/2022.
//

import Foundation
import Network
import CryptoKit

extension NWParameters {
    convenience init(passcode: String) {
        let tlsOptions = NWParameters.tlsOptions(passcode: passcode)

        let tcpOptions = NWProtocolTCP.Options()
        tcpOptions.enableKeepalive = true
        tcpOptions.keepaliveIdle = 2

        self.init(tls: tlsOptions, tcp: tcpOptions)
        // Let app discovers other even if devices aren't same network
        self.includePeerToPeer = true
    }

    static func initWithTCPOptionsOnly() -> NWParameters {
        let tcpOptions = NWProtocolTCP.Options()
        tcpOptions.enableKeepalive = true
        tcpOptions.keepaliveIdle = 2

        let parameters = NWParameters(tls: nil, tcp: tcpOptions)
        // Let app discovers other even if devices aren't same network
        parameters.includePeerToPeer = true

        return parameters
    }

    private static func tlsOptions(passcode: String) -> NWProtocolTLS.Options {
        let tlsOptions = NWProtocolTLS.Options()

        let authenticationKey = SymmetricKey(data: passcode.data(using: .utf8)!)
        var authenticationCode = HMAC<SHA256>.authenticationCode(for: TLSEncryptionKey.data(using: .utf8)!,
                                                                 using: authenticationKey)

        let authenticationDispatchData = withUnsafeBytes(of: &authenticationCode) { (pointer: UnsafeRawBufferPointer) in
            DispatchData(bytes: pointer)
        }

        sec_protocol_options_add_pre_shared_key(tlsOptions.securityProtocolOptions,
                                                authenticationDispatchData as __DispatchData,
                                                stringToDispatchData(TLSEncryptionKey)! as __DispatchData)

        sec_protocol_options_append_tls_ciphersuite(tlsOptions.securityProtocolOptions,
                                                    tls_ciphersuite_t(rawValue: TLS_PSK_WITH_AES_128_GCM_SHA256)!)

        return tlsOptions
    }

    private static func stringToDispatchData(_ string: String) -> DispatchData? {
        guard let stringData = string.data(using: .unicode) else { return nil }
        let dispatchData = withUnsafeBytes(of: stringData) { (ptr: UnsafeRawBufferPointer) in
            DispatchData(bytes: UnsafeRawBufferPointer(start: ptr.baseAddress, count: stringData.count))
        }
        return dispatchData
    }

}
