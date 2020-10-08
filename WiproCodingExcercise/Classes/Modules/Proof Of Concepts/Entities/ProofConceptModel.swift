
//
//	ProofConceptModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ProofConceptModel : Codable {

	let rows : [ProofConceptRow]?
	let title : String?

	enum CodingKeys: String, CodingKey {
		case rows = "rows"
		case title = "title"
	}
    
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rows = try values.decodeIfPresent([ProofConceptRow].self, forKey: .rows)
		title = try values.decodeIfPresent(String.self, forKey: .title)
	}


}
