//
//  CharacterDetailViewModel.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 06/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

class CharacterDetailViewModel {
    
    private let logic: CharacterDetailLogic
    private let character: Character
    private var sectionKeys = [NSNumber]()
    private var sections = [NSNumber: CharacterDetailSection]() {
        didSet { sectionKeys = Array(sections.keys.sorted(by: { $0.compare($1) == .orderedAscending })) }
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    init(logic: CharacterDetailLogic, character: Character) {
        self.logic = logic
        self.character = character
    }
    
    func loadCharacterData() {
        sections[NSNumber(value: 0)] = .main(viewModels: [CharacterDetailHeaderTableViewCellDTO(character: character, favorited: logic.isFavorite(character: character))], preview: true)
        sections[NSNumber(value: 1)] = .comics(viewModels: character.comics?.items?.map({ CharacterContentTableViewCellDTO(comic: $0) }) ?? [], preview: true)
        sections[NSNumber(value: 2)] = .series(viewModels: character.series?.items?.map({ CharacterContentTableViewCellDTO(serie: $0) }) ?? [], preview: true)
        sections[NSNumber(value: 3)] = .stories(viewModels: character.stories?.items?.map({ CharacterContentTableViewCellDTO(story: $0) }) ?? [], preview: true)
        sections[NSNumber(value: 4)] = .events(viewModels: character.events?.items?.map({ CharacterContentTableViewCellDTO(event: $0) }) ?? [], preview: true)
    }
    
    func numberOfRows(at section: Int) -> Int {
        
        let detailSection = characterDetailSection(at: IndexPath(row: 0, section: section))
        let rows = detailSection.numberOfRows
        let numberOfPreviewItems = detailSection.numberOfPreviewItems
        
        switch rows {
        case _ where rows < 2:
            return 1
        case _ where rows <= detailSection.numberOfPreviewItems:
            return rows
        case _ where ((rows > numberOfPreviewItems) && detailSection.preview):
            return numberOfPreviewItems + 1
        default:
            return rows + 1
        }
    }
    
    func canShowContent(for section: CharacterDetailSection, at indexPath: IndexPath) -> Bool {
        
        guard (section.numberOfRows > indexPath.row) else {
            return false
        }
        
        if section.preview {
            return (section.numberOfPreviewItems != indexPath.row)
        } else {
            return (section.numberOfRows != indexPath.row)
        }
    }
    
    func characterDetailSectionKey(at section: Int) -> NSNumber {
        return sectionKeys[section]
    }
    
    func characterDetailSection(at indexPath: IndexPath) -> CharacterDetailSection {
        return sections[characterDetailSectionKey(at: indexPath.section)]!
    }
    
    func titleForHeader(at section: Int) -> String? {
        return characterDetailSection(at: IndexPath(row: 0, section: section)).headerTitle
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> Any? {
        
        let section = characterDetailSection(at: indexPath)
        
        guard canShowContent(for: section, at: indexPath) else {
            if (indexPath.row == 0) {
                return MessageTableViewCellDTO(title: section.noContentMessageTitle)
            } else {
                return ActionTableViewCellDTO(actionTitle: section.callToActionTitle)
            }
        }
        
        return section.viewModel(at: indexPath.row)
    }
    
    func updatePreviewForContent(at indexPath: IndexPath) -> [IndexPath] {
        
        let key = characterDetailSectionKey(at: indexPath.section)
        var section = characterDetailSection(at: indexPath)
        
        switch section {
        case let .main(viewModels, preview):
            section = .main(viewModels: viewModels, preview: !preview)
        case let .comics(viewModels, preview):
            section = .comics(viewModels: viewModels, preview: !preview)
        case let .events(viewModels, preview):
            section = .events(viewModels: viewModels, preview: !preview)
        case let .stories(viewModels, preview):
            section = .stories(viewModels: viewModels, preview: !preview)
        case let .series(viewModels, preview):
            section = .series(viewModels: viewModels, preview: !preview)
        }
        
        sections.updateValue(section, forKey: key)
        
        guard section.viewModels.count > section.numberOfPreviewItems else {
            return []
        }
        
        let numberOfIndexes = Array(section.numberOfPreviewItems..<section.viewModels.count)
        return numberOfIndexes.map({ IndexPath(row: $0, section: indexPath.section) })
    }
    
    func showOptions(completion: (() -> Void)? = nil) {
        
        logic.showOptionsFor(character: character) { (result) in
            
            guard case let .success(option) = result else {
                return
            }
            
            switch option {
            case .favorite:
                self.logic.favorite(self.character, completion: { _ in
                    completion?()
                })
                
            case .unfavorite:
                self.logic.unfavorite(self.character, completion: { _ in
                    completion?()
                })
                break
            }
        }
    }
}

private extension CharacterDetailHeaderTableViewCellDTO {
    init(character: Character, favorited: Bool) {
        self.init(
            title: character.name,
            description: character.description,
            imageURL: character.thumbnail?.url,
            favorited: favorited
        )
    }
}

private extension CharacterContentTableViewCellDTO {
    
    init(comic: ComicSummary) {
        self.init(title: comic.name, imageURL: nil)
    }
    
    init(story: StorySummary) {
        self.init(title: story.name, imageURL: nil)
    }
    
    init(event: EventSummary) {
        self.init(title: event.name, imageURL: nil)
    }
    
    init(serie: SeriesSummary) {
        self.init(title: serie.name, imageURL: nil)
    }

}
