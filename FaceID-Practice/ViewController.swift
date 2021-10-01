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
            // アラート
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    private func evaluatePolicy(context: LAContext) {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: "ロックの解除に、認証を使用します。") { isSuccess, error in
            if let error = error {
                switch LAError(_nsError: error as NSError).code {
                    case .userCancel:
                        print("キャンセルボタンが押された")
                    default:
                        break
                }
                return
            }
            if isSuccess {
                print("成功")
            } else {
                print("失敗")
            }
        }
    }
    
}

