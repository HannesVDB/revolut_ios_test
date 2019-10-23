//
//  ApiResponse.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

enum ApiResponse<T: Codable> {
    case failure(Error?)
    case success(T?)
}
