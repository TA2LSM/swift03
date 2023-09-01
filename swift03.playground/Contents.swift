import Foundation


//--- 23. GENERICS ---

// for reusable codes. Swift based on generics

// Array<Element>
//let names: [String] = ["ali", "veli"]
//let numbers: [Int] = [1, 2, 3]

// T is a generic place holder. It could be anything (X, Y, NEWTYPE...) but T is common
//func printMe<T>(value: T) {
//    print(value)
//}
//printMe(value: "ali")
//printMe(value: 5)
//printMe(value: Person(name: "ali", age: 32))

// <T: Equatable & Comparable & ...>
//func isEqual<T: Equatable>(val1: T, val2: T) -> Bool {
//    val1 == val2
//}
//isEqual(val1: 3, val2: 3)
//isEqual(val1: 3, val2: 4)
//isEqual(val1: "ali", val2: "ali")
////isEqual(val1: "ali", val2: 3)           // not allowed


// reusable generic type
//protocol Storable {
//    var storedData: String { get }
//}
//
//struct Person: Storable {
//    let name: String
//    let surname: String
//
//    var storedData: String {
//        return "Fullname is \(name) \(surname)"
//    }
//}
//
//struct Animal: Storable {
//    let name: String
//    let type: String
//
//    var storedData: String {
//        return "Animal name is \(name) and type is \(type)"
//    }
//}

//--- These below will be change to...
//class PersonStorage {
//    var lastPerson: Person!
//
//    func store(person: Person) {
//        let data = person.storedData
//        //data.write(to: <#T##URL#>, atomically: <#T##Bool#>, encoding: <#T##String.Encoding#>)
//
//        lastPerson = person
//    }
//}
//class AnimalStorage {
//    var lastAnimal: Animal!
//
//    func store(animal: Animal) {
//        let data = animal.storedData
//        //data.write(to: <#T##URL#>, atomically: <#T##Bool#>, encoding: <#T##String.Encoding#>)
//
//        lastAnimal = animal
//    }
//}
//let personStorage = PersonStorage()
//personStorage.store(person: Person(name: "ali", surname: "guler"))
//personStorage.lastPerson.name
//
//let animalStorage = AnimalStorage()
//animalStorage.store(animal: Animal(name: "pamuk", type: "bird"))
//animalStorage.lastAnimal.name

// these...

//// Superclass
//class Storage {
//    var lastItem: Storable!
//
//    func store(item: Storable) {
//        let data = item.storedData
//        //data.write(to: <#T##URL#>, atomically: <#T##Bool#>, encoding: <#T##String.Encoding#>)
//
//        lastItem = item
//    }
//}
//
//// Subclass
//class PersonStorage: Storage {
//}
//
//// Subclass
//class AnimalStorage: Storage {
//}
//
//let personStorage = PersonStorage()
//personStorage.store(item: Person(name: "ali", surname: "guler"))
//personStorage.store(item: Animal(name: "pamuk", type: "bird"))          // not good!
//(personStorage.lastItem as! Person).name                                // not good!
//
//let animalStorage = AnimalStorage()
//animalStorage.store(item: Animal(name: "pamuk", type: "bird"))
//animalStorage.lastItem.name

// and these...

// Superclass
//class Storage<T: Storable> {
//    var lastItem: T!            // forced unwrapped
//
//    func store(item: T) {
//        let data = item.storedData
//        //data.write(to: <#T##URL#>, atomically: <#T##Bool#>, encoding: <#T##String.Encoding#>)
//
//        lastItem = item
//    }
//}
//
//// Subclass
//class PersonStorage: Storage<Person> {
//}
//
//// Subclass
//class AnimalStorage<T: Storable>: Storage<T> {
//}
//
//let personStorage = PersonStorage()
//personStorage.store(item: Person(name: "ali", surname: "guler"))
////personStorage.store(item: Animal(name: "pamuk", type: "bird"))          // not allowed!
//
//let animalStorage = AnimalStorage<Animal>()
//animalStorage.store(item: Animal(name: "pamuk", type: "bird"))
//animalStorage.lastItem.name

