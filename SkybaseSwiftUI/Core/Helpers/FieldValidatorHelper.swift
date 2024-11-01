////
////  FieldValidatorHelper.swift
////  SkybaseSwiftUI
////
////  Created by Nanda Kista Permana on 01/11/24.
////
//
//import Foundation
//
//@propertyWrapper
//struct ValidatedField {
//    private(set) var value: String = ""
//    private var validation: (String) -> Bool
//    var isValid: Bool { validation(value) }
//    
//    init(validation: @escaping (String) -> Bool) {
//        self.validation = validation
//    }
//    
//    var wrappedValue: String {
//        get { value }
//        set { value = newValue }
//    }
//    
//    var projectedValue: Bool {
//        isValid
//    }
//}
//
//@propertyWrapper
//struct ValidatedPublishedField {
//    @Published private(set) var value: String
//    private let validation: (String) -> Bool
//    private(set) var isValid: Bool
//    
//    init(wrappedValue: String = "", validation: @escaping (String) -> Bool) {
//        self.value = wrappedValue
//        self.validation = validation
//        self.isValid = validation(wrappedValue)
//    }
//    
//    var wrappedValue: String {
//        get { value }
//        set {
//            value = newValue
//            isValid = validation(value)
//        }
//    }
//    
//    var projectedValue: Bool {
//        isValid
//    }
//}

import Foundation
import Combine


protocol ValidationRule {
    func validate(_ value: String) -> String?
}

struct NonEmptyRule: ValidationRule {
    func validate(_ value: String) -> String? {
        value.isEmpty ? "Field cannot be empty" : nil
    }
}

struct MinLengthRule: ValidationRule {
    let length: Int
    func validate(_ value: String) -> String? {
        value.count < length ? "Must be at least \(length) characters" : nil
    }
}

class ValidatedField: ObservableObject {
    @Published var text: String = ""
    @Published var error: String?

    private var rules: [ValidationRule]

    init(rules: [ValidationRule]) {
        self.rules = rules
    }

    func validate() {
        for rule in rules {
            if let message = rule.validate(text) {
                error = message
                return
            }
        }
        error = nil
    }
}
