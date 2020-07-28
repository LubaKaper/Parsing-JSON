

import Foundation


// JSON data

let json = """
[
    {
        "title": "New York",
        "location_type": "City",
        "woeid": 2459115,
        "latt_long": "40.71455,-74.007118"
    }
]

""".data(using: .utf8)!

//==============================================================================
// Create models:
//==============================================================================

struct City: Decodable {
    let title: String
    // reminder - onse property names changed using CodingKeys, they must match identically to the case type location_type -> locationType
    let locationType: String
    let woeid: Int
    let coordinate: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case coordinate = "latt_long"
    }
    
}

//==============================================================================
// decode JSON to swift
//==============================================================================

do {
    let weatherArray = try JSONDecoder().decode([City].self, from: json)
    dump(weatherArray)
} catch {
    print("decoding error: \(error)")
}
