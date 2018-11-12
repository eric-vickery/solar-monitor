//
//  BrultechChannels.swift
//  SolarMonitor
//
//  Created by Eric Vickery
//

import Foundation
import ObjectMapper

class BrultechChannels: Mappable
{
	var channelList: [Int]?
	
	required init?(map: Map)
	{
	}
	
	func mapping(map: Map)
	{
		var stringChannelList: [String]?
		
		stringChannelList <- map["channels"]
		
		if let stringChannelList = stringChannelList
		{
			channelList = [Int]()
			
			for item in stringChannelList
			{
				if let intItem = Int(item)
				{
					channelList?.append(intItem)
				}
			}
		}
	}
}
