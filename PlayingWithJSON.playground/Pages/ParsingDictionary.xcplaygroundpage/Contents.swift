import Foundation


// PArsing Dictionary

let json = """
{
 "results": [
   {
     "firstName": "John",
     "lastName": "Appleseed"
   },
  {
    "firstName": "Alex",
    "lastName": "Paul"
  }
 ]
}
""".data(using: .utf8)!
//==============================================================================

// Create Models

//==============================================================================

// Codable: Decodable and Encodable
//Decodable: converts json to data
// Encodable: converts to jsondata. Post to Web API

struct ResultsWrapper: Decodable {
    let results: [Contact]
}
struct Contact: Decodable {
    let firstName: String
    let lastName: String
}

//==============================================================================
// decode JSON data to our swift model
//==============================================================================

do {
    let dictionary = try JSONDecoder().decode(ResultsWrapper.self, from: json)
    let contacts = dictionary.results// [Contact]
    dump(contacts)
} catch {
   print("decoding error: \(error)")
}
