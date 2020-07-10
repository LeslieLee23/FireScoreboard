////
////  History.swift
////  Score1031
////
////  Created by Danting Li on 1/9/20.
////  Copyright © 2020 HULUCave. All rights reserved.
////
//
//import SwiftUI
//
//enum InputError: Error {
//  case empty
//}
//
//struct ZRecordView: View {
//    
////    @ObservedObject var cellVM: CellViewModel
//    
//     var body: some View {
//
//         HStack(){
//             VStack(alignment: .leading){
//            Text(cellVM.record.playerID)
//            .font(.headline)
//            Text(cellVM.record.recordName)
//                 .font(.headline)
//             Text(cellVM.record.recordScore)
//                .font(.headline)
//                .foregroundColor(cellVM.record.recordScore.first == "-" ? .red : .green)
//                }
//            .frame(width:90,height: 45, alignment: .leading)
//           // .border(Color.purple)
//            
//           
//            VStack(alignment: .leading){
//                Text(cellVM.record.recordReason)
//                    .font(.system(size: 13))
//                    .multilineTextAlignment(.leading)
//                Text(cellVM.record.recordEntryTimeString)
//                    .font(.system(size: 13))
//            }
//            .frame(width:210, height: 45, alignment: .leading)
//          //  .border(Color.purple)
//        
//        }
//    }
//}
//
//struct ZRecordView_Preview: PreviewProvider
//{
//    static var previews: some View {
//        RecordView()
//    }
//}
