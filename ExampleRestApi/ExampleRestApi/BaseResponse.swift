//
//  BaseResponse.swift
//  ExampleRestApi
//
//  Created by MacBook Pro on 20/11/20.
//
/*
 BaseResponse se usa para crear todos los modelos que
 necesitamos para la respuesta del servicio.
 */

import Foundation

public struct Store : Codable{
    var pk: Int
    var fields: Fields
}

public struct Fields : Codable {
    var file_img_home: String
    var file_img_2: String
    var file_img_3: String
    var title: String
    var subTitle: String
    var description: String
    var value: Int
    var material: String
    var color: String
    var sizes_list: String
    var brand: String
}

public struct JSONResponseStore: Codable {
    var success:  Bool
    var message:  String
    var stores :  [Store]
}
