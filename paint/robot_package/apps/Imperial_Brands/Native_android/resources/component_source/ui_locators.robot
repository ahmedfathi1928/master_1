*** Settings ***

*** Variables ***

${CONNECT_BUTTON}                               com.thirdwayv.vitaprotect:id/ib_connect_first_device
${UNPAIR_BUTTON}                                com.thirdwayv.vitaprotect:id/ib_remove_device
${UNPAIR_CONFIRMATION_BUTTON}                   com.thirdwayv.vitaprotect:id/btn_action_positive
${CONFIRM_BUTTON}                               Confirm
${LOCK_BUTTON}                                  com.thirdwayv.vitaprotect:id/ib_locked_unlocked
${UNLOCKED_STATUS}                              com.thirdwayv.vitaprotect:id/btn_cancel_removal
${LOCK_STATE}                                   com.thirdwayv.vitaprotect:id/tv_locked_unlocked
${UNLOCK_STATE}                                 com.thirdwayv.vitaprotect:id/tv_locked_unlocked
${NUDGE_STATE}                                  com.thirdwayv.vitaprotect:id/tv_nudge_on_off
${BLE_STATE}                                    com.thirdwayv.vitaprotect:id/iv_connection_state
${NUDGE_LABEL}                                  Nudge
${BLE_ON_STATE}                                 [181,578][215,638]
${BLE_ON_STATE2}                                [181,1042][215,1102]
${BLE_OFF_STATE}                                [171,578][214,638]
${BLE_OFF_STATE2}                               [171,1042][214,1102]
${PROFILE_BUTTON}                               (//android.widget.ImageView[@resource-id="com.thirdwayv.vitaprotect:id/navigation_bar_item_icon_view"])[4]
${LOGOUT_BUTTON}                                com.thirdwayv.vitaprotect:id/btn_logout
${LOGOUT_CONFIRMATION_BUTTON}                   com.thirdwayv.vitaprotect:id/btn_action_positive
${LEGAL_AGE_BUTTON}                             com.thirdwayv.vitaprotect:id/btn_21_agree
${SIGN_IN_EMAIL_FIELD}                          com.thirdwayv.vitaprotect:id/et_email
${SIGN_IN_PASSWORD_FIELD}                       com.thirdwayv.vitaprotect:id/et_password
${LOGIN_IN_LABEL}                               com.thirdwayv.vitaprotect:id/btn_sign_in
${AGE_VERIFICATION}                             com.thirdwayv.vitaprotect:id/headerTv
${AGE_VERIFICATION_LABEL}                       Age Verification
${INV_USERNAME}                                 com.thirdwayv.vitaprotect:id/tv_auth_error
${INV_USERNAME_LABEL}                           Email doesn’t exist, please check the entered email and try again
${INV_PASS}                                     com.thirdwayv.vitaprotect:id/tv_auth_error
${INV_PASS_LABEL}                               Incorrect email address or password
${PROFILE_USERNAME}                             com.thirdwayv.vitaprotect:id/tv_username
${CONTINUE_BUTTON}                              com.thirdwayv.vitaprotect:id/continue_view
${ENABLE_CAMERA_BUTTON}                         com.thirdwayv.vitaprotect:id/zoomDialogActionButton
${DONOT_ALLOW_CAMERA_BUTTON}                    com.android.permissioncontroller:id/permission_deny_button
${ERROR_REJECTION_CAMERA_PERMISSION}            com.thirdwayv.vitaprotect:id/tv_dialog_message
${ERROR_REJECTION_CAMERA_PERMISSION_TEXT}       We were unable to verify your identity
${INSTABUG_INIT_SCREEN_ID}                      com.thirdwayv.vitaprotect:id/ib_bg_tv_title
${INSTABUG_SECOND_SCREEN_ID}                    com.thirdwayv.vitaprotect:id/ib_bg_tv_title
${INSTABUG_DONE_BTN_ID}                         com.thirdwayv.vitaprotect:id/ib_bg_onboarding_done
${SIGN_UP_CONFIRM_PASSWORD_FIELD}               com.thirdwayv.vitaprotect:id/et_confirm_password
${SIGN_UP_CONTINUE_BUTTON}                      com.thirdwayv.vitaprotect:id/btn_continue
${I_UNDERSTAND_BUTTON}                          com.thirdwayv.vitaprotect:id/btn_continue
${SELFIE_PAGE}                                  com.thirdwayv.vitaprotect:id/readyScreenHeaderInnerContainer
${SIGN_UP_BUTTON}                               com.thirdwayv.vitaprotect:id/btn_sign_up
${ENABLE_BUTTON}                                com.thirdwayv.vitaprotect:id/btn_ok
${LOCATION_STATUS}                              com.android.settings:id/switch_text


${LOCK_LABEL}                                   Locked
${UNLOCK_LABEL}                                 Unlocked
${TURN_ON_BLE}                                  com.thirdwayv.vitaprotect:id/btn_turn_on_bluetooth
${SCAN_CONNECT_ERROR}                           com.thirdwayv.vitaprotect:id/tv_scan_or_connect_error_title
${NETWORK_NAME}                                 Test

${DEVICE_PICKER_LIST}                           //XCUIElementTypePicker
${CONNECT_MY_DEVICE}                            com.thirdwayv.vitaprotect:id/btn_connect_my_device
${PAIR_BUTTON}                                  android:id/button1
${HOME_PAGE}                                    com.thirdwayv.vitaprotect:id/btn_return_homepage
${GO_TO_HOME_PAGE}                              com.thirdwayv.vitaprotect:id/btn_complete
${NUDGE_BUTTON}                                 com.thirdwayv.vitaprotect:id/ib_nudge_on_off
${ERROR_LABEL}                                  Error
${Battery_ICON}                                 com.thirdwayv.vitaprotect:id/iv_battery_percent

