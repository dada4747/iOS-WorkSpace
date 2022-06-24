import UIKit
import Foundation
import Darwin
//import Darwin
//import UIKit
//
//class Customer {
//
//    let udid: String
//    let name: String
//
//    init(udid: String, name: String) {
//        self.udid = udid
//        self.name = name
//
//        print("\(udid) initialized")
//    }
//
//    deinit {
//        print("\(udid) deinitialized")
//    }
//
//}
//weak var weakCust1 : Customer? = nil
//weak var weakCust2 : Customer? = nil
//
//weakCust1 = Customer(udid: "1st", name: "rahul")
//print(weakCust1?.name)
//var strongCust : Customer? = Customer(udid: "2nd", name: "adsure")
//
//weakCust1 = strongCust
//weakCust2 = weakCust1
//
//print("weak 1st: \(String(describing: weakCust1?.name))")
//print("weak 2nd: \(String(describing: weakCust2?.name))")
//
//strongCust = nil
//
//
//print("weak 1st: \(String(describing: weakCust1?.name))")
//print("weak 2nd: \(String(describing: weakCust2?.name))")

//
//
// MARK: - ARC (automatic reference counting)

// MARK: - unowned reference. Prevent strong reference cycle
//class Owner {
//
//    let udid: String
//    let iin: String
//    let name: String
//    var business: Business!
//
//    init(udid: String, iin: String, name: String) {
//        self.udid = udid
//        self.iin = iin
//        self.name = name
//    }
//
//    deinit {
//        print("owner was deitialized")
//    }
//
//}
//
//class Business {
//
//    let title: String
//    unowned var owner: Owner
//
//    init(title: String, owner: Owner) {
//        self.title = title
//        self.owner = owner
//    }
//
//    deinit {
//        print("business was deitialized")
//    }
//
//}
//var owner: Owner? = Owner(udid: "1st owner", iin: "1", name: "Mike")
//
//print(owner?.name)
//owner!.business = Business(title: "1st Corp", owner: owner!)
//
//
//
//print(owner?.name)
//print(owner?.business.title)
///*
// Do some work with owner
// */
//owner = nil
///*
// print: owner was deitialized
// print: business was deitialized
// */
//
//
//
//
//
//func factorialNumber( namber : Int ) -> Int {
//    var res = 1
//
//    for i in namber...1 {
//        print(i)
//        res = res * (i - 1)
//    }
//    return res
//
//}
 
//let num = 4
//let result = factorialNumber(namber: num)
//print("\(num)! = \(result)")

                    // MARK: - DispatchQueue sync and async
     //Thread         // Task
//  Serial      + sync      = order
//  serial      + async     = order
//  concurrent  + sync   = order
//  concurrent  + async  = unorder
//
//func syncWork() {
//    let myQueue = DispatchQueue(label:"perform_task_with_north",attributes: .concurrent)
//
//    myQueue.sync {
//        print("task 1 started")
//        for number in 1...5 {
//            print("\(number) [task-1] times 5 is \(number * 5)")
//        }
//        print("task 1 finished")
//    }
//        myQueue.sync {
//            print("task 2 started")
//            for number in 1...3 {
//                print("\(number) [task-2] times 5 is \(number * 5)")
//            }
//            print("task 2 finished")
//    }
//}
//
//syncWork()

// MARK: - DispatchGroup

// Sometime you need to know when your task is finished, Apple provide dispatchGroup for it
//once you have one that you want to track as part of that group you can provide the group as an argument to the async method on any dispatch queue
func notifyDispatch() {

    let group = DispatchGroup()
    let que = DispatchQueue(label: "first")
    let subque = DispatchQueue(label: "second")
    que.async(group: group) {
        for _ in 0...2 {

            print("Queue: - Task one running")
            Thread.sleep(until: Date().addingTimeInterval(2))

        }
    }

    que.async(group: group) {
        for _ in 0...3 {
            print("Queue: - Task two running")
            Thread.sleep(until: Date().addingTimeInterval(2))

        }
    }


    subque.async(group: group) {
        for _ in 0...4 {
            Thread.sleep(until: Date().addingTimeInterval(2))
            print("SubQueue: - Task one running")
        }
    }
    if group.wait(timeout: .now() + 10) == .timedOut {
       print("tired")
    } else {
        print("alll complted")
    }
    group.notify(queue: DispatchQueue.main) {
        print("all th task is completed")
    }

}
notifyDispatch()

