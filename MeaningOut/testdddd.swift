//func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    print(#function)
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FindResultCollectionViewCell.id, for: indexPath) as! FindResultCollectionViewCell
//    let data = list.items[indexPath.item]
//    let imageURL = URL(string: data.image)
//    cell.imageView.kf.setImage(with: imageURL)
//    cell.storeLabel.text = data.mallName
//    var titletext = data.title
//    titletext = titletext.replacingOccurrences(of: "<b>", with: " ")
//    titletext = titletext.replacingOccurrences(of: "</b>", with: " ")
//    print("검색결과 개수: \(list.total)")
//    // 검색결과 0이 나오는 조건의 경우
//    if list.total < 1 {
//        print(list.total)
//        cell.titleLabel.text = "검색결과없습니다"
//        hiddenButton()
//        return cell
//    } else {
//        print("검색결과 0아닌경우 !!!!!!!")
//        var title = data.title.replacingOccurrences(of: "<b>\(search!)</b>", with: "\(search!)", options: .regularExpression)
//    }
//    cell.titleLabel.text = titletext
//    UserDefaults.standard.setValue(title, forKey: "title")
//
//    let numberFormatter: NumberFormatter = NumberFormatter()
//    numberFormatter.numberStyle = .decimal
//    let result: String = numberFormatter.string(for: Int(data.lprice))!
//    cell.priceLabel.text = "\(result)원"
//
//    let item = list.items[indexPath.row]
//    cell.configure(with: item)
//    cell.indexPath = indexPath
//    cell.delegate = self
//
//    let isLiked2 = UserDefaults.standard.bool(forKey: "isLiked")
//
//    return cell
//}
