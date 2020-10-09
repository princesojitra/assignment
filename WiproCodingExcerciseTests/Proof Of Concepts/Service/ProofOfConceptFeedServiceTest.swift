//
//  ProofOfConceptServiceTest.swift
//  WiproCodingExcerciseTests
//
//  Created by Prince Sojitra on 08/10/20.
//

import XCTest
@testable  import WiproCodingExcercise

class ProofOfConceptFeedServiceTest: XCTestCase {

    // MARK: - Subject under test
    var sut: ProofOfConceptFeedService!
    static var testFeeds: ProofConceptFeedModel!
    
    // MARK: - Test lifecycle
    override  func setUp() {
        super.setUp()
        sut = ProofOfConceptFeedService()
        ProofOfConceptFeedServiceTest.testFeeds = self.getTestFeedsData(jsonString: Seeds.Feeds.canada)
    }
    
    func getTestFeedsData(jsonString:String)-> ProofConceptFeedModel {
        let jsonData = jsonString.data(using: .utf8)!
        let proofOfConceptFeeds = try! JSONDecoder().decode(ProofConceptFeedModel.self, from: jsonData)
        return proofOfConceptFeeds
    }
    
    override  func tearDown() {
        super.tearDown()
        sut  = nil
    }
    
    // MARK: - Test doubles
    
    class FeedsListServiceSpy: ProofOfConceptFeedServiceProtocol
    {
        // MARK: Method call expectations
        var fetchedFeedsCalled = false
        
        // MARK: Spied methods
        func getProofOfConeptsFeeds(withLoader show: Bool, completionHandler: @escaping ReesultComplitionBlock) {
            
            fetchedFeedsCalled = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                
                completionHandler(.success(testFeeds))
            }
        }
    }
   
    class FeedsWorkerSpy: ProofOfConceptFeedServiceProtocol
    {
        // MARK: Method call expectations
        var fetchFeedsCalled = false
        
        // MARK: Spied methods
        func getProofOfConeptsFeeds(withLoader show: Bool, completionHandler: @escaping ReesultComplitionBlock) {
            fetchFeedsCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testFetchFeedsShouldReturnListOfFeeds()
    {
      // Given
    
      // When
        var fetchedFeeds:ProofConceptFeedModel?
        
      let expect = expectation(description: "Wait for getProofOfConeptsFeeds() to return")
        
        sut.getProofOfConeptsFeeds(withLoader: true) { (result) in
            switch result {
            case .failure(_):
                XCTFail("Failed to retrive feeds data from server side")
            case .success(let results):
                let prrofOfConceptResult = results as? ProofConceptFeedModel
                XCTAssertNotNil(prrofOfConceptResult,"Should have match with the feeds data model")
                fetchedFeeds = prrofOfConceptResult
                expect.fulfill()
                break
            }
        }
        self.wait(for: [expect], timeout: 10)
        
      // Then
        XCTAssertEqual(fetchedFeeds?.rows?.count, ProofOfConceptFeedServiceTest.testFeeds.rows?.count, "getProofOfConeptsFeeds() should return a list of orders")
    }
}
