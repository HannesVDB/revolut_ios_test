//
//  BackendError.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

enum BackendError: Error {
    case serializationError
    case invalidURL
    case fileError
}
