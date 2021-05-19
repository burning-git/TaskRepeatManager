//
//  BRTaskRepeatManager.swift
//  TaskRepeatManager
//
//  Created by git burning on 2021/5/19.
//

import UIKit

public class BRTaskRepeatManager {
    /// 执行同步重复任务
    /// - Parameters:
    ///   - repeatCount: <#repeatCount description#>
    ///   - doNextBlock: <#doNextBlock description#>
    /// - Returns: <#description#>
   public func doRepeatSyncAction(repeatCount: Int,doNextBlock: ((_ index: Int)->())?) {
        if repeatCount <= 0 {
        }else{
            doNextBlock?(repeatCount)
            self.doRepeatSyncAction(repeatCount: repeatCount - 1, doNextBlock: doNextBlock)
        }
    }
    
    public class func doRepeatSyncAction(targetVC: UIViewController?,repeatCount: Int,doNextBlock:  ((_ index: Int)->())?) {
        if repeatCount <= 0 {
        }else{
            if targetVC == nil {
                return;
            }
            doNextBlock?(repeatCount)
            self.doRepeatSyncAction(targetVC: targetVC, repeatCount: repeatCount, doNextBlock: doNextBlock)
        }
    }
    
    /// 执行异步重复任务
    /// - Parameters:
    ///   - repeatCount: <#repeatCount description#>
    ///   - doNextBlock: <#doNextBlock description#>
    /// - Returns: <#description#>
    public func doRepeatAsyncAction(repeatCount: Int, delayBlock: ((_ index: Int)->(Double))?, doNextBlock: ((_ index: Int,_ callBack:(()->())?)->())?) {
        if repeatCount <= 0 {
        }else{
            let nextCount = repeatCount - 1
            let callBackBlock = {[weak self] in
                print("run - doRepeatAsyncAction:\(String(describing: self))")
                let delayTime = delayBlock?(nextCount) ?? 0
                DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                    self?.doRepeatAsyncAction(repeatCount: nextCount,delayBlock: delayBlock,doNextBlock: doNextBlock)
                }
            }
            doNextBlock?(repeatCount, callBackBlock)
        }
    }
    
    public class func doRepeatAsyncAction(targetVC: UIViewController?, repeatCount: Int, delayBlock: ((_ index: Int)->(Double))?, doNextBlock: ((_ index: Int,_ callBack:(()->())?)->())?) {
        if repeatCount <= 0 {
        }else{
            let nextCount = repeatCount - 1
            let callBackBlock = {[weak targetVC] in
                if targetVC == nil {
                    print("释放了，在执行")
                    return;
                }
                let delayTime = delayBlock?(nextCount) ?? 0
                DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                    if targetVC == nil {
                        print("释放了，在执行")
                        return;
                    }
                    print("run - doRepeatAsyncAction-tagrtVC:\(String(describing: targetVC))")
                    self.doRepeatAsyncAction(targetVC: targetVC, repeatCount: nextCount,delayBlock: delayBlock,doNextBlock: doNextBlock)
                }
            }
            doNextBlock?(repeatCount, callBackBlock)
        }
    }
    
    deinit {
        print("释放了:\(self)")
    }
}