// MARK: - DispatchSemaphore

//semaphore gives us the ability to contoll access to shared resources by multiple threads.
//
//func dispatchSemaphore() {
//
//    let semaphore = DispatchSemaphore(value: 1)
//
//    DispatchQueue.global().async {
//        print("Kid 1 :- wait ")
//        semaphore.wait()
//        print("Kid 1 :- wait finished ")
//        sleep(1)
//        semaphore.signal()
//        print("kid 1 :- done with iPad")
//    }
//
//    DispatchQueue.global().async {
//        print("Kid 2 :- wait ")
//        semaphore.wait()
//        print("Kid 2 :- wait finished ")
//        sleep(1)
//        semaphore.signal()
//        print("kid 2 :- done with iPad")
//    }
//    DispatchQueue.global().async {
//        print("Kid 3 :- wait ")
//        semaphore.wait()
//        print("Kid 3 :- wait finished ")
//        sleep(1)
//        semaphore.signal()
//        print("kid 3 :- done with iPad")
//    }
//
//}
//dispatchSemaphore()


//      Kid 1 :- wait           0
//      Kid 2 :- wait           -1
//      Kid 2 :- wait finished
//      Kid 3 :- wait           -2
//      kid 2 :- done with iPad -1
//      Kid 1 :- wait finished
//      kid 1 :- done with iPad  0
//      Kid 3 :- wait finished
//      kid 3 :- done with iPad  1

//      Kid 1 :- wait                0
//      Kid 2 :- wait               -1
//      Kid 3 :- wait               -2
//      Kid 2 :- wait finished                0
//      kid 2 :- done with iPad     -1        1
//      Kid 1 :- wait finished                0
//      kid 1 :- done with iPad      0        1
//      Kid 3 :- wait finished                0
//      kid 3 :- done with iPad      1        1

// MARK: - Closure
// closure is function without name

//          { ( parameters ) -> return_type  in
//            code
//          }


//let sayhello: () -> Void = {
//    print("hellow ")
//}
//
//sayhello()


//let digit:(Int, Int, Int) -> Int = {
//    print($0)
//    print($1)
//    print($2)
//    return $0 + $0
//}
//
//digit(5, 6, 7)

//
//func makeSquareOf(digit: Int, completion: (Int) -> Void ) {
//
//    let squareof = digit * digit
//    completion(squareof)
//}
//makeSquareOf(digit: 5) { valuef in
//    print(valuef)
//}



// MARK: - Properties observer
//property observer are dclared as a vaiable and not as constants becaouse it is only a mutable property that can be track by properity observes hece propertiy obs declare with var not with let

// didSet - after upadate new value didSet is called (called after setting new value)
// willSet - befor update new value will set is called (called before setting new value )
//class Bank {
//    var accBal: Double {
//        didSet {
//            sendMessageToUser()
//        }
//        willSet (newAmount) {
//            if(newAmount >= 50) {
//                sendMessageToAudit(amount: newAmount)
//            }
//        }
//    }
//
//
//    init(openingBalance: Double){
//        accBal = openingBalance
//    }
//
//    func addMoney(amount: Double) {
//        accBal += amount
//    }
//
//    func widrawMoney(amount: Double) {
//        accBal -= amount
//    }
//
//    func sendMessageToUser() {
//        print("The amount will be created new amount will be \(accBal)")
//    }
//    func sendMessageToAudit(amount: Double) {
//        print("the amount is going to update with\(amount) ")
//    }
//
//    deinit{
//
//    }
//}
//
//let bank = Bank(openingBalance: 20)
//bank.addMoney(amount: 30)

//MARK: - Computed properties

