import UIKit
import AVKit
import CoreData

struct Config {
	var maxSize: Int64
	var purgeLogic: [String] = ["Size", "TS"]
	// max size(TH)
	// max item count
	var purgingDays: Int
	// priority
}

class CacheManager {
	var config: Config!

	var storeURL: URL! // path of the table in DB

	var context: NSManagedObjectContext!

	/*
	 SCHEMA
	 1. PK - ID ("URL")
	 2. TS - Int64
	 3.	mediaPath (URL) --> within App's sandbox(dev don't have control)
	 4. size
	 */


	public func getSqliteStoreSize(forPersistentContainerUrl storeUrl: URL) -> Int64 {}

	func savePath(filePath: String, incomingSize: Int64) {

		let currentSize = getSqliteStoreSize(forPersistentContainerUrl: storeURL)
//		1. check context size
		if currentSize + incomingSize > config.maxSize {
			// purging LRU
			try? purgeData(requiredSpace: currentSize - incomingSize)
			try? context.save()
//			save()
		} else {
//			save()
		}
	}

	func purgeData(requiredSpace: Int64) throws {
		switch config.purgeLogic.first  {
			case "Size":
				let query = "SORT BY size DESC"
				let results: [Result] = context.fetch(query)

				let itemsToBeRemoved: [Result] = []

				results.forEach { singleItem in

					itemsToBeRemoved.append(singleItem)

					let currentEarmarkedSize = itemsToBeRemoved.reduce { $0.size }
					if currentEarmarkedSize > requiredSpace {
						break
					}

					if singleItem.size > requiredSpace {
						break
					}
				}

				if itemsToBeRemoved.isEmpty {
					// throw error
				}

				itemsToBeRemoved.forEach { item in
					let query = "ID = \(item.id)"
					let resultsToBeDeleted: [Result] = context.fetch(query)

					context.delete()

					context.updatedObjects = All items filter resultsToBeDeleted
				}
				return



			case "TS":
				let query = "SORT BY TS"
				let results: [] = context.fetch(query)

				let itemsToBeRemoved: [Result] = []
				results.forEach { singleItem in
					singleItem.age > config.purgingDays {
						itemsToBeRemoved.append(singleItem)
					}
				}
		}
	}

	func checkDB(mediaURL: URL) -> URL? {
		// check the DB for mediaURL

		let query = "ID == \(mediaURL.absoluteString)"
		let results: [] = context.fetch(query)
		// results.size <= 1 {
	//}
		results[0]
	}

}

/*
class Cacher {

	var config: Config!

	var storeURL: URL // path of the table in DB

	var context: NSManagedObjectContext!

	/*
	 1. PK - ID ("URL")
	 2. TS - Int64
	 3.	mediaPath (URL) --> within App's sandbox(dev don't have control)
	 4. size
	 */

	// Cache
	// LRU
	//
	/// <#Description#>
	/// - Parameter url: HLS m3u8
//	func cacheData(mediaURL: URL) {
//
//		let player: AVPlayer
//
//		// check for given mediaURL in cache -> mediaStream
//		if let asset = fetchData(mediaURL) {
//			player.play(asset)
//
//			if needsToDownload {
//				player.setStream(url)
//			}
//		} else {
//			//1. assign the stream to the player
//			player.setStream(url)
//			player.play()
//			AVAssetDownloadURLSession
//		}
//
//
//
//
//
////		// content expiry (days/ timeframe) 90
////		// mediaSize (priority)
////		- Youtube(, default, high)
////			- 2gb was left   -> download 1gb  --> 1gb
////		- PrimeVideo 3gb(500 * 6) - (low)
////
////		//
//
//
//
////		//2. media is fully downloaded
////		URLRequest(url: url).fetch {
////			assign the stream to the player
////		}
//	}
	
	/// 1. media is saved
	/// 2. save that path to DB
	/// - Parameter managfer: <#managfer description#>
//	func didFinishDownloadingToUR(file managfer URL) {
//		savePath()
//	}

	public func getSqliteStoreSize(forPersistentContainerUrl storeUrl: URL) -> Int64 {}

	func savePath(filePath: String, incomingSize: Int64) {

		let currentSize = getSqliteStoreSize(forPersistentContainerUrl: storeURL)
//		1. check context size
		if currentSize + incomingSize > config.maxSize {
			// purging LRU
			try? purgeData(requiredSpace: currentSize - incomingSize)
			try? context.save()
//			save()
		} else {
//			save()
		}
	}

	func purgeData(requiredSpace: Int64) throws {
		switch config.purgeLogic.first  {
			case "Size":
				let query = "SORT BY size DESC"
				let results: [Result] = context.fetch(query)

				let itemsToBeRemoved: [Result] = []

				results.forEach { singleItem in
					
					itemsToBeRemoved.append(singleItem)

					let currentEarmarkedSize = itemsToBeRemoved.reduce { $0.size }
					if currentEarmarkedSize > requiredSpace {
						break
					}

					if singleItem.size > requiredSpace {
						break
					}
				}

				if itemsToBeRemoved.isEmpty {
					// throw error
				}

				itemsToBeRemoved.forEach { item in
					let query = "ID = \(item.id)"
					let resultsToBeDeleted: [Result] = context.fetch(query)

					context.delete(<#T##object: NSManagedObject##NSManagedObject#>)

					context.updatedObjects = All items filter resultsToBeDeleted
				}
				return



			case "TS":
				let query = "SORT BY TS"
				let results: [] = context.fetch(query)

				let itemsToBeRemoved: [Result] = []
				results.forEach { singleItem in
					singleItem.age > config.purgingDays {
						itemsToBeRemoved.append(singleItem)
					}
				}
		}
	}

//	func fetchData(mediaURL: URL) throws -> AVAssetCache{
//		let url = checkDB()
//		
//		available = url != nil
//
//		if available, cache.isPlayable {
//			return AVAssetCache()
//		} else {
//			return nil
//		}
//
//	}

	func checkDB(mediaURL: URL) -> URL? {
		// check the DB for mediaURL

		let query = "ID == \(mediaURL.absoluteString)"
		let results: [] = context.fetch(query)
		// results.size <= 1 {
	//}
		results[0]
	}



}

*/
