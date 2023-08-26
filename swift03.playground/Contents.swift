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
protocol Storable {
    var storedData: String { get }
}

struct Person: Storable {
    let name: String
    let surname: String
    
    var storedData: String {
        return "Fullname is \(name) \(surname)"
    }
}

struct Animal: Storable {
    let name: String
    let type: String
    
    var storedData: String {
        return "Animal name is \(name) and type is \(type)"
    }
}

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

extension Array where Element == Int {      // type constraint
    func sum() -> Int {
        var sum = 0
        
        for i in 0..<count {
            sum += self[i]
        }
        
        return sum
    }
}

let numbers = [1, 2, 4]
numbers.sum()

let items = ["ali", "veli"]
//items.sum()             // not allowed


//--- 24. EXAMPLES FOR GENERICS ---

