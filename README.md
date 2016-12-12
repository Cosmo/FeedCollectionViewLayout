# [WIP] FeedCollectionViewLayout

A Customizable UICollectionLayout for single and multi-column feeds.

## Usage

### Basic Setup

```swift
let collectionViewLayout = FeedCollectionViewLayout()
// setup optional properties here
return UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
```

### Enable Self-Sizing Cells (optional)

```swift
collectionViewLayout.estimatedItemHeight = 20.0
collectionViewLayout.itemHeight = FeedCollectionViewLayoutAutomaticHeight
```

### Properties

```swift
collectionViewLayout.itemHeight // CGFloat
collectionViewLayout.estimatedItemHeight // CGFloat

collectionViewLayout.sectionInsets // UIEdgeInsets
collectionViewLayout.numberOfColumns // Int
collectionViewLayout.lineSpacing // CGFloat
collectionViewLayout.interItemSpacing // CGFloat
```

### Delegate (optional)

Subclass `FeedCollectionViewLayoutDelegate` and implement the protocol:

```swift
func insetsForSection(_ section: Int) -> UIEdgeInsets
func lineSpacingForSection(_ section: Int) -> CGFloat
func interItemSpacingForSection(_ section: Int) -> CGFloat
func heightForItem(at indexPath: IndexPath) -> CGFloat
func numberOfColumns(inSection section: Int) -> Int
```

and create a reference:

```swift
collectionViewLayout.delegate = MyFeedDelegate()
```


