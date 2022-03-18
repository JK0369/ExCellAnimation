//
//  ViewController.swift
//  ExCell
//
//  Created by Jake.K on 2022/03/17.
//

import UIKit

class ViewController: UIViewController {
  private let tableView: UITableView = {
    let view = UITableView()
    view.allowsSelection = true
    view.backgroundColor = .clear
    view.separatorStyle = .none
    view.bounces = true
    view.showsVerticalScrollIndicator = true
    view.clipsToBounds = false
    view.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.id)
    view.estimatedRowHeight = 34
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private lazy var nextButton: UIButton = {
    let button = UIButton()
    button.setTitle("Next", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(button)
    return button
  }()
  
  private let dataSource = (0...55).map(String.init(_:))

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(self.tableView)
    self.view.addSubview(self.nextButton)
    NSLayoutConstraint.activate([
      self.nextButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
      self.nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      
      self.tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
      self.tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
    ])
    self.tableView.dataSource = self
  }
  
  @objc func didTapNextButton() {
    let vc2 = VC2()
    vc2.modalPresentationStyle = .fullScreen
    self.present(vc2, animated: true)
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.dataSource.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.id) as! MyTableViewCell
    cell.prepare(titleText: self.dataSource[indexPath.row])
    return cell
  }
}

final class MyTableViewCell: UITableViewCell {
  static let id = "MyTableViewCell"

  // MARK: UI
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "테스트"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  private let myImageView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "image1")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // MARK: Initializer
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.selectionStyle = .none
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.myImageView)
    NSLayoutConstraint.activate([
      self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      
      self.myImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
      self.myImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
      self.myImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      self.myImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
    ])
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    guard highlighted else { return }
//      UIView.animate(
//        withDuration: 0.1,
//        animations: { self.backgroundColor = .systemBlue },
//        completion: { _ in
//          UIView.animate(withDuration: 0.1) { self.backgroundColor = .white }
//        }
//      )
    
    UIView.transition(
      with: self.myImageView,
      duration: 0.2,
      options: .transitionCrossDissolve,
      animations: { self.myImageView.image = UIImage(named: "image2") },
      completion: { _ in self.myImageView.image = UIImage(named: "image1") }
    )
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.prepare(titleText: nil)
  }
  
  func prepare(titleText: String?) {
    self.titleLabel.text = titleText
  }
}

