//
//  JSONSerializerSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 26/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class JSONSerializerSpec: XCTestCase {

    func testObjectForDataShouldReturnValue() {
        let json =
        """
        {
            "abbreviation": "EUR"
        }
        """
        let data = json.data(using: .utf8)
        let serializer = JSONSerializer<Currency>()
        let currency: Currency? = try? serializer.object(data: data!)
        XCTAssertNotNil(currency)
    }

    func testWrongObjectShouldThrow() {
        let json =
        """
        {
            "EUR"
        }
        """
        let data = json.data(using: .utf8)
        let serializer = JSONSerializer<Currency>()
        do {
            let _: Currency? = try serializer.object(data: data!)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testObjectsFromFileShouldReturnValue() {
        let serializer = JSONSerializer<String>()
        let objects: [String]? = try? serializer.objects(from: .currencies)
        XCTAssertNotNil(objects)
    }
    
    func testObjectsFromFileWithWrongSerializerShouldThrow() {
        let serializer = JSONSerializer<Double>()
        do {
            let _: [Double]? = try serializer.objects(from: .currencies)
        } catch {
            XCTAssertTrue(error is BackendError)
            XCTAssertNotNil(error)
        }
    }
    
}