// and finally these...

//class Storage<T: Storable> {
//    var lastItem: T!            // forced unwrapped
//
//    func store(item: T) {
//        let data = item.storedData
//        //data.write(to: <#T##URL#>, atomically: <#T##Bool#>, encoding: <#T##String.Encoding#>)
//
//        lastItem = item
//    }
//}
//
//let personStorage = Storage<Person>()
//personStorage.store(item: Person(name: "ali", surname: "guler"))
//personStorage.lastItem.name
//
//let animalStorage = Storage<Animal>()
//animalStorage.store(item: Animal(name: "pamuk", type: "bird"))
//animalStorage.lastItem.name


// Extension
//let numbers: Array<Int> = [1, 2, 3]
//let list: Array<Int>()

//extension Array where Element == Int {      // type constraint
//    func sum() -> Int {
//        var sum = 0
//
//        for i in 0..<count {
//            sum += self[i]
//        }
//
//        return sum
//    }
//}
//let numbers = [1, 2, 4]
//numbers.sum()
//let items = ["ali", "veli"]
//items.sum()             // not allowed



//--- 24. EXAMPLES FOR GENERICS ---

//let list: [String] = ["ali", "veli", "ayse"]

// functions like "map" are high order functions
// These functions take or return functions too

//let list2: [] = list.map { name in
//    return "hello \(name)"
//}
// OR
//let list2: [String] = list.map {
//    return "hello \($0)"
//}
//
//let list3: [Int] = list.map {
//    return $0.count
//}

// high order function: takes function as a parameter with string array
//func map2(array: [String], transform: (String) -> Int) -> [Int] {
//    var result: [Int] = []
//
//    for item in array {
//        let transformedItem: Int = transform(item)
//        result.append(transformedItem)
//    }
//
//    return result
//}
//
//let list4 = map2(array: list) { $0.count }          // $0.count is a transform function above

// generic high order function: input parameter function transforms T to U
//func map2<T, U>(array: [T], transform: (T) -> U) -> [U] {
//    var result: [U] = []
//
//    for item in array {
//        let transformedItem: U = transform(item)
//        result.append(transformedItem)
//    }
//
//    return result
//}
//let list4 = map2(array: list) { $0.count }          // $0.count is a transform function above
//
//
////func reverse<T>(array: [T]) -> [T] {
////    var result: [T] = []
////
////    for item in array.reversed() {
////        result.append(item)
////    }
////
////    return result
////}
//// OR
//extension Array {
//    func reverse() -> [Element] {               // Element comes with extension Array
//        var result: [Element] = []
//
//        for item in self.reversed() {
//            result.append(item)
//        }
//
//        return result
//    }
//}


//func uniqueValues<T: Hashable>(array: [T]) -> [T] {
//    //return Array(Set(array))                // set removes same values from array
//
//    var result: [T] = []
//
//    for item in array {
//        if result.contains(item) {
//            continue
//        }
//
//        result.append(item)
//    }
//
//    return result
//}


//class Calculator<T: Numeric> {
//    func add(a: T, b: T) -> T { a + b }
//    func multiply(a: T, b: T) -> T { a * b }
//}
//
//let calculator = Calculator<Int>()       // calculator is an instance
//calculator.add(a: 2, b: 3)
//
//let calculator2 = Calculator<Double>()
//calculator2.multiply(a: 2.3, b: 3.6)


//class Pair<T, U> {
//    private(set) var firstParam: T
//    private(set) var secondParam: U
//
//    init(first: T, second: U) {
//        self.firstParam = first
//        self.secondParam = second
//    }
//}
//
//let pair = Pair(first: "TA2LSM", second: 1764)
//let pair2 = Pair(first: 2.34, second: "deneme")
//print(pair.firstParam, pair.secondParam)
//print(pair2.firstParam, pair2.secondParam)



