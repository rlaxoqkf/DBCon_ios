import UIKit
import SceneKit

class Product3DViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //        let sceneView = SCNView(frame: self.view.bounds)
        //        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //        sceneView.backgroundColor = .white
        //
        //        // 3D 모델 파일을 프로젝트에 추가하고 이름을 맞춰주세요!
        //        if let scene = SCNScene(named: "product.scn") {
        //            sceneView.scene = scene
        //        } else {
        //            // 예시: 간단한 구체로 대체
        //            let scene = SCNScene()
        //            let sphere = SCNSphere(radius: 1.0)
        //            let node = SCNNode(geometry: sphere)
        //            scene.rootNode.addChildNode(node)
        //            sceneView.scene = scene
        //        }
        //
        //        sceneView.allowsCameraControl = true // 사용자가 회전/확대/축소 가능
        //        self.view.addSubview(sceneView)
        //
        //        // 닫기 버튼
        //        let closeButton = UIButton(type: .system)
        //        closeButton.setTitle("닫기", for: .normal)
        //        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        //        closeButton.frame = CGRect(x: 20, y: 40, width: 60, height: 40)
        //        self.view.addSubview(closeButton)
        //    }
        //
        //    @objc func closeTapped() {
        //        self.dismiss(animated: true)
        //    }
    }
}
