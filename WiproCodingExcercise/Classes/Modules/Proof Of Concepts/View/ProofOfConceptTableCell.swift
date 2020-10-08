import UIKit

class ProofOfConceptTableCell: UITableViewCell {
    
    private let labelTitle : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelDescription : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let imgVwFeed : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode  = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override  func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    //setup customcell UI
    func configureCellUI() {
        //Setup date label
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.imgVwFeed)
        self.contentView.addSubview(self.labelTitle)
        self.contentView.addSubview(self.labelDescription)
        
        imgVwFeed.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        imgVwFeed.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        imgVwFeed.widthAnchor.constraint(equalToConstant:70).isActive = true
        imgVwFeed.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        labelTitle.topAnchor.constraint(equalTo:self.imgVwFeed.topAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo:self.imgVwFeed.trailingAnchor,constant: 10).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor,constant: 10).isActive = true
        
        labelDescription.topAnchor.constraint(equalTo:self.labelTitle.bottomAnchor,constant: 0.0).isActive = true
        labelDescription.leadingAnchor.constraint(equalTo:self.imgVwFeed.trailingAnchor,constant: 10.0).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor,constant: -10.0).isActive = true
        labelDescription.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor,constant: -10.0).isActive = true
        
        labelDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 90.0 - self.labelTitle.frame.size.height - 25.0 ).isActive = true
    }
    
    //set feeds data
    var proofConceptRowModel : ProofConceptRow! {
        didSet{
            
            self.selectionStyle = .none
            self.labelTitle.text =  proofConceptRowModel.title
            self.labelDescription.text =  proofConceptRowModel.descriptionField
            
            if let streImagUrl = proofConceptRowModel.imageHref{
                self.imgVwFeed.setImageWith(urlString:streImagUrl , placeholder: nil, imageIndicator: .gray, completion: nil)
            }else {
                self.imgVwFeed.image = UIImage(named: "placeholder")
            }
        }
    }
    
    
}
