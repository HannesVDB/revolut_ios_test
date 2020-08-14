//
//  ActionButtonSpec.swift
//  revolut_ios_testTests_quick_nimble
//
//  Created by Hannes Van den Berghe on 14/08/2020.
//  Copyright © 2020 HannesVDB. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import revolut_ios_test

class ActionButtonSpec: QuickSpec {
    override func spec() {
        describe("ActionButtonSpec") {
            var sut: ActionButton!
            var view: UIView!
            let frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            
            beforeEach {
                view = UIView(frame: frame)
                sut = ActionButton(frame: .zero)
                sut.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(sut)
                sut.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                sut.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            }
            
            context("UI") {
                it("should have the correct view") {
                    expect(view) == snapshot()
                }
            }
        }
    }
}
