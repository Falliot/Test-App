//
//  Test_appTests.swift
//  Test appTests
//
//  Created by Anton on 2/16/20.
//  Copyright © 2020 falli_ot. All rights reserved.
//

import XCTest
@testable import Test_app

class Test_appTests: XCTestCase {

    
    var view: ViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        view = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        view?.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
    }

    func testIfbuttonsHaveActionAssigned() {
        
        //Check if Controller has UIButtons property
        let camButton: UIButton = view.camera
        XCTAssertNotNil(camButton, "View Controller does not have UIButton property")
        
        let sendButton: UIButton = view.send
        XCTAssertNotNil(sendButton, "View Controller does not have UIButton property")
        
        // Attempt Access UIButtons Actions
        guard let camButtonAction = camButton.actions(forTarget: view, forControlEvent: .touchUpInside) else {
            XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
            return
        }
        guard let sendButtonAction = sendButton.actions(forTarget: view, forControlEvent: .touchUpInside) else {
            XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
            return
        }
     
        // Assert UIButtons have actions with a method name
        XCTAssertTrue(camButtonAction.contains("cameraButton:"))
        XCTAssertTrue(sendButtonAction.contains("sendButton:"))
    }
    
    
    
    func testViewControllerIsComposedOfLabel() {

        XCTAssertNotNil(self.view.dimensionsLabel, "ViewController is not composed of a dimensions label")
        XCTAssertNotNil(self.view.locationLabel, "ViewController is not composed of a location label")
    }

    func testViewControllerInitializesLabelText() {
        
         XCTAssert(self.view.dimensionsLabel.text == "Dimensions", "ViewController does not initialize the text property of UILabel correctly")
        XCTAssert(self.view.locationLabel.text == "Location", "ViewController does not initialize the text property of UILabel correctly")
    }
    
    func testLabelAfterButtonTap() {
        
        let button: UIButton = UIButton()
        view.cameraButton(button)
        view.sendButton(button)
        
        
        let expectedDimensionsLabelText = "Dimensions"
        let actualDimensionsLabelText = view.dimensionsLabel.text
        
        
        XCTAssertEqual(expectedDimensionsLabelText, actualDimensionsLabelText, "Label text of: \(expectedDimensionsLabelText) not equal to text: \(String(describing: actualDimensionsLabelText))")
        
        let expectedLocationLabelText = "Location"
        let actualLocationLabelText = view.locationLabel.text
        
        
        XCTAssertEqual(expectedLocationLabelText, actualLocationLabelText, "Label text of: \(expectedLocationLabelText) not equal to text: \(String(describing: actualLocationLabelText))")
        
    }
    
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