//you cant asign intial value to variable
// computed properties not let constant
// get - calculate value at runtime
// set - if you want to asign value for variable after changing with new value set is usd
//class Area {
//    var radius: Double = 0
//    var aare: Double {
//        get {
//            return radius * radius * Double.pi
//        }
//        set(value) {
//            radius = sqrt(value / Double.pi)
//        }
//    }
//}
//
//var ar = Area()
//ar.aare = 20
//print(ar.radius)
//print(ar.aare)
//
//// MARK: - Optional Chaining
//
//
//// MARK: - class and struct
////
//
//
//func sum(){
//    let num = 5
//    var summ : Int
//    summ = num * (num + 1) / 2
//    print(summ)
//}
////sum()
////MARK: - optional binding
//var name: String?
//
//if let name = name { print(name); print("this is print in curly") }
////print(name!)
//print("if found null\(name)")
//
//// MARK: - inout keyword
////change the value of parameter inside the function
////func changeParameter(value: inout Int){
////    value = 2
////}
////var value = 1
////changeParameter(value: &value)
////print(value)
//
//var coordinate3D = (1.0, 2.0, 3.0)
//let xAxis = coordinate3D.0
//print(xAxis)
//var c = (x:1.0, y:"rahul", z:3.0)
//let y = c.y
//print(y)
//// MARK: -
//// generic allow you to write flexible and reusable code that can work with any datatype
//struct generic<T> {
//    var x : T
//    var y : T
//    var z : T
//    init(x: T, y: T, z: T) {
//        self.x = x
//        self.y = y
//        self.z = z
//    }
//}
//var inVect = generic(x: 1, y: 2, z: 3)
//var dvext = generic(x: 0.1, y: 0.3, z: 0.2)
//
//
//extension generic {
//    mutating func add(){
//        z = x  y
//    print(z)
//    }
//
//}
//  MARK: - Polymorphism
//
//class Demo {
//    var a: Int
//    var b: Int
//    var c: Int
//
//    init(a:Int, b:Int, c:Int){
//        self.a = a
//        self.b = b
//        self.c = c
//    }
//
//    func add(a:Int, b:Int) {
//
//    }
//    func add(a:Int,b:Int,c:Int) {
//
//    }
//
//
//}
//
//
//class Demo2: Demo {
//    override func add(a: Int, b: Int) {
//        <#code#>
//    }
//    override func add(a: Int, b: Int, c: Int) {
//        <#code#>
//    }
//}
// MARK: - DataStructure in Swift
/*
// MARK: - stack
 */
 

//class Node {
//
//    var value : Int
//    var next: Node?
//    init(value: Int) {
//        self.value = value
//    }
//}
//
//class Stack {
//    var top : Node?
//
//    func push(_ value: Int) {
//        let oldTop = top
//        top = Node(value: value)
//        top?.next = oldTop
//    }
//
//    func pop() -> Int? {
//        var currentTop = top
//        top = top?.next
//
//        return currentTop?.value
//    }
//
//    func peek() -> Int? {
//        return top?.value
//    }
//}
//
//
//let stack = Stack()
//stack.push(1)
//stack.push(2)
//stack.push(3)
//
//let firstPop = stack.pop()
//let secpop  = stack.pop()
//let pek = stack.peek()

// Stack  using type user

//
//class Node {
//
//    var value : User
//    var next: Node?
//    init(value: User) {
//        self.value = value
//    }
//}
//
//class Stack {
//    var top : Node?
//
//    func push(_ value: User) {
//        let oldTop = top
//        top = Node(value: value)
//        top?.next = oldTop
//    }
//
//    func pop() -> User? {
//        var currentTop = top
//        top = top?.next
//
//        return currentTop?.value
//    }
//
//    func peek() -> User? {
//        return top?.value
//    }
//}
//
//
//struct User {
//    let name: String
//    let userName: String
//}
//
//let me = User(name: "rahul", userName: "@rahul96")
//let you = User(name: "You", userName: "@you")
//let userStack =  Stack()
//userStack.push(me)
//userStack.push(you)
//
//let firstPop = userStack.pop()
//userStack.peek()


// STack generics

//
//class Node<T> {
//    var value : T
//    var next: Node?
//    init(value: T) {
//        self.value = value
//    }
//}
//
//class Stack<T> {
//
//    var top : Node<T>?
//
//    func push(_ value: T) {
//        let oldTop = top
//        top = Node(value: value)
//        top?.next = oldTop
//    }
//
//    func pop() -> T? {
//        let currentTop = top
//        top = top?.next
//        return currentTop?.value
//    }
//
//    func peek() -> T? {
//        return top?.value
//    }
//}
//
//
//struct User {
//    let name: String
//    let userName: String
//}
//
//let me = User(name: "rahul", userName: "@rahul96")
//let you = User(name: "You", userName: "@you")
//let userStack =  Stack<User>()
//userStack.push(me)
//userStack.push(you)
//
//let firstPop = userStack.pop()
//userStack.peek()
//
//
////let me = Node()
////let you = User(name: "You", userName: "@you")
//
//let numStack =  Stack<Int>()
//numStack.push(1)
//numStack.push(2)
//numStack.push(3)
//
//let sec = numStack.pop()
//numStack.peek()
//
//

