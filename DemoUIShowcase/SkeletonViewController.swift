import UIKit
import SkeletonView

class SkeletonViewController: UIViewController {
    @IBOutlet weak var skeletonView1: UIView!
    @IBOutlet weak var skeletonView2: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // SkeletonView를 적용할 뷰에 skeletonable 활성화
        skeletonView1.isSkeletonable = true
        skeletonView2.isSkeletonable = true

        // 뼈대 UI 애니메이션 표시
        skeletonView1.showAnimatedGradientSkeleton()
        skeletonView2.showAnimatedGradientSkeleton()

        // 2초 후(네트워크 로딩 시뮬레이션) skeleton 숨기기
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.skeletonView1.hideSkeleton()
            self.skeletonView2.hideSkeleton()
        }
    }
}
