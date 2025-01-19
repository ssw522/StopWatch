//
//  EmailSender.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import Foundation
import UIKit.UIApplication

struct EmailSender {
    let toAddress: String
    let subject: String
    var body: String
    
    // openURL
    @MainActor
    func send(type: EmailType) async throws {
        let urlComponent = type.getUrlCompnents(toAddress: toAddress, subject: subject, body: body)
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            if let url = urlComponent?.url {
                
                UIApplication.shared.open(url) { isSuccess in
                    if isSuccess {
                        continuation.resume()
                    } else {
                        continuation.resume(throwing: EmailSendError.failed)
                    }
                }
            } else {
                continuation.resume(throwing: EmailSendError.invalidUrl)
            }
        }
    }
    
    enum EmailSendError: Error {
        case failed
        case invalidUrl
    }
    
    enum EmailType {
        case apple(toAddress: String)
        case gmail
        
        var scheme: String {
            switch self {
            case .apple(let toAddress):
                "mailto:\(toAddress)"
            case .gmail:
                "googlegmail://co"
            }
        }
        
        func getUrlCompnents(toAddress: String, subject: String, body: String) -> URLComponents? {
            switch self {
            case .apple(_):
                var urlComponent = URLComponents(string: scheme)
                urlComponent?.queryItems = [
                    .init(name: "subject", value: subject),
                    .init(name: "body", value: body)
                ]
            
                return urlComponent
            
            case .gmail:
                var urlComponent = URLComponents(string: scheme)
                urlComponent?.queryItems = [
                    .init(name: "to", value: toAddress),
                    .init(name: "subject", value: subject),
                    .init(name: "body", value: body)
                ]
                
                return urlComponent
            }
        }
    }
}


