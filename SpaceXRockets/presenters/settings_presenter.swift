//
//  settings_presenter.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 09.06.2022.
//

import Foundation

protocol SettingsPresenterDelegate {
    func onCellsToogleTapped(parameter : ParameterUnits)
    func saveSettingsToCoreData()
}

class SettingsPresenter : SettingsPresenterDelegate{
    func onCellsToogleTapped(parameter : ParameterUnits) {
        print("Tapped")
        parameter.ChangeUnits()
        NotificationCenter.default.post(name: NSNotification.Name("updateCellLabels"), object: nil)
    }
    
    func saveSettingsToCoreData() {
        //
    }
}
