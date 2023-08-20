//
//  GptTransformationsUtilTest.swift
//  
//
//  Created by Chris Manahan on 8/20/23.
//

@testable import gptea
import XCTest

final class GptTransformationsUtilTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMapDedupedSystemPrompts() throws {
        let (tr1, tr2) = (StringToHaikuTransformation(), StringToBulletedListTransformation())
        let systemPrompts = GptTransformationsUtil.mapDedupedSystemPrompts([
            .standard(tr1),
            .standard(tr2)
        ])

        XCTAssert(systemPrompts[0] == tr1.getSystemPrompt())
        XCTAssert(systemPrompts[1] == tr2.getSystemPrompt())
    }

    func testMapDedupedSystemPrompts_dupes() throws {
        let (tr1, tr2) = (StringToHaikuTransformation(), StringToHaikuTransformation())
        let systemPrompts = GptTransformationsUtil.mapDedupedSystemPrompts([
            .standard(tr1),
            .standard(tr2)
        ])

        XCTAssert(systemPrompts[0] == tr1.getSystemPrompt())
        XCTAssert(systemPrompts.count == 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
