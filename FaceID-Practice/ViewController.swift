//
//  ViewController.swift
//  FaceID-Practice
//
//  Created by 大西玲音 on 2021/10/01.
//

import UIKit
import LocalAuthentication

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = LAContext()
        context.localizedFallbackTitle = ""
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            switch context.biometryType {
                case .touchID:
                    evaluatePolicy(context: context)
                case .faceID:
                    evaluatePolicy(context: context)
                default:
                    break
            }
        } else {
            // 生体認証を許可していない
            print("キャンセル")
            print("DEBUG_PRINT: ", error as Any)
        }
        
    }
    
    private func evaluatePolicy(context: LAContext) {
        let localizedReason = "ロックの解除に、認証を使用します。"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: localizedReason) { isSuccess, error in
            if let error = error {
                switch LAError(_nsError: error as NSError).code {
                    case .userCancel:
                        print("キャンセルボタンが押された")
                    default:
                        break
                }
            } else {
                if isSuccess {
                    // 認証成功
                    print("成功")
                } else {
                    // キャンセルされた時
                    print("DEBUG_PRINT: ", error as Any)
                }
            }
        }
    }
    
}