//--- 25. CODABLE ---
// Encodable >> encode data to sending format (send data to server)
// Decodable >> decode data from receiving format (receive data from server)

//struct Person {
//    let name: String
//    let surname: String
//
//    // JSON data format
//    var jsonMessage: String {
//         return """
//         {
//             "name": \(name)
//             "surname": \(surname)
//         }
//         """
//    }
//}

//struct Person: Codable { // Codable >> Encodable & Decodable
//    let name: String
//    let surname: String
//    let age: Int?
//}
//let person = Person(name: "TA2LSM", surname: "Super!", age: 40)
//
//let jsonEncoder = JSONEncoder()
//let jsonDecoder = JSONDecoder()
//var encodedData: Data = "{}".data(using: .utf8)!
//var decodedData: Person
//let encodedData2 = """
//{
//    "name": "test",
//    "surname": "deneme"
//}
//""".data(using: .utf8)!
//
//do {
//    encodedData = try jsonEncoder.encode(person)
//    //print(encodedData)
//
//    //URLSession uses data format
//} catch {
//    print("ERROR: Encoder", error)
//}
//
//do {
//    decodedData = try jsonDecoder.decode(Person.self, from: encodedData2)
////    decodedData = try jsonDecoder.decode(Person.self, from: encodedData)
//    print(decodedData)
//} catch {
//    print("ERROR: Decoder", error)
//}

// In Swift general aproach about naming is camelSize, but generally in backend
// snake_size used by most coders
//struct Person: Codable { // Codable >> Encodable & Decodable
//    let firstName: String
//    let lastName: String
//}
//
//let jsonDecoder = JSONDecoder()
//jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//
//do {
//    let testData = """
//    {
//        "first_name": "test",
//        "last_name": "deneme"
//        "date_of_birth": "06.09.1983"
//    }
//    """.data(using: .utf8)!
//
//    let person = try jsonDecoder.decode(Person.self, from: testData)
//    print(person)
//} catch {
//    print("ERROR: Decoder", error)
//}


//struct Person: Codable { // Codable >> Encodable & Decodable
//    enum CodingKeys: String, CodingKey {
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case birthday = "date_of_birth"
//        case age
//    }
//
//    let firstName: String
//    let lastName: String
//    let birthday: String
//    let age: Int
//}
//
//let jsonDecoder = JSONDecoder()
//
//do {
//    let testData = """
//    {
//        "first_name": "test",
//        "last_name": "deneme",
//        "date_of_birth": "06.09.1983",
//        "age": 40
//    }
//    """.data(using: .utf8)!
//
//    let person = try jsonDecoder.decode(Person.self, from: testData)
//    print(person)
//} catch {
//    print("ERROR: Decoder >>", error)
//}


//struct Person: Codable { // Codable >> Encodable & Decodable
//    enum CodingKeys: String, CodingKey {
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case birthday = "date_of_birth"
//    }
//
//    let firstName: String
//    let lastName: String
//    let birthday: Date
//}
//
//let formatter = DateFormatter()
//formatter.dateFormat = "dd.MM.yyyy"
//
//let jsonDecoder = JSONDecoder()
//jsonDecoder.dateDecodingStrategy = .formatted(formatter)
//
//do {
//    let testData = """
//    {
//        "first_name": "test",
//        "last_name": "deneme",
//        "date_of_birth": "06.09.1983"
//    }
//    """.data(using: .utf8)!
//
//    let person = try jsonDecoder.decode(Person.self, from: testData)
//    print(person)
//} catch {
//    print("ERROR: Decoder >>", error)
//}