//// MARK: - Binary Search Three
/* let number  = [1,2,4,6,7,8,9,13,16,18,23,29,35,38,41,48]
key - 23
                   midvalue
 [1,2,4,6,7,8,9,13,  16,  18,23,29,35,38,41,48]
 key>midvalue (23>16)
 repeat    midValue
 [ 18,23,29,  35,  38,41,48]
 key<midvalue(23<35)
 repeat
      midvalue
 [ 18,   23 , 29]
key == midvalue
 element found
*/

//func binarySearch (array: [Int], key: Int) -> Bool {
//    if array.count == 0  { return false }
//    let minIndex = 0
//    let maxIndex = array.count - 1
//    let midIndex = maxIndex/2
//    let midValue = array[midIndex]
//    if key < array[minIndex] || key > array[maxIndex] {
//        print("\(key)-Key is not in array ")
//    return false
//    }
//    if key > midValue {
//        let slice = Array(array[midIndex + 1...maxIndex])
//        return binarySearch(array: slice, key: key)
//    }
//    if key < midValue {
//        let slice = Array(array[minIndex...midIndex - 1])
//        return binarySearch(array: slice, key: key )
//    }
//    if key == midValue {
//        print("\(key) found in the array ")
//        return true
//    }
//    return false
//    }
//binarySearch(array: number, key: 18)

////   MARK:  - Merge sort
///
//[7,3,1,8,5,4,2,6]
//[7] [3] [1] [8] [5] [4] [2] [6]
//[3,7] [1,8] [4,5] [2,6]
//[1,3,7,8] [2,4,5,6]
//[1,2,3,4,5,6,7,8]


//spilt
//func mergeSort(array: [Int]) -> [Int] {
//    guard array.count > 1 else {
//        return array
//    }
//    let leftArray = Array(array[0..<array.count/2])
//    let rightArray = Array(array[array.count/2..<array.count])
//
//    return merge(left: mergeSort(array: leftArray), right: mergeSort(array: rightArray))
//}
//
//
////mergeArray
//func merge(left:[Int], right: [Int]) -> [Int] {
//
//    var mergeArray: [Int] = []
//    var left = left
//    var right = right
//    while left.count > 0 && right.count > 0 {
//        if left.first! < right.first! {
//            mergeArray.append(left.removeFirst())
//        }else {
//            mergeArray.append(right.removeFirst())
//        }
//    }
//    return mergeArray + left + right
//}
//var a = mergeSort(array: [1,4,6,3,7,9,8,2])
//print(a)

/* MARK: - bubble sort algorithm
        1               2
 [8,7,5,6,4,9,3]    [7,5,6,4,8,3,9] [5,6,4,7,3,8,9]
 [7,8,5,6,4,9,3]    [5,7,6,4,8,3,9] [5,4,6,7,3,8,9]
 [7,5,8,6,4,9,3]    [5,6,7,4,8,3,9] [5,4,6,3,7,8,9]
 [7,5,6,8,4,9,3]    [5,6,4,7,8,3,9]
 [7,5,6,4,8,9,3]    [5,6,4,7,3,8,9]
 [7,5,6,4,8,3,9]
 
 
 
 */
//func bubbleSort(array: inout [Int] ) -> [Int] {
//    var isSorted = false
//    var counter = 0
////    var temp: [Int] = []
//    while !isSorted {
//        isSorted = true
//        for i in 0..<array.count - 1 - counter {
//            if array[i] > array[i+1] {
//                array.swapAt(i, i+1)
//                isSorted = false
//            }
//        }
//        counter = counter + 1
//    }
//    return array
//}
//var array:[Int] = [8,7,5,6,4,9,3]
//bubbleSort(array: &array)


