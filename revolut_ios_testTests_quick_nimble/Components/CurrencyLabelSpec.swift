//
//  CurrencyLabelSpec.swift
//  revolut_ios_testTests_quick_nimble
//
//  Created by Hannes Van den Berghe on 14/08/2020.
//  Copyright © 2020 HannesVDB. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import revolut_ios_test

class CurrencyLabelSpec: QuickSpec {
    override func spec() {
        describe("CurrencyLabelSpec") {
            var sut: CurrencyLabel!
            var view: UIView!
            let frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            
            beforeEach {
                view = UIView(frame: frame)
                sut = CurrencyLabel()
                sut.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(sut)
                sut.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                sut.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            }
            
            context("UI") {
                it("should have the correct initial state") {
                    expect(view) == snapshot()
                }
                
                it("should set the correct value") {
                    sut.set(value: 1.2)
                    expect(view) == snapshot()
                }
                
                it("should set the correct long decimal value") {
                    sut.set(value: 0.1588080)
                    expect(view) == snapshot()
                }
                
                it("should set the correct long value") {
                    sut.set(value: 158808.01)
                    expect(view) == snapshot()
                }
                
                it("should be show the infinity indicator") {
                    sut.set(value: Double.infinity)
                    expect(view) == snapshot()
                }
            }
        }
    }

}
