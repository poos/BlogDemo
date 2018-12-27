// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import ObjectMapper

// MARK: Person Mappable
extension Person: Mappable {
    init?(map: Map) {
        return nil
    }
    mutating func mapping(map: Map) {
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        birthDate <- map["birth_data"]
        friend <- map["friend.0.value"]
        lalala <- map["lalala.value"]
    }
}
