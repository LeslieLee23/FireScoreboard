//
//  AppDelegate+Resolving.swift
//  Score1031
//
//  Created by Danting Li on 4/22/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//
import Resolver

extension Resolver: ResolverRegistering {
  public static func registerAllServices() {
    register { TestDataScoreRepository () as ScoreRepository }.scope(application)
  }
}
