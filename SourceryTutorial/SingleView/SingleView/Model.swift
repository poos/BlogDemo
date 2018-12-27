import Foundation

protocol AutoMappable {}

//sourcery: mappable
struct Person {
    //sourcery: jsonKey = "first_name"
    var firstName: String
    //sourcery: jsonKey = "last_name"
    var lastName: String
    //sourcery: jsonKey = "birth_data"
    var birthDate: Date
    var friend: [String]
    var lalala: Dictionary<String, Any>
    var age: Int {
        return Calendar.current.dateComponents([.year],
                                               from: birthDate,
                                               to: Date()).year ?? -1
    }
}
extension Person: AutoMappable {}
