//
//  ApiClientTests.swift
//  PhotosChallengeTests
//
//  Created by Front Tech on 21/05/2022.
//

import XCTest
import RxSwift
@testable import PhotosChallenge
import OHHTTPStubs

class ApiClientTests: XCTestCase {
    
    let apiService: PhotosServiceProtocol = ApiService()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() throws {
        //given
        stub { (urlRequest) -> Bool in
            return urlRequest.url?.absoluteString.contains("/discover/movie") ?? false
        } response: { (urlRequest) -> HTTPStubsResponse in
            
            let jsonModel: [[String:Any]] = [
                ["id":"52088450146","owner":"190430386@N05","secret":"72d31395c9","server":"65535","farm":66,"title":"Special Yellow Embroidered Festive Wear Gown With Dupatta","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088443216","owner":"184867343@N05","secret":"fe3f3b16e3","server":"65535","farm":66,"title":"Ocean Waves - Kauai, Hawaii (3)","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088938880","owner":"69056479@N06","secret":"9c6ef96189","server":"65535","farm":66,"title":"8 HOUSES","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088465183","owner":"69056479@N06","secret":"77dc94643d","server":"65535","farm":66,"title":"8 HOUSES","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088938670","owner":"69056479@N06","secret":"c48e40bf3f","server":"65535","farm":66,"title":"8 HOUSES","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52087409957","owner":"69056479@N06","secret":"bd5444ff14","server":"65535","farm":66,"title":"8 HOUSES","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088450348","owner":"137307422@N03","secret":"8970bdac01","server":"65535","farm":66,"title":"...","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088420201","owner":"66623891@N02","secret":"5f34435b72","server":"65535","farm":66,"title":"Abstracto Urbano (Urban Abstract)","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088904235","owner":"91642141@N00","secret":"a27fcee47d","server":"65535","farm":66,"title":"Seawall Twilight","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088396796","owner":"195023831@N04","secret":"a25f10eaa5","server":"65535","farm":66,"title":"Auckland City of Color","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52087366152","owner":"195023831@N04","secret":"4a51651317","server":"65535","farm":66,"title":"Auckland City of Color","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088421308","owner":"195023831@N04","secret":"e0283e286b","server":"65535","farm":66,"title":"Auckland City of Color","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088643424","owner":"195023831@N04","secret":"e7e650a633","server":"65535","farm":66,"title":"Auckland City of Color","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088643369","owner":"195023831@N04","secret":"30596bc74a","server":"65535","farm":66,"title":"Auckland City of Color","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52087365852","owner":"195023831@N04","secret":"abf8e4b62a","server":"65535","farm":66,"title":"Auckland City of Color","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088396316","owner":"195023831@N04","secret":"6d4ed17b5c","server":"65535","farm":66,"title":"Auckland City of Color","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088420003","owner":"195023831@N04","secret":"50f1b5565b","server":"65535","farm":66,"title":"Auckland City of Color","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088893075","owner":"195023831@N04","secret":"1733ff9812","server":"65535","farm":66,"title":"Auckland City of Color","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088417358","owner":"28232367@N02","secret":"f562728e2e","server":"65535","farm":66,"title":"Digitalis or foxglove","ispublic":1,"isfriend":0,"isfamily":0],
                ["id":"52088639439","owner":"190622906@N05","secret":"0c96eb154c","server":"65535","farm":66,"title":"Mercedes-Benz AMG Lanyard Black AMG Logo White","ispublic":1,"isfriend":0,"isfamily":0]
            ]
            
            return HTTPStubsResponse(jsonObject: jsonModel, statusCode: 200, headers: nil)
        }
        var expectedJson: Observable<[Photo]>? = nil
        
        let exception = self.expectation(description: "Network Call Failed.")
        
        // when
        let flikrImages = self.apiService.fetchImages(page: 1)
        
        expectedJson = flikrImages
        exception.fulfill()
        
        
        //then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(expectedJson)

    }
    
}
