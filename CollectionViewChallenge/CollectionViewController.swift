import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    static let reuseIdentifier = "cell"
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewController.reuseIdentifier)
        
        for image in 1...12 {
            guard let image = UIImage(named: "Image\(image)") else { return }
            images.append(image)
        }
        
        collectionView?.allowsMultipleSelection = true
        
    }
    let targetDimension: CGFloat = 320
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {fatalError("unable to retrieve layout")}
        
        let insetAmount: CGFloat = 32
        layout.minimumLineSpacing = .greatestFiniteMagnitude
        layout.sectionInset = UIEdgeInsets(top: insetAmount, left: insetAmount, bottom: insetAmount, right: insetAmount)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewController.reuseIdentifier, for: indexPath) as? CollectionViewCell else { fatalError("Unable to load cell") }
    
        cell.imageView.image = images[indexPath.row]
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, layout collecttionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = images[indexPath.row]
        let maxDimension = max(image.size.width, image.size.height)
        let scale = targetDimension / maxDimension
        return CGSize(width: image.size.width * scale, height: image.size.height * scale)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.yellow.cgColor
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
    }
}
