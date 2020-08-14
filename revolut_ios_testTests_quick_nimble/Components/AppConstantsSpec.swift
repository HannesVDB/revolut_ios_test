//
//  AppConstantsSpec.swift
//  revolut_ios_testTests_quick_nimble
//
//  Created by Hannes Van den Berghe on 14/08/2020.
//  Copyright © 2020 HannesVDB. All rights reserved.
//

import Quick
import Nimble

@testable import revolut_ios_test

class AppConstantsSpec: QuickSpec {
    override func spec() {
        
        describe("AppConstans") {
            
            it("should have the correct base URL") {
                expect(AppConstants.baseURL?.absoluteString) == "https://europe-west1-revolut-230009.cloudfunctions.net/"
            }
            
            it("should use the correct data container") {
                expect(AppConstants.coreDataContainer) == "revolut_ios_test"
            }
            
            it("should have the correct currencies storyboard name") {
                expect(AppConstants.currenciesStoryboardName).to(equal("Currencies"))
            }
        }
    }
}
