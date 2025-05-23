import UIKit

class InfiniteScrollViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadMoreButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var loadMoreActivityIndicator: UIActivityIndicatorView!

    var data: [String] = []
    var currentPage = 1
    let pageSize = 20
    let maxPage = 5
    var isLoading = false
    var hasMoreData = true

    enum Mode: Int {
        case pagination = 0
        case infiniteScroll = 1
        case loadMore = 2
    }

    var currentMode: Mode {
        return Mode(rawValue: segmentedControl.selectedSegmentIndex) ?? .pagination
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        segmentedControl.selectedSegmentIndex = 0

        pageControl.numberOfPages = maxPage
        pageControl.currentPage = 0
        pageControl.isHidden = (currentMode != .pagination)

        loadMoreButton.isHidden = (currentMode != .loadMore)
        loadMoreActivityIndicator.isHidden = true

        loadData(reset: true)
    }

    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        pageControl.isHidden = (currentMode != .pagination)
        loadMoreButton.isHidden = (currentMode != .loadMore)
        loadMoreActivityIndicator.isHidden = true
        if currentMode == .pagination {
            pageControl.currentPage = 0
        }
        loadData(reset: true)
    }

    @IBAction func pageChanged(_ sender: UIPageControl) {
        currentPage = sender.currentPage + 1
        loadData(reset: true)
    }

    @IBAction func loadMoreTapped(_ sender: UIButton) {
        loadMoreActivityIndicator.isHidden = false
        loadMoreActivityIndicator.startAnimating()
        loadData(reset: false)
    }

    func loadData(reset: Bool) {
        if isLoading { return }

        let mode = self.currentMode
        let selectedPage = self.pageControl.currentPage

        // **모든 모드에서 로딩 상태 true 후 reloadData 호출하여 로딩 셀 표시**
        isLoading = true
        tableView.reloadData()

        if reset {
            if mode == .pagination {
                currentPage = selectedPage + 1
            } else {
                currentPage = 1
            }
            data.removeAll()
            hasMoreData = true
            tableView.reloadData()
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            var newItems: [String] = []
            if mode == .pagination {
                let start = (self.currentPage - 1) * self.pageSize + 1
                let end = min(start + self.pageSize - 1, self.maxPage * self.pageSize)
                newItems = (start...end).map { "Item \($0)" }
            } else {
                let start = (self.currentPage - 1) * self.pageSize + 1
                let end = min(start + self.pageSize - 1, self.maxPage * self.pageSize)
                newItems = (start...end).map { "Item \($0)" }
            }

            DispatchQueue.main.async {
                if mode == .pagination {
                    self.data = newItems
                    self.hasMoreData = false
                } else {
                    if !newItems.isEmpty {
                        self.data.append(contentsOf: newItems)
                        self.currentPage += 1
                        self.hasMoreData = self.currentPage <= self.maxPage
                    } else {
                        self.hasMoreData = false
                    }
                }
                self.isLoading = false

                if mode == .pagination {
                    self.pageControl.currentPage = self.currentPage - 1
                }

                self.tableView.reloadData()

                if mode == .loadMore {
                    self.loadMoreActivityIndicator.stopAnimating()
                    self.loadMoreActivityIndicator.isHidden = true
                    self.loadMoreButton.isHidden = !self.hasMoreData
                }
            }
        }
    }
}

extension InfiniteScrollViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // **Pagination 포함 모든 모드에서 로딩 셀 표시하도록 수정**
        return data.count + (shouldShowLoadingCell ? 1 : 0)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if shouldShowLoadingCell && indexPath.row == data.count {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            let indicator = UIActivityIndicatorView(style: .medium)
            indicator.center = CGPoint(x: tableView.bounds.midX, y: 22)
            indicator.startAnimating()
            cell.contentView.addSubview(indicator)
            cell.textLabel?.text = nil
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isLoading, hasMoreData else { return }
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        switch currentMode {
        case .pagination:
            // Pagination: 스크롤로 데이터 불러오기 금지
            break
        case .infiniteScroll:
            if offsetY > contentHeight - frameHeight - 100 {
                loadData(reset: false)
            }
        case .loadMore:
            break
        }
    }

    var shouldShowLoadingCell: Bool {
        // **Pagination 포함 모든 모드에서 로딩 셀 표시**
        return isLoading && hasMoreData
    }
}
