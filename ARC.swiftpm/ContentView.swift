import SwiftUI
//: Playground - noun: a place where people can play
import UIKit

class Customer {
    
    let udid: String
    let name: String
    
    init(udid: String, name: String) {
        self.udid = udid
        self.name = name
        
        print("\(udid) initialized")
    }
    
    deinit {
        print("\(udid) deinitialized")
    }
    
}

// MARK: - Global strong reference. It'll be free up at the end of programm cycle.
var customer: Customer? = nil
customer = Customer(udid: "global reference", name: "Jo Mock")
/*
 print: global reference initialized
 */
customer = nil

// MARK: - Functin local reference. It'll be free up at the end of function.
func printCustomer() {
    let customer = Customer(udid: "function printCustomer", name: "Jo Mock")
    /*
     print: function printCustomer initialized
     */
    print("print customer: \(customer.udid)")
    /*
     print: function printCustomer deinitialized
     */
}

printCustomer()

// MARK: - Loop local reference. It'll be free up at the end of loop cycle.
for i in 0..<5 {
    _ = Customer(udid: "loop \(i)", name: "Jo Mock")
    /*
     print: loop {i} initialized
     print: loop {i} deinitialized
     */
}

/*
 print: global reference deinitialized
 */