//struct Product: Decodable {
//    let name: String
//    let price: String
//}
//
//let json = """
//[
//    {
//        "name": "Apple Watch 8",
//        "price": "399$"
//    },
//    {
//        "name": "Apple MacBook Pro M2 16-inch",
//        "price": "3499$"
//    },
//]
//"""
//
//let object = try? JSONDecoder().decode(
//    [Product].self,                 // tell compiler this is an array
//    from: json.data(using: .utf8)!
//)
//print(object)


//struct Price: Decodable {
//    let amount: Int
//    let currency: String
//}
//
//struct Product: Decodable {
//    let name: String
//    let price: Price
//}
//
//let json = """
//{
//    "name": "Apple Watch 8",
//    "price": {
//        "amount": 399,
//        "currency": "$"
//    }
//}
//"""
//
//let object = try? JSONDecoder().decode(
//    Product.self,
//    from: json.data(using: .utf8)!
//)
//print(object)


// custom decoding
//struct Product: Codable {
//    enum CodingKeys: String, CodingKey {
//        case name
//        case price
//    }
//
//    enum PriceCodingKeys: String, CodingKey {
//        case amount
//        case currency
//    }
//
//    let name: String
//    let price: String
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: CodingKeys.name)
//
//        let priceContainer = try container.nestedContainer(
//            keyedBy: PriceCodingKeys.self,
//            forKey: CodingKeys.price
//        )
//        let amount = try priceContainer.decode(Int.self, forKey: PriceCodingKeys.amount)
//        let currency = try priceContainer.decode(String.self, forKey: PriceCodingKeys.currency)
//        self.price = "\(amount)\(currency)"
//    }
//
//    // override
////    func encode(to encoder: Encoder) throws {
////        var container = try encoder.container(keyedBy: CodingKeys.self)
////        try container.encode(self.name, forKey: CodingKeys.name)
////
////        var priceContainer = try container.nestedContainer(
////            keyedBy: PriceCodingKeys.self,
////            forKey: CodingKeys.price
////        )
////
////        //...
////    }
//}
//
//let json = """
//{
//    "name": "Apple Watch 8",
//    "price": {
//        "amount": 399,
//        "currency": "$"
//    }
//}
//"""
//
//let object = try? JSONDecoder().decode(
//    Product.self,
//    from: json.data(using: .utf8)!
//)
//print(object)



//--- 26. PROPERTY WRAPPERS ---

//@propertyWrapper
//struct Uppercase {
//    private var text: String
//
//    var wrappedValue: String {
//        // Override these properties on String
//        get {
//            return text.localizedUppercase
//        }
//
//        // new value is a special keyword
//        set {
//            self.text = newValue.localizedUppercase
//        }
//    }
//
//    // wrappedValue is a special keyword
//    init(wrappedValue: String) {
//        self.text = wrappedValue
////        self.text = wrappedValue.localizedUppercase       // no need to do this in here
//    }
//}
//
//struct Person {
//    // property wrappers CAN NOT to be used as root level of code
//    // written in Person struct
//    @Uppercase
//    var name = "ta2lsm"
//
//    @Uppercase
//    var surname = "super!"
//}
//
//// getting name property
//Person().name
//Person().surname


//@propertyWrapper
//struct FormattedNumber {
//    private var number: Double = 0
//
//    var wrappedValue: String {
//        get {
//            String(format: "%.2f", number)
//        }
//
//        set {
//            number = Double(newValue) ?? 0       // cast newValue of String as double if fails set as 0
////            self.number = Double(newValue) ?? 0
//        }
//    }
//}
//
//struct Price {
//    @FormattedNumber public var amount: String      // without "public" amount is not accessible
//}
//
//var price = Price()
//price.amount = "100.275321"
//print(price.amount)
//print(Double(price.amount)!)


//@propertyWrapper
//struct ValidatedString {
//    private var returnValue: String = ""        // without empty string ("") here we MUST use user = Text(name: "...")
//
//    var wrappedValue: String {
//        get { returnValue }
//
//        set {
//            returnValue = String(newValue.prefix(10))
//        }
//    }
//}
//
//struct Text {
//    @ValidatedString public var name: String
//}
//
//var user = Text()
//user.name = "ta2lsm"
//print(user.name)
//user.name = "this string has more than 10 characters"
//print(user.name)


