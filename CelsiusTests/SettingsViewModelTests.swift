//
//  SettingsViewModelTests.swift
//  CelsiusTests
//
//  Created by Firat on 3.02.2022.
//

import XCTest
@testable import Celsius

class SettingsViewModelTests: XCTestCase {
    private var settingsViewModel: SettingsViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.settingsViewModel = SettingsViewModel()
    }
    
    func test_should_return_correct_display_name_for_fahrenheit() {
        XCTAssertEqual(self.settingsViewModel.selectedUnit.displayName, "Celsius")
    }
    
    func test_should_make_sure_that_default_selected_unit_is_fahrenheit() {
        XCTAssertEqual(settingsViewModel.selectedUnit, .celsius)
    }
    
    func test_should_be_able_to_save_user_unit_selection() {
        self.settingsViewModel.selectedUnit = .celsius
        let userDefaults = UserDefaults.standard
        XCTAssertNotNil(userDefaults.value(forKey: "unit"))
    }
    
    override func tearDown() {
        super.tearDown()
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "unit")
    }
}
