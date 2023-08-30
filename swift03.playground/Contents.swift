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






//--- 27. CONCURRENCY ---



//--- 28. CONCURRENCY ---

// more than one process work on the same time


//--- 29. ADVANCED PROTOCOLS ---