// burritos -> github
//@propertyWrapper
//struct UndoRedo<T> {
//    private var index: Int = -1
//    private var values: [T] = []
//
//    var wrappedValue: T {
//        get {
//            values[index]
//        }
//
//        set {
//            index += 1
//            values.append(newValue)
//        }
//    }
//
//    mutating func undo() {
//        if index > -1 {
//            index -= 1
//            values.removeLast()
//        }
//    }
//
//}
//
//struct Test {
//    @UndoRedo var name: String
//    @UndoRedo var age: Int
//
//    mutating func undoAll() {
//        _name.undo()
//        _age.undo()
//    }
//}
//
//var test = Test()
//test.name = "ayse"
//test.name = "ali"
//test.name = "veli"
//
//test.age = 35
//test.age = 40
//
//test.name
//test.age
//test.undoAll()
//test.name
//test.age


// UserDefaults
//@propertyWrapper
//struct UserDefault<T> {
//
//    let key: String
//    let defaultValue: T
//
//    var wrappedValue: T {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: key)
//        }
//
//        get {
//            UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
//        }
//    }
//}
//
//struct App {
//    @UserDefault(key: "is_app_opened_before", defaultValue: false)
//    var isOpened: Bool
//}
//
//var app = App()
//app.isOpened
//app.isOpened = true
//app.isOpened



//--- 27. MEMORY MANAGEMENT ---

// For RAM optimization we should use class
// There is no "Garbage Collector" in IOS because of some delay when collector works
// and bad user experience.

// Manual Memory Management
//class Person {
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//    deinit {
//        print("Person: \(name) removed!")
//    }
//}
//
//// BEFORE
////let person1 = Person(name: "TA2LSM")
////person1.release()
//
////let person1 = Person(name: "TA2LSM").autorelease()
////person1.release()               // PROBLEM: already erased
//
//class App {
//    var person: Person?
//
//    deinit {
//        print("App removed!")
//    }
//}
//
//// When swiftUI these kind of things will not to be needed
//// swiftUI will automatically make pages "nil" when user closes them
//
//// --- scope ---
//
//var app: App? = App()
//app?.person = Person(name: "TA2LSM")
//
//// comment out this below and try again
////var person1 = app?.person           // only app will be removed (when uncommented)
//
//app = nil                           // app and person will be removed
////person1 = nil                     // app and person will be removed (when uncommented)
//
// --- end of scope ---


//class Person {
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//    deinit {
//        print("Person: \(name) removed!")
//    }
//}
//
//class App {
//    var person: Person?
//
//    deinit {
//        print("App removed!")
//    }
//
//    func test() {
//        let person1 = Person(name: "TA2LSM")
//        let person2 = Person(name: "Super!")
//
//        // uncomment this below and try again
//        //person = person1
//    }
//}
//
//// --- scope ---
//var app: App? = App()
//print("Pos: 1")
//app?.test()
//print("Pos: 2")
//// --- end of scope ---


// Retain Cycle (BIG MEMOTY ISSUE)
//class Person {
//    var pet: Dog?               // strong reference with Dog class
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("Person: \(name) removed!")
//    }
//}
//
//class Dog {
//    var owner: Person?          // strong reference with Person class
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("Dog: \(name) removed!")
//    }
//}
//
////var person1: Person? = Person(name: "TA2LSM")
////person1?.pet?.name
////person1?.pet = Dog(name: "Brutus")
////person1?.pet?.name
////
//////var refDog = person1?.pet
//////person1 = nil           // person will be removed
////
////person1 = nil           // person and dog will be removed
//
//
//var person1: Person? = Person(name: "TA2LSM")
//var dog1: Dog? = Dog(name: "Brutus")
//person1?.pet?.name
//person1?.pet = dog1
//person1?.pet?.name
//dog1?.owner = person1
//
//person1 = nil           // nothing will be removed (RETAIN CYCLE)
//dog1 = nil


