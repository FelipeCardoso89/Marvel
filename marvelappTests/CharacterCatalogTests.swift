//
//  CharacterCatalogTests.swift
//  marvelappTests
//
//  Created by Felipe Antonio Cardoso on 07/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Quick
import Nimble
@testable import marvelapp

class CharacterCatalogTests: QuickSpec {
    
    override func spec() {
        
        var service: CharacterCatalogServable?
        var logic: CharacterCatalogLogic?
        var viewModel:  CharacterCatalogViewModel?
        
        
        describe("character catalog components") {
            
            context("without load data", {
                
                beforeEach {
                    service = MVLHeroesMockService.shared
                    logic = CharacterCatalogLogic(service: service!, router: self)
                    viewModel = CharacterCatalogViewModel(logic: logic!)
                }
                
                it("has correct static data", closure: {
                    expect(viewModel!.title).to(equal("Characters"))
                })
                
                it("has correct initial data", closure: {
                    expect(viewModel!.numberOfCharacters).to(equal(0))
                    expect(viewModel!.isFirstLoad).to(equal(true))
                })
                
            })
            
            context("with data loaded", {
              
                beforeEach {
                    service = MVLHeroesMockService.shared
                    logic = CharacterCatalogLogic(service: service!, router: self)
                    viewModel = CharacterCatalogViewModel(logic: logic!)
                    viewModel!.loadCharacters()
                }
                
                it("has correct state after first load", closure: {
                    expect(viewModel!.numberOfCharacters).to(equal(20))
                    expect(viewModel!.isFirstLoad).to(equal(false))
                })
                
                it("can load more content", closure: {
                    viewModel!.loadNextPage()
                    expect(viewModel!.numberOfCharacters).to(equal(40))
                    expect(viewModel!.isFirstLoad).to(equal(false))
                })
                
                it("can reset catalog data", closure: {
                    viewModel?.reset()
                    expect(viewModel!.numberOfCharacters).to(equal(0))
                    expect(viewModel!.isFirstLoad).to(equal(true))
                })
            })
            
            context("can create DTOs", {
                
                beforeEach {
                    service = MVLHeroesMockService.shared
                    logic = CharacterCatalogLogic(service: service!, router: self)
                    viewModel = CharacterCatalogViewModel(logic: logic!)
                    viewModel!.loadCharacters()
                }
                
                it("can load DTO for catalog item", closure: {
                    
                    let dto = viewModel?.viewModel(at: IndexPath(item: 0, section: 0)) as? CatalogItemCollectionViewCellDTO
                    expect(dto).notTo(beNil())
                    expect(dto!.title!).to(equal("3-D Man"))
                    expect(dto!.imageURL!.absoluteString).to(equal("http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
                })
            })
        }
    }
}

extension CharacterCatalogTests: CharacterCatalogRouterable {
    
    func detail(for character: Character) {}
    func showOptions(_ options: [CharacterOption], for character: Character, onSelectedOption: @escaping ((CharacterOption) -> Void)) {}
    func showAlert(with title: String, message: String, retry: (() -> Void)?, onDismiss: (() -> Void)?) {}
}


extension MVLHeroesMockService: CharacterCatalogServable {
    
    func character(_ name: String?, page: Int, completion: @escaping CharacterDataWrapperCompletionResult) {

        guard let path = Bundle(for: type(of: self)).path(forResource: "CharacterDataWrapper", ofType: "json") else {
            completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "bla"])))
            return
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "bla"])))
            return
        }

        guard let response: CharacterDataWrapper = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data) else {
            completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "bla"])))
            return
        }

        completion(.success(response))
    }

    func isFavorited(_ character: Character) -> Bool {
        return false
    }

    func favorite(_ character: Character) -> Bool {
        return true
    }

    func unfavorite(_ character: Character) -> Bool {
        return true
    }
}
