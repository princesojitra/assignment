//
//  ProofOfConceptFeedPresenterTest.swift
//  WiproCodingExcerciseTests
//
//  Created by Prince Sojitra on 08/10/20.
//

import XCTest
@testable  import WiproCodingExcercise
class ProofOfConceptFeedPresenterTest: XCTestCase {
    
    // MARK: - Subject under test
    var sut: ProofOfConceptFeedPresenter!
    static var testFeeds: ProofConceptFeedModel!
    
    // MARK: - Test lifecycle
    override  func setUp() {
        super.setUp()
        
        sut = ProofOfConceptFeedPresenter()
        ProofOfConceptFeedInteractorTest.testFeeds = self.getTestFeedsData(jsonString: Seeds.Feeds.canada)
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
    
    class FeedsListViewLogicSpy: ProofOfConceptFeedViewProtocol
    {
        var presenter: ProofOfConceptFeedPresenter?
        var interactor: ProofOfConceptFeedInteractor?
        var router: ProofOfConceptFeedRouter?
        
        // MARK: Method call expectations
        var dispalyFetchedFeedsCalled = false
        var dispalyFetchedFeedsNavTitleCalled = false
        
        // MARK: Argument expectations
        
        var viewFeedsItemsModel: ProofOfConceptItemsViewModel!
        var viewNavTitleModel: NavBarTitileViewModel!
        
        // MARK: Spied methods
        func presenter(navBarTitleViewModel: NavBarTitileViewModel) {
            dispalyFetchedFeedsNavTitleCalled = true
            self.viewNavTitleModel = navBarTitleViewModel
        }
        
        func presenter(profOfConceptItmesViewModel: ProofOfConceptItemsViewModel) {
            dispalyFetchedFeedsCalled = true
            self.viewFeedsItemsModel = profOfConceptItmesViewModel
        }
    }
    
    
    // MARK: - Tests
    func testPresentFetchedFeedsShouldAskViewControllerToDisplayFetchedFeeds()
    {
        // Given
        let listFeedsDisplayLogicSpy = FeedsListViewLogicSpy()
        sut.viewController = listFeedsDisplayLogicSpy
        
        // When
        sut.interactor(didRetriveProofOfConcpet: ProofOfConceptFeedInteractorTest.testFeeds!)
        
        // Then
        XCTAssert(listFeedsDisplayLogicSpy.dispalyFetchedFeedsCalled, "Presenting the updated feeds should ask view controller to display it")
        
        XCTAssertNotNil(listFeedsDisplayLogicSpy.dispalyFetchedFeedsNavTitleCalled, "Presenting the updated nav bar title should ask view controller to display it")    }
}

