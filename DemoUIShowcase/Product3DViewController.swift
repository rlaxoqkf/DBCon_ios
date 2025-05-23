import UIKit

class Product3DViewController: UIViewController {

    let heartButton = UIButton(type: .system)
    var isFilled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // SF Symbols 하트 아이콘 준비
        let emptyHeart = UIImage(systemName: "heart")
        let filledHeart = UIImage(systemName: "heart.fill")

        // 버튼 설정
        heartButton.setImage(emptyHeart, for: .normal)
        heartButton.tintColor = .gray
        heartButton.imageView?.contentMode = .scaleAspectFit
        heartButton.contentHorizontalAlignment = .fill
        heartButton.contentVerticalAlignment = .fill

        // SF Symbols 크기 조정 (중요!)
        let config = UIImage.SymbolConfiguration(pointSize: 130, weight: .regular)
        heartButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)

        heartButton.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heartButton)

        // 오토레이아웃: 화면 중앙, 크기 150x150
        NSLayoutConstraint.activate([
            heartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heartButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            heartButton.widthAnchor.constraint(equalToConstant: 150),
            heartButton.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    @objc func heartTapped() {
        isFilled.toggle()

        let emptyHeart = UIImage(systemName: "heart")
        let filledHeart = UIImage(systemName: "heart.fill")

        // SF Symbols 크기 조정 (반드시 토글 시에도 적용)
        let config = UIImage.SymbolConfiguration(pointSize: 130, weight: .regular)
        if isFilled {
            heartButton.setImage(filledHeart, for: .normal)
            heartButton.tintColor = .systemRed
        } else {
            heartButton.setImage(emptyHeart, for: .normal)
            heartButton.tintColor = .gray
        }
        heartButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)

        UIView.animate(withDuration: 0.12, animations: {
            self.heartButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { _ in
            UIView.animate(withDuration: 0.12) {
                self.heartButton.transform = .identity
            }
        })
    }
}
