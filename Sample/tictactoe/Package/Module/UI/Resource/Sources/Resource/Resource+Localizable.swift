//
//  Resource+Localizable.swift
//  
//
//  Created by JSilver on 2022/12/28.
//

import Foundation

public extension Resource {
    enum Localizable { }
}

public extension Resource.Localizable {
    // MARK: - Common
    static var errorTitle: String { "error_title".localized }
    static var okay: String { "okay".localized }
    static var cancel: String { "cancel".localized }
    
    // MARK: - App
    static var appName: String { "app_name".localized }
    
    // MARK: - Signed Out
    static var signedOutTitle: String { "signed_out_title".localized }
    static var signedOutDescription: String { "signed_out_description".localized }
    static var signedOutPlayerATextFieldPlaceholder: String { "signed_out_player_a_textfield_placeholder".localized }
    static var signedOutPlayerBTextFieldPlaceholder: String { "signed_out_player_b_textfield_placeholder".localized }
    static var signedOutQuickStartButtonTitle: String { "signed_out_quick_start_button_title".localized }
    static var signedOutSignInButtonTitle: String { "signed_out_sign_in_button_title".localized }
    
    // MARK: - Scoreboard
    static var scoreboardTitle: String { "scoreboard_title".localized }
    static var scoreboardDescriptionWhoIsLeader: String { "scoreboard_description_who_is_leader".localized }
    static var scoreboardDescriptionTie: String { "scoreboard_description_title".localized }
    static var scoreboardPlayGameButtonTitle: String { "scoreboard_play_game_button_title".localized }
    static var scoreboardSignOutButtonTitle: String { "scoreboard_sign_out_button_title".localized }
    
    // MARK: - On Game
    static var onGameTitle: String { "on_game_title".localized }
    static var onGameTurnTitle: String { "on_game_turn_title".localized }
    static var onGameExitButtonTitle: String { "on_game_exit_button_title".localized }
    static var onGameGameEndAlertTitle: String { "on_game_game_end_alert_title".localized }
    static var onGameGameEndAlertWinnerMessage: String { "on_game_game_end_alert_winner_message".localized }
    static var onGameGameEndAlertDrawMessage: String { "on_game_game_end_alert_draw_message".localized }
    
    // MARK: - Game
    static var gameGameErrorInvalidPositionMessage: String { "game_game_error_invalid_position_message".localized }
    
    static var gameGameServiceErrorEmptyPlayerNameMessage: String { "game_game_service_error_empty_player_name_message".localized }
    static var gameGameServiceErrorSamePlayerNameMessage: String { "game_game_service_error_same_player_name_message".localized }
}
