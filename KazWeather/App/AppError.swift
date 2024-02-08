//
//  AppError.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

protocol AppError: Error {
  var logDescription: String { get }
  var alertDescription: String { get }
}

