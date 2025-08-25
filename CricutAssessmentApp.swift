//
//  CricutAssessmentApp.swift
//  CricutAssessment
//
//  Created by Cody Munger on 8/24/25.
//

import SwiftUI

class AppGlobalContext {
    init() {
        setup()
    }

    var settings: Settings = Settings()
    var shapesModel: ShapesModel = ShapesModel()
    
    func setup() {
        Task {
            await self.shapesModel.remoteUpdate()
        }
    }
}

@main
struct CricutAssessmentApp: App {
    private static var _instance:CricutAssessmentApp?
    public static var instance:CricutAssessmentApp?
    {
        get { return _instance }
    }
    
    var context = AppGlobalContext()

    init()
    {
        CricutAssessmentApp._instance = self
    }

    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
