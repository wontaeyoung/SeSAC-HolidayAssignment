//
//  Model.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

protocol DTO: Decodable {
  associatedtype EntityType: Entity
  
  func toEntity() -> EntityType
}

protocol Entity { }
