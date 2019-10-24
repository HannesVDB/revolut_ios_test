//
//  AppConstants.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

class AppConstants {
    class var baseURL: URL? {
        return URL(string: "https://europe-west1-revolut-230009.cloudfunctions.net/")
    }
    
    class var coreDataContainer: String {
        return "revolut_ios_test"
    }
}
