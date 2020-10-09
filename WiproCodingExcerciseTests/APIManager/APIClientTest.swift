//
//  APIClientTest.swift
//  WiproCodingExcerciseTests
//
//  Created by Prince Sojitra on 08/10/20.
//

import XCTest
@testable  import WiproCodingExcercise

class APIClientTest: XCTestCase {
    
    // MARK: - Subject under test
    var apiClient:APIClient!
    
    // MARK: - Test lifecycle
    
    override  func setUp() {
        super.setUp()
        apiClient = APIClient()
    }
    
    override  func tearDown() {
        super.tearDown()
        apiClient = nil
    }
    
    // MARK: - Test doubles
    struct DummyModel : Codable {
        
        let firstName : String?
        let lastName : String?
        
        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
            lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        }
    }
    
    
    // MARK: - Tests
    func test_APIClientRequest_WhenFailedToCreateUrl_ShouldReturnError() {
        //Given
        let expectation = self.expectation(description: "An empty URL string expectation")
        
        //When
        let completionhandlor:ReesultComplitionBlock  = { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, APIError.failedToCreateURL)
                expectation.fulfill()
            case .success(_):
                break
            }
        }
        
        let apiEndpoint = APIEndpoint(path: "",completion: completionhandlor)
        apiClient.request(withEndpoint: apiEndpoint, decodingType: ProofConceptFeedModel.self)
        
        //Then
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testAPIClient_WhenInvalidHostProvided_ShouldReturnError() {
        //Given
        let expection = self.expectation(description: "Host invalid exception")
        
        
        let completionHandler:ReesultComplitionBlock = {(result) in
            XCTAssertEqual(self.apiClient.cachedUrl?.host ?? "", "ws.audioscrobbler.com","Host shoud match with dl.dropboxusercontent.com")
            expection.fulfill()
        }
        
        let endPoint = APIEndpoint(path: "http://ws.audioscrobbler.com", completion: completionHandler)
        
        //When
        apiClient.request(withEndpoint: endPoint, decodingType: ProofConceptFeedModel.self)
        
        //Then
        self.wait(for: [expection], timeout: 1)
    }
    
    func testAPIClient_WhenValidUrlWithValidDatmodelProvided_ShouldReturnFeedsModelData(){
        //Given
        let expectation = self.expectation(description:"Feeds data retrive from server side")
        
        let completionhandlor:ReesultComplitionBlock  = { (result) in
            switch result {
            case .failure(_):
                XCTFail("Failed to retrive feeds data from server side")
            case .success(let results):
                let prrofOfConceptResult = results as? ProofConceptFeedModel
                XCTAssertNotNil(prrofOfConceptResult,"Should have match with the feeds data model")
                expectation.fulfill()
                break
            }
        }
        
        let endPointPath = "\(APIManager.shared.baseURL)\(Endpoints.ProofOfConcepts)"
        let apiEndpoint = APIEndpoint(path: endPointPath, method: .get,completion: completionhandlor)
        apiClient.request(withEndpoint: apiEndpoint, decodingType: ProofConceptFeedModel.self)
        
        //Then
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testAPIClient_WhenDifferentDataModelProvided_ShouldReturnError(){
        //Given
        let expectation = self.expectation(description:"Feeds data retrive from server side")
        
        let completionhandlor:ReesultComplitionBlock  = { (result) in
            switch result {
            case .failure(_):
                break
            case .success(let results):
                let prrofOfConceptResult = results as? ProofConceptFeedModel
                XCTAssertNil(prrofOfConceptResult,"Should have match with the feeds data model")
                expectation.fulfill()
                break
            }
        }
        
        let endPointPath = "\(APIManager.shared.baseURL)\(Endpoints.ProofOfConcepts)"
        let apiEndpoint = APIEndpoint(path: endPointPath, method: .get,completion: completionhandlor)
        apiClient.request(withEndpoint: apiEndpoint, decodingType: DummyModel.self)
        
        //Then
        self.wait(for: [expectation], timeout: 1.1)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