//class Person {
//    var pet: Dog?               // strong reference with Dog class
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("Person: \(name) removed!")
//    }
//}
//
//class Dog {
//    weak var owner: Person?          // weak reference with Person class (this allows person = nil)
////    unowned var owner: Person
//
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("Dog: \(name) removed!")
//    }
//}
//
//var person1: Person? = Person(name: "TA2LSM")
//var dog1: Dog? = Dog(name: "Brutus")
//person1?.pet?.name
//person1?.pet = dog1
//person1?.pet?.name
//dog1?.owner = person1
////dog1?.owner = person1!          // because of "unowned" keyword in Dog class
//
//person1 = nil               // person will be removed
//dog1 = nil                  // dog will be removed


//--- 28. CONCURRENCY ---

// more than one process work on the same time even they are independed from each other
// context switch (Single Core CPU)
// parallelism (Multi Core CPU)
// Thread: process working on CPU's core


//func loadUser() async -> Int {
//    let url = URL(string: "https://reqres.in/api/users/2")!
////    let url = URL(string: "https://jsonplaceholder.org/users/1")!
//
//    do {
//        let result = try await URLSession.shared.data(from: url)        // code suspends here but not thread!
//
////        print((result.1 as! HTTPURLResponse).statusCode)                // code resumes on any thread (coul not be the same thread)
//        return (result.1 as! HTTPURLResponse).statusCode
//    } catch {
//        print("ERROR (HTTP GET) >>", error)
//        return -1
//    }
//}


//print("POS 1")
//
//func loadUser() async -> Int {
//    let url = URL(string: "https://reqres.in/api/users/2")!
//    let result = try? await URLSession.shared.data(from: url)
//
//    return (result?.1 as? HTTPURLResponse)?.statusCode ?? -1
//}
//
////await loadUser()
//
////func main() async {
////    loadUser()
////}
//
//func main() {
//    print("a")
//
//    let task = Task {
//        try? await Task.sleep(nanoseconds: NSEC_PER_SEC * 3)
//
//        let result = await loadUser()
//
//        print("Task cancelled:", Task.isCancelled)
//
//        // check if this task cancelled here! (cooperative cancellation)
//
//        print(result)
//    }
//
//    // uncomment below and try again
////    task.cancel()     // this will not give a guarantee to stop task
//
//    print("b")
//}
//
//main()
//print("POS 2")


// async let

//import UIKit
//
//func downloadImage(id: Int) async -> UIImage {
//    let url = URL(string: "https://picsum.photos/200")!
//
//    let data = try! await URLSession.shared.data(from: url)
//    return UIImage(data: data.0)!
//}
//
//func downloadImages() {
//    Task {
//        async let image1 = downloadImage(id: 1)     // independed processes (context switch)
//        async let image2 = downloadImage(id: 2)
//        async let image3 = downloadImage(id: 3)
//
//        let images = await [image1, image2, image3]
//    }
//}
//
//downloadImages()


//--- 29. ADVANCED PROTOCOLS ---

