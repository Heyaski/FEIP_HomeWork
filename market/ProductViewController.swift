import UIKit
import SnapKit

class ProductViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let sizes = ["XXS", "XS", "S", "M", "L", "XL"]
    private var selectedSize: String?
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LoafersImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var newLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.backgroundColor = UIColor(named: "LightBrown") ?? .brown
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.text = "NEW"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Кожаные лоферы"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var infoButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Лоферы из натуральной кожи. Фигурная союзка с фактурным швом по контуру. Зауженный мыс. Кожаная стелька и подкладка. Прорезиненная подошва. В комплект входит пыльник."
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: -4)
        view.layer.shadowRadius = 10
        return view
    }()
    
    private lazy var sizeScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var addToCartButton: PrimaryButton = {
        let button = PrimaryButton(title: "В корзину · 14 999 ₽", backgroundColor: UIColor(named: "LightBrown") ?? .brown)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind(sizes: sizes)
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(0.8)
        }
        
        view.addSubview(newLabel)
        newLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(44)
            make.height.equalTo(22)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        view.addSubview(infoButton)
        infoButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(108)
            make.width.height.equalTo(24)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(180)
        }
        
        containerView.addSubview(sizeScrollView)
        sizeScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(44)
            make.leading.trailing.equalToSuperview()
        }
        
        sizeScrollView.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.edges.equalTo(sizeScrollView.contentLayoutGuide)
            make.height.equalTo(sizeScrollView)
        }
        
        containerView.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(sizeScrollView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        containerView.addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind(sizes: [String], selectedSize: String? = nil) {
        contentStack.subviews.forEach { $0.removeFromSuperview() }
        
        let leftPadding = UIView()
        contentStack.addArrangedSubview(leftPadding)
        leftPadding.snp.makeConstraints { make in
            make.width.equalTo(16)
        }
        
        for size in sizes {
            let sizeView = SizeEntityView()
            sizeView.bind(size: size, isSelected: selectedSize == size)
            sizeView.delegate = self
            contentStack.addArrangedSubview(sizeView)
            
            sizeView.snp.makeConstraints { make in
                make.height.equalTo(44)
            }
        }
        
        let rightPadding = UIView()
        contentStack.addArrangedSubview(rightPadding)
        rightPadding.snp.makeConstraints { make in
            make.width.equalTo(16)
        }
    }
}

extension ProductViewController: SizeEntityViewDelegate {
    func didSelectSize(with size: String) {
        bind(sizes: sizes, selectedSize: size)
    }
}
