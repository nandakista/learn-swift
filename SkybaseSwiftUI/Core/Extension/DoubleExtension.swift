//
//  DoubleExtension.swift
//  LearSwift
//
//  Created by Nanda Kista Permana on 29/08/24.
//

import Foundation

extension Double {
    
    /// Coverts a Double into a Currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to Rp1,234.56
    /// Convert 12.3456 to Rp12.34.56
    /// Convert 0.123456 to Rp0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // <-- default value
        formatter.currencyCode = "idr"
        formatter.currencySymbol = "Rp"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 3
        return formatter
    }
    
    /// Coverts a Double into a Currency as a String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "Rp1,234.56"
    /// Convert 12.3456 to "Rp12.34.56"
    /// Convert 0.123456 to "Rp0.123456"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "Rp0.00"
    }
    
    /// Coverts a Double into String representation
    /// ```
    /// Convert 1234.56 to "1234.56"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self);
    }
    
    /// Coverts a Double into String representation
    /// ```
    /// Convert 12.3456 to "12.34%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%";
    }
}
