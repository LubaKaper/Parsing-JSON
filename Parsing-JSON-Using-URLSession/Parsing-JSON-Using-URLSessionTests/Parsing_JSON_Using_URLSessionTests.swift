//
//  Parsing_JSON_Using_URLSessionTests.swift
//  Parsing-JSON-Using-URLSessionTests
//
//  Created by Liubov Kaper  on 8/4/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import XCTest
@testable import Parsing_JSON_Using_URLSession

class Parsing_JSON_Using_URLSessionTests: XCTestCase {

    func testModel() {
        // arrange
        let jsonData = """
        {
        "data": {
            "stations": [{
                    "lat": 40.76727216,
                    "station_type": "classic",
                    "legacy_id": "72",
                    "short_name": "6926.01",
                    "station_id": "72",
                    "eightd_has_key_dispenser": false,
                    "name": "W 52 St & 11 Ave",
                    "region_id": "71",
                    "external_id": "66db237e-0aca-11e7-82f6-3863bb44ef7c",
                    "has_kiosk": true,
                    "eightd_station_services": [],
                    "rental_methods": [
                        "CREDITCARD",
                        "KEY"
                    ],
                    "capacity": 55,
                    "lon": -73.99392888,
                    "electric_bike_surcharge_waiver": false,
                    "rental_url": "http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=72"
                },
                {
                    "lat": 40.71911552,
                    "station_type": "classic",
                    "legacy_id": "79",
                    "short_name": "5430.08",
                    "station_id": "79",
                    "eightd_has_key_dispenser": false,
                    "name": "Franklin St & W Broadway",
                    "region_id": "71",
                    "external_id": "66db269c-0aca-11e7-82f6-3863bb44ef7c",
                    "has_kiosk": true,
                    "eightd_station_services": [],
                    "rental_methods": [
                        "CREDITCARD",
                        "KEY"
                    ],
                    "capacity": 33,
                    "lon": -74.00666661,
                    "electric_bike_surcharge_waiver": false,
                    "rental_url": "http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=79"
                }
            ]
        }
        }
        """.data(using: .utf8)!
        
        let expectedCapacity = 55 // bikes
        
        do {
            let results = try JSONDecoder().decode(ResultsWrapper.self, from: jsonData)
            let stations = results.data.stations
            let firstStation = stations[0]
            
            XCTAssertEqual(expectedCapacity, firstStation.capacity)
             } catch {
              XCTFail("decoding error: \(error)")
             
            }

    }

}
