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
    private var sections = [CharacterDetailSection]()
    
    var numberOfSections: Int {
        return sections.count
    }
    
    init(logic: CharacterDetailLogic, character: Character) {
        self.logic = logic
        self.character = character
    }
    
    func loadCharacterData() {
        sections.append(.main(viewModels: [CharacterDetailHeaderTableViewCellDTO(character: character)]))
        sections.append(.comics(viewModels: character.comics?.items?.map({ CharacterContentTableViewCellDTO(comic: $0) }) ?? []))
        sections.append(.series(viewModels: character.series?.items?.map({ CharacterContentTableViewCellDTO(serie: $0) }) ?? []))
        sections.append(.stories(viewModels: character.stories?.items?.map({ CharacterContentTableViewCellDTO(story: $0) }) ?? []))
        sections.append(.events(viewModels: character.events?.items?.map({ CharacterContentTableViewCellDTO(event: $0) }) ?? []))
    }
    
    func numberOfRows(at section: Int) -> Int {
        
        let detailSection = characterDetailSection(at: IndexPath(row: 0, section: section))
        let rows = sections[section].numberOfRows
        let numberOfPreviewItems = detailSection.numberOfPreviewItems
        
        switch rows {
        case _ where rows < 2:
            return 1
        case _ where ((rows > numberOfPreviewItems) && detailSection.preview):
            return numberOfPreviewItems + 1
        default:
            return rows + 1
        }
    }
    
    func canShowContent(for section: CharacterDetailSection, at indexPath: IndexPath) -> Bool {
        return (section.numberOfRows > indexPath.row) && (indexPath.row != section.numberOfPreviewItems)
    }
    
    func characterDetailSection(at indexPath: IndexPath) -> CharacterDetailSection {
        return sections[indexPath.section]
    }
    
    func titleForHeader(at section: Int) -> String? {
        return sections[section].headerTitle
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
    
    
}

private extension CharacterDetailHeaderTableViewCellDTO {
    init(character: Character) {
        self.init(
            title: character.name,
            description: character.description,
            imageURL: character.thumbnail?.url
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
