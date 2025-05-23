import UIKit
import Lottie

class LottieMicroInteractionViewController: UIViewController {
    @IBOutlet weak var heartLottieView: LottieAnimationView!
    @IBOutlet weak var heartTapButton: UIButton!

    var isHeartFilled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        heartLottieView.isUserInteractionEnabled = false
        // 반드시 Lottie 파일명과 동일하게!
        heartLottieView.animation = LottieAnimation.named("like-playable-heart") // 예: like-playable-heart.json
        heartLottieView.loopMode = .playOnce
        heartLottieView.currentProgress = 0 // 빈 하트 상태로 시작
    }



    @IBAction func heartTapped(_ sender: UIButton) {
        isHeartFilled.toggle()
        print("하트 버튼 눌림")
        if isHeartFilled {
            // 빈 하트 → 채워진 하트 (0 → 1)
            heartLottieView.play(fromProgress: 0, toProgress: 1, loopMode: .playOnce)
        } else {
            // 채워진 하트 → 빈 하트 (1 → 0)
            heartLottieView.play(fromProgress: 1, toProgress: 0, loopMode: .playOnce)
        }
    }
}
