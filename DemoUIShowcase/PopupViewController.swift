import UIKit

class PopupViewController: UIViewController {
    @IBOutlet weak var popupView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 배경을 반투명하게
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // 팝업뷰 모서리 둥글게
        popupView.layer.cornerRadius = 16
        // 팝업 애니메이션 (선택)
        popupView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.popupView.alpha = 1
        }
    }

    @IBAction func dismissPopup(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.popupView.alpha = 0
        }) { _ in
            self.dismiss(animated: false)
        }
    }
}
