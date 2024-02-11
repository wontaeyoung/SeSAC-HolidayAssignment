//
//  Model.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

protocol DTO: DefaultValueProvidable {
  associatedtype EntityType: Entity
  
  func toEntity() -> EntityType
}

protocol Entity { }