//protocol Talking {
////    var name: String { get }
//
//    func talk()
//    init(name: String, sound: String)
//}
//
//protocol Talking2 {
////    var name: String { get }
//
//    func talk()
//    init(sound: String)
//}
//
//protocol Walking {
//    func walk()
//}
//
//struct Person: Talking, Walking {
//    let name: String
//    let sound: String
//
//    init(name: String, sound: String) {
//        self.name = name
//        self.sound = sound
//    }
//
//    func talk() {
//        print("\(name) is talking: \(sound)")
//    }
//
//    func walk() {
//        print("\(name) is walking...")
//    }
//}
////-----------------
//
//let person = Person(name: "TA2LSM", sound: "bla-bla")
////person.talk()
//
////-----------------
//struct Animal {
//    let name: String
//    let sound: String
//
//    init(name: String, sound: String) {
//        self.name = name
//        self.sound = sound
//    }
//}
//
//extension Animal: Talking {
//    func talk() {
//        print("\(name) is talking: \(sound)")
//    }
//}
////-----------------
//
//let animal = Animal(name: "Bird", sound: "cik-cik")
//
//// checking if person conforms to Walking
////person as? Walking
////person is Walking
////animal as? Talking
//
////if animal is Talking {
////    print("This could be a Parrot!")
////} else {
////    print("Animals can't talk! Are they?")
////}
//
////animal.talk()
//
//class TalkShow {
//    let talkingItems: [Talking]
//
//    init(_ talkingItems: [Talking]) {
//        self.talkingItems = talkingItems
//    }
//
//    func cheer() {
//        talkingItems.forEach { $0.talk() }
//    }
//}
//
//let show = TalkShow([person, animal])
//show.cheer()
//
////-----------------
//class Man {
//    let name: String
////    let sound: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    required init(sound: String) {
////        self.sound = sound
//        name = ""
//    }
//}
//
//class SuperMan: Man {
//    // no problem
//}
//
//extension Man: Talking2 {
//    func talk() {
//        print("Hello my name is \(name)")
//    }
//}
//
//final class Woman {
//    let name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    init(sound: String) {
//        name = ""
//    }
//}
//
//extension Woman: Talking2 {
//    func talk() {
//        print("Hello my name is \(name)")
//    }
//}

//-----------------

//protocol Talking {
//    func talk()
//}
//
//protocol Walking {
//    func walk()
//}
//
//// protocol extension
//extension Walking {
//    func walk() {
//        print("walking...")
//    }
//}
//
//struct Person {
//    let name: String
//}
//
//extension Person: Talking {
//    func talk() {
//        print("Hello my name is \(name)")
//    }
//}
//
//extension Person: Walking { }
//
//class Animal: Talking, Walking {
//    let name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    func talk() {
//        print("hav-hav")
//    }
//
//    func walk() {
//        print("\(name) is walking...")
//    }
//}
//
//let person = Person(name: "TA2LSM")
//let animal = Animal(name: "Bird")
//let animal2 = Animal(name: "Cat")
//
//
//// conditional conformance
//extension Array: Talking where Element == Talking {
//    func talk() {
//        self.forEach { item in
//            item.talk()
//        }
//    }
//}
//
////let array: [Talking] = [person, animal, animal2]
////array.talk()
//
//typealias type = Talking & Walking
//
//class TalkShow {
//    let items: [type]     // protocol composition
//
//    init(_ items: [type]) {
//        self.items = items
//    }
//
////    func cheer() {
////        items.talk()
//          // CAN NOT to be used with items.forEach...
////    }
//
//    func cheer() {
//        items.forEach { e in
//            e.talk()
//        }
//
//        items.forEach { e in
//            e.walk()
//        }
//    }
//}
//
//let show = TalkShow([person, animal, animal2])
//show.cheer()


// Associated type

struct Person: Decodable {
    let name: String
}

struct Account: Decodable {
    let accountNumber: Int
}

protocol Request {
    associatedtype Response: Decodable
    var url: URL { get set }
}

struct LoginRequest: Request {
    typealias Response = Person
    var url: URL = URL(string: "localhost:3000/api/v1/login")!
}

struct AccountRequest: Request {
    typealias Response = Account
    var url: URL = URL(string: "localhost:3000/api/v1/account")!
}

let loginReq = LoginRequest()
/*
 -> send request
 <- get response to data
 = call let model = JSONDecoder().decode(loginReq.Response.self, from: data)
 ! model is "nil" when account type data received because "loginReq" Response type is "Person"
 */

//--- END OF LESSON ---
// 01.09.2023
