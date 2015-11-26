//
//  ListOrdersPresenter.swift
//  CleanStore
//
//  Created by Raymond Law on 10/31/15.
//  Copyright (c) 2015 Raymond Law. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ListOrdersPresenterInput
{
  func presentFetchedOrders(response: ListOrders_FetchOrders_Response)
}

protocol ListOrdersPresenterOutput: class
{
  func displayFetchedOrders(viewModel: ListOrders_FetchOrders_ViewModel)
}

class ListOrdersPresenter: ListOrdersPresenterInput
{
  weak var output: ListOrdersPresenterOutput!
  let dateFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = .ShortStyle
    dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
    return dateFormatter
  }()
  let currencyFormatter: NSNumberFormatter = {
    let currencyFormatter = NSNumberFormatter()
    currencyFormatter.numberStyle = .CurrencyStyle
    return currencyFormatter
  }()
  
  // MARK: Presentation logic
  
  func presentFetchedOrders(response: ListOrders_FetchOrders_Response)
  {
    var displayedOrders: [ListOrders_FetchOrders_ViewModel.DisplayedOrder] = []
    for order in response.orders {
      let date = dateFormatter.stringFromDate(order.date!)
      let total = currencyFormatter.stringFromNumber(order.total!)
      let displayedOrder = ListOrders_FetchOrders_ViewModel.DisplayedOrder(id: order.id!, date: date, email: order.email!, name: "\(order.firstName!) \(order.lastName!)", total: total!)
      displayedOrders.append(displayedOrder)
    }
    let viewModel = ListOrders_FetchOrders_ViewModel(displayedOrders: displayedOrders)
    output.displayFetchedOrders(viewModel)
  }
}
