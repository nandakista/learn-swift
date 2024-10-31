//
//  URLExtension.swift
//  SkybaseSwiftUI
//
//  Created by Nanda Kista Permana on 31/10/24.
//

import Foundation

extension URLRequest {
    mutating func setBody(
        contentType: ContentType = .json,
        body: [String: Any]
    ) -> Void {
        switch contentType {
            case .json:
                do {
                    self.httpBody = try body.toJSON()
                    self.setValue("application/json", forHTTPHeaderField: "Content-Type")
                } catch {
                    print("Error serializing JSON: \(error.localizedDescription)")
                }
                
            case .formURLEncoded:
                self.httpBody = body.toFormURLEncoded()
                self.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
            case .formData:
                let boundary = UUID().uuidString
                self.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                self.httpBody = body.toFormData(boundary: boundary)
        }
    }
}

extension [String: Any] {
    func toJSON() throws -> Data? {
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: self)
            return jsonBody
        } catch {
            print("Failed convert Dictionary to JSON")
            throw error
        }
    }
    
    func toFormURLEncoded() -> Data? {
        let encodedParameters = self.map { key, value in
            "\(key)=\(String(describing: value))"
        }.joined(separator: "&")
        return encodedParameters.data(using: .utf8)
    }
    
    func toFormData(boundary: String) -> Data? {
        var bodyData = Data()
        for (key, value) in self {
            bodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
            bodyData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n".data(using: .utf8)!)
            
            if let dataValue = value as? Data {
                bodyData.append(dataValue)
            } else if let stringValue = "\(value)".data(using: .utf8) {
                bodyData.append(stringValue)
            } else {
                print("Failed convert Dictionary to formData")
            }
            
            bodyData.append("\r\n".data(using: .utf8)!)
        }
        bodyData.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return bodyData
    }
}
