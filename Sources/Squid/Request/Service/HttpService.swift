//
//  Service.swift
//  Squid
//
//  Created by Oliver Borchert on 9/18/19.
//

import Foundation

/// An HTTP service can be used to abstract a specific endpoint away from specific requests.
/// Usually, you would have one HTTP service per API that you use and possibly different services
/// for testing/staging and production. Intuitively, a specific implementation of an HTTP service
/// represents a particular API.
public protocol HttpService {
    
    /// The URL of the API representes by this HTTP service (e.g. "api.example.com"). This is the
    /// only field that needs to be provided by a particular implementation.
    var apiUrl: UrlConvertible { get }
    
    /// A header that ought to be used by all requests issued against the API represented by this
    /// HTTP service. Most commonly, this header contains fields such as the API key or some form
    /// of Authorization. Request headers always overwrite header fields set by the HTTP service
    /// they are used with. By default, the HTTP service does not set any headers.
    var header: HttpHeader { get }
    
    /// The session configuration to use for all requests using this service. By default,
    /// `URLSessionConfiguration.default` is used.
    var sessionConfiguration: URLSessionConfiguration { get }
    
    /// The retrier factory provides retriers for requests. By default, the default factory of the
    /// stateless `NilRetrier` is used, i.e. requests are never retried.
    var retrierFactory: RetrierFactory { get }
    
    /// This method may be implemented to perform some action upon failure of a particular request
    /// issued against the API represented by this service. As the method does not return anything,
    /// it is mainly intended to be used for debugging or global notifications. A common example is,
    /// e.g. notifying the user that something has happened via some kind of alert. You may use the
    /// notification center to publish failures that are worth reporting to the user. By default,
    /// this method does nothing.
    ///
    /// - Parameter error: The error that caused the failure of a scheduled request.
    func process(_ error: Squid.Error)
}

extension HttpService {
    
    public var header: HttpHeader {
        return [:]
    }
    
    public var sessionConfiguration: URLSessionConfiguration {
        return .default
    }
    
    public var retrierFactory: RetrierFactory {
        return NilRetrier.factory()
    }
    
    public func process(_ error: Squid.Error) {
        return
    }
}
