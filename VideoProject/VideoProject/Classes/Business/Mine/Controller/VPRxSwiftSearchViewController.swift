//
//  VPRxSwiftSearchViewController.swift
//  VideoProject
//
//  Created by liyaqing143 on 2022/5/27.
//  Copyright © 2022 icoin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class VPRxSwiftSearchViewController: UIViewController {
    let bag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero,style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    lazy var _textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.cyan
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var _personVM = PersonViewModel()
    private var _insertText = "张"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _addViews()
        _layoutViews()
        _setupRxSwift()
        _loadData(params: _insertText)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        } else {
            // Fallback on earlier versions
        }
    }
}


//UITableViewDelegate
extension VPRxSwiftSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// layout
extension VPRxSwiftSearchViewController {
    
    func _addViews() {
        view.addSubview(tableView)
        view.addSubview(_textField)
    }
    
    func _layoutViews() {
        _textField.frame = CGRect(x: 0, y: 20, width: view.bounds.size.width, height: 44)
        tableView.frame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height - 64)
    }
}

//MARK: - set RxSwift
extension VPRxSwiftSearchViewController {
    private func _setupRxSwift() {
        _personVM.personVMArray
            .bind(to: tableView.rx.items){ tableView, indexPathRow, data in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(row: indexPathRow, section: 0)) as! TableViewCell
                cell.personVM = data
                return cell
            }.disposed(by: bag)
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        _textField.rx.controlEvent(.editingDidEnd
        ).subscribe { _ in
            self._insertText = self._textField.text ?? ""
            self._personVM.loadData(params: self._insertText) { isSuccess in
                if !isSuccess {
                    print("error")
                }
            }
        }.disposed(by: bag)
        
        _textField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe { _ in
                print("textFieldreture")
            }.disposed(by: bag)
    }
}


// loaddata
extension VPRxSwiftSearchViewController {
    private func _loadData(params: String){
        _personVM.loadData(params: params) { isSuccess in
            if isSuccess {
                //                self.tableView.reloadData()
            }else {
                print("请求数据出错")
            }
        }
    }
}

class TableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var nameLabel:UILabel = {
        let lab = UILabel()
        lab.frame = contentView.bounds
        
        return lab
    }()
    
    var personVM: PersonViewModel? {
        didSet {
            guard let personVM = personVM else {
                nameLabel.text = "null"
                return
            }
            nameLabel.text = personVM.name
        }
    }
    
}


/// Model
class PersonModel: NSObject {
    var name: String?
    var sex: Int?
    var age: Int?
    
    init(dict:[String: Any]) {
        name = dict["name"] as? String
        sex = (dict["sex"] as? NSNumber)?.intValue
        age = (dict["age"] as? NSNumber)?.intValue
    }
}


/// ViewModel
class PersonViewModel {
    
    private var _personModel: PersonModel?
    
    init(personModel: PersonModel? = nil) {
        _personModel = personModel
    }
    
    lazy var _personVMArray = [PersonViewModel]()
    var personVMArray = PublishSubject<[PersonViewModel]>()
    
    
    var name:String{
        return _personModel?.name ?? ""
    }
    
    var sex: String {
        if _personModel?.sex == 1 {
            return "男"
        }else if(_personModel?.sex == 2){
            return "女"
        }else{
            return "未知"
        }
    }
    
    var age:Int {
        return _personModel?.age ?? 0
    }
    
}


extension PersonViewModel {
    func loadData(params:String, completionHandler: @escaping(_ isSuceess: Bool)->Void) {
        //        guard let path = Bundle.main.path(forResource: params, ofType: ".plist") else {
        //            completionHandler(false)
        //            return
        //        }
        //
        //        guard let array = NSArray(contentsOfFile: path) as? [[String: Any]] else {
        //            completionHandler(false)
        //            return
        //        }
        let temparray = [
            [
                "name":"张艺1",
            ],[
                "name":"张艺2",
            ],[
                "name":"张艺3",
            ],[
                "name":"张艺4",
            ],[
                "name":"李艺5",
            ], [
                "name":"李艺1",
            ],[
                "name":"李艺2",
            ],[
                "name":"李艺3",
            ],[
                "name":"李艺4",
            ],[
                "name":"李艺5",
            ]
            
        ]
        
        let  otherTemparray = temparray.filter({ item in
            let name = item["name"] ?? ""
            if name.contains(params) {
                return true
            }
            return false
        })
        VPLog(otherTemparray)
        _personVMArray.removeAll()
        for dict in otherTemparray {
            let personModel = PersonModel(dict: dict)
            let personVM = PersonViewModel(personModel: personModel)
            _personVMArray.append(personVM)
            
        }
        completionHandler(true)
        personVMArray.onNext(_personVMArray)
    }
}
//
public enum Event<Element> {
    case next(Element)
    case error(Swift.Error)
    case completed
}
struct TestStruct {
  let a = VPMineViewController()
  

}
protocol Container {
    associatedtype ok:Equatable
    mutating func append(_ item: ok)
    var count: Int { get }
    subscript(i: Int) -> ok { get }
    var type: ok {
        get
    }
}

protocol SuffixableContainer:Container {
    associatedtype Suffix:SuffixableContainer where Suffix.ok == ok
    func suffix(_ size: Int) -> Suffix
}


struct InStack: Container {
    var type: Int
    
    
    var items = [Int]()
    
//    typealias ok = Int
    
    mutating func push(_ item: Int) {
        items.append(item)
        
        
    }
    mutating func pop() ->Int {
        return items.removeLast()
    }
    
    mutating func append(_ item: Int) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
    
    
    func findIndex<T:Equatable>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
}


