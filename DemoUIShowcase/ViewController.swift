//
//  ViewController.swift
//  DemoUIShowcase
//
//  Created by mobile on 5/20/25.
//

import UIKit
import TTGSnackbar
import FloatingPanel


class ViewController: UIViewController {
    var floatingPanelController: FloatingPanelController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func showBottomSheet(_ sender: Any) {
        let fpc = FloatingPanelController()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let contentVC = storyboard.instantiateViewController(withIdentifier: "BottomSheetVC")
                fpc.set(contentViewController: contentVC)
                fpc.isRemovalInteractionEnabled = true
                self.floatingPanelController = fpc
                fpc.addPanel(toParent: self)
    }
    
    @IBAction func showBottomSheetUIShhet(_ sender: Any) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let bottomSheetVC = storyboard.instantiateViewController(withIdentifier: "BottomSheetVC")
                        if let sheet = bottomSheetVC.presentationController as? UISheetPresentationController {
                            sheet.detents = [.medium(), .large()]
                            sheet.prefersGrabberVisible = true
                        }
                        self.present(bottomSheetVC, animated: true)
    }
    
    @IBAction func showSnackbar(_ sender: Any) {
        let snackbar = TTGSnackbar(message: "Snack Bar 테스트 입니다!", duration: .short)
                snackbar.show()
    }
    
    
    @IBAction func showPopup(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let popupVC = storyboard.instantiateViewController(withIdentifier: "PopupVC")
                popupVC.modalPresentationStyle = .overCurrentContext
                popupVC.modalTransitionStyle = .crossDissolve
                self.present(popupVC, animated: true)
    }
    
    @IBAction func showSkeleton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let skeletonVC = storyboard.instantiateViewController(withIdentifier: "SkeletonVC")
                self.present(skeletonVC, animated: true)
    }
}

