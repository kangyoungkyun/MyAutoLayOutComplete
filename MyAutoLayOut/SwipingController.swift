
import UIKit
//UICollectionViewController를 상속 받는 클래스, 레이아웃과 cell의 size를 조정하려면 UICollectionViewDelegateFlowLayout을
//상속받아야 한다.
class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
    let pages = [
        Page(imageName: "mypic1", headerText: "ios 프로그래밍 입문 레슨", bodyText: "초보자도, 할머니도, 할아버지도 원숭이도 하는 코딩공부~ 글보다는 직접 쳐보면서 만들어보는게 훨씬 이해도 쉽고 효율적이에요~ 같이 열공해용~!"),
        Page(imageName: "mypic2", headerText: "안드로이드 프로그래밍 입문 레슨", bodyText: "세계에서 가장 많이 사용하는 os 안드로이드~! 프로그래밍 입문자는 java에 대한 개념부터 다지고 바로 앱으로 고고씽~!"),
        Page(imageName: "mypic3", headerText: "php 프로그래밍 쉽게 알려줌", bodyText: "나는 웹도 앱도 먼지 모르겠다. 일단 운영이되는 사이트를 바로 만들어 보고싶다. 그런분들께 쉽지만 아주 강력한 php를 추천합니다~!")
    ]
    //이전 버튼
    private let preButton :UIButton = {
        let preBtn = UIButton(type:.system)
        preBtn.setTitle("이전", for: .normal)
        preBtn.translatesAutoresizingMaskIntoConstraints = false
        preBtn.setTitleColor(.gray, for: .normal)
        preBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        preBtn.addTarget(self, action: #selector(handlePre), for: .touchUpInside)
        return preBtn
        
    }()
    @objc func handlePre(){
        print("aa")
        //print(pageControl.currentPage+1)//1
        //print(pages.count-1)//2
        
        let nextIndex = max(pageControl.currentPage - 1, 0) //1
        let indexPath = IndexPath(item: nextIndex, section: 0) //[0,1]
        print(nextIndex) //1 , 0
        print(indexPath)// [0,1] [0,0]
        pageControl.currentPage = nextIndex //1
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        //print(nextIndex)
    }
    
    //다음 버튼
    private let nextButton :UIButton = {
        let nxtBtn = UIButton(type:.system)
        nxtBtn.setTitle("다음", for: .normal)
        nxtBtn.translatesAutoresizingMaskIntoConstraints = false
        nxtBtn.setTitleColor(.mainPink, for: .normal)
        nxtBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        nxtBtn.addTarget(self, action: #selector(handeNext), for: .touchUpInside) //터치가 이루어졌을때 handeNext 함수 호출
        return nxtBtn
    }()
    
    @objc func handeNext(){
        print("next")
        //print(pageControl.currentPage+1)//1
        //print(pages.count-1)//2
        //다음페이지 번호 구하기 - min 제일 작은값을 가져온다. 참고로 currentPage는 0 인 상태다
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1) //1
        let indexPath = IndexPath(item: nextIndex, section: 0) //[0,1]
        print(nextIndex)
        print(indexPath)
        pageControl.currentPage = nextIndex //1
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        //print(nextIndex)
    }
    
    //페이지 컨트롤러
     lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.currentPage = 0
        //let a = pages.count
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()

    //오른쪽으로 스크롤 했을 때 - 위치로 현재 페이지 구해주기
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 스택뷰 관련 함수 호출
        setupBottomControls()
        //배경색을 흰색
        collectionView?.backgroundColor = .white
        //collectionView에 cell을 등록해주는 작업, 여기서는 직접 만든 cell을 넣어주었고, 아이디를 설정해 주었다.
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        //페이징기능 허용
        collectionView?.isPagingEnabled = true
        

    }

    //스택뷰 객세 생성과 위치 설정 함수
    fileprivate func setupBottomControls() {
        
        //uistackview 객체 만들기 배열 타입으로 view 객체들이 들어간다
        let bottomControlsStackView = UIStackView(arrangedSubviews: [preButton, pageControl, nextButton])
        //오토레이아웃 설정 허용해주기
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        //객체들이 하나하나 보이게 설정
        bottomControlsStackView.distribution = .fillEqually
        //bottomControlsStackView.axis = .vertical
        
        //전체 뷰에 위에서 만든 stackView를 넣어준다.
        view.addSubview(bottomControlsStackView)
        
        //스택뷰 위치 지정해주기
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}

