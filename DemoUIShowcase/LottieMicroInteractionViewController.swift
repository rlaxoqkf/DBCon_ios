import UIKit
import Lottie

class LottieMicroInteractionViewController: UIViewController {

    var rocketImageView: UIImageView!
    var lottieEffectView: LottieAnimationView!
    var fireButton: UIButton!
    var closeButton: UIButton!

    let rocketSize: CGFloat = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // 1. 닫기 버튼
        closeButton = UIButton(type: .system)
        closeButton.setTitle("닫기", for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        // 2. 로켓 이미지 (항상 중앙에 보임)
        rocketImageView = UIImageView(image: UIImage(named: "rocket")) // rocket.png를 Assets에 추가!
        rocketImageView.contentMode = .scaleAspectFit
        rocketImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rocketImageView)
        NSLayoutConstraint.activate([
            rocketImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rocketImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rocketImageView.widthAnchor.constraint(equalToConstant: rocketSize),
            rocketImageView.heightAnchor.constraint(equalToConstant: rocketSize)
        ])

        // 3. Lottie 이펙트 (불꽃, 연기 등) - 반드시 진한 색상의 Lottie 파일 사용!
        lottieEffectView = LottieAnimationView(name: "rocket-flame-color") // 예: 진한 색상 Lottie
        lottieEffectView.contentMode = .scaleAspectFit
        lottieEffectView.loopMode = .playOnce
        lottieEffectView.translatesAutoresizingMaskIntoConstraints = false
        lottieEffectView.isHidden = true
        view.addSubview(lottieEffectView)
        NSLayoutConstraint.activate([
            lottieEffectView.centerXAnchor.constraint(equalTo: rocketImageView.centerXAnchor),
            lottieEffectView.centerYAnchor.constraint(equalTo: rocketImageView.centerYAnchor),
            lottieEffectView.widthAnchor.constraint(equalTo: rocketImageView.widthAnchor),
            lottieEffectView.heightAnchor.constraint(equalTo: rocketImageView.heightAnchor)
        ])

        // 4. 발사 버튼 (Filled Button)
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.title = "로켓 발사"
            config.baseBackgroundColor = .systemBlue
            config.baseForegroundColor = .white
            config.cornerStyle = .large
            fireButton = UIButton(configuration: config)
        } else {
            fireButton = UIButton(type: .system)
            fireButton.setTitle("로켓 발사", for: .normal)
            fireButton.backgroundColor = .systemBlue
            fireButton.setTitleColor(.white, for: .normal)
            fireButton.layer.cornerRadius = 12
        }
        fireButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        fireButton.addTarget(self, action: #selector(fireRocket), for: .touchUpInside)
        fireButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fireButton)
        NSLayoutConstraint.activate([
            fireButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fireButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            fireButton.heightAnchor.constraint(equalToConstant: 60),
            fireButton.widthAnchor.constraint(equalToConstant: 180)
        ])
    }

    @objc func fireRocket() {
        // 효과 보여주기
        lottieEffectView.isHidden = false
        lottieEffectView.currentProgress = 0
        lottieEffectView.play(fromProgress: 0, toProgress: 1, loopMode: .playOnce) { [weak self] _ in
            self?.lottieEffectView.isHidden = true
        }

        // 로켓 이미지와 이펙트를 위로 발사
        UIView.animate(withDuration: 1.2, animations: {
            self.rocketImageView.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
            self.lottieEffectView.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
        }, completion: { _ in
            self.rocketImageView.transform = .identity
            self.lottieEffectView.transform = .identity
        })
    }

    @objc func closeTapped() {
        self.dismiss(animated: true)
    }
}
