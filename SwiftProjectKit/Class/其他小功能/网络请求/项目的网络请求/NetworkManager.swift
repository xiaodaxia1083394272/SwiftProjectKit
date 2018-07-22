//
//  NetworkManager.swift
//  HappyOnigiri
//
//  Created by Willima Lee on 10/01/2017.
//  Copyright © 2017 Willima Lee. All rights reserved.
//

import Foundation
import WMNetworkKit
/*
 extension Data {
 
 mutating func appendString(string: String) {
 guard let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true) else { return }
 self.append(data)
 }
 
 }
 
 class FormData {
 
 private var request: NSMutableURLRequest!
 private var boundaryConstant: String
 private var body: Data = Data()
 private var error:NSError?
 
 init(url : NSURL , cachePolicy: NSURLRequest.CachePolicy , timeoutInterval: TimeInterval,method:String = "POST"){
 request = URLRequest(URL: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
 request.httpMethod = method
 initRequestData()
 }
 
 init(url:NSURL,method:String = "POST"){
 request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 2.0)
 request.httpMethod = method
 initRequestData()
 }
 
 private func initRequestData(){
 boundaryConstant = generateBoundaryString()
 let contentType:NSString = "multipart/form-data; boundary=\(boundaryConstant)"
 request.setValue(contentType, forHTTPHeaderField: "Content-Type")
 }
 
 private func generateBoundaryString() -> String {
 return "Boundary-\(NSUUID().UUIDString)"
 }
 
 func append(_ key: String, value:String){
 body.appendString("--\(boundaryConstant)\r\n")
 body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
 body.appendString("\(value)\r\n")
 }
 
 func appendFile(_ key: String, filePath: NSURL!){
 if let data = NSData(contentsOfFile: filePath.path!){
 let filename = filePath.lastPathComponent!
 let mimetype = mimeTypeForPath(filePath.path!)
 appendData(key: key, data: data, filename: filename, mimetype: mimetype)
 }
 }
 
 func appendData(_ key: String, data: NSData!, filename: String, mimetype: String){
 body.appendString(string: "--\(boundaryConstant)\r\n")
 body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\";filename=\"\(filename)\"\r\n")
 body.appendString("Content-Type: \(mimetype)\r\n\r\n")
 body.append(data)
 body.appendString("\r\n")
 }
 
 private func mimeTypeForPath(path: String) -> String {
 let pathExtension = path.pathExtension
 if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
 if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
 return mimetype as NSString
 }
 }
 return "application/octet-stream";
 }
 
 }
 */
public class NetworkManager {
  
  public typealias ProgressHandle = (_ progress: Float) -> Void
  public typealias CompleteHandle = (_ result: RequestResultModel) -> Void
  
  public class func request(_ method: WMNetwork.HTTPMethod,
                     with apiPath: NetworkManager.APIPath,
                     query: [String : Any]? = nil,
                     body: [String : Any]? = nil,
                     handle: @escaping CompleteHandle) {
    
    var network = WMNetwork.request(method, apiPath.api)
    
    if let query = query {
      
      network = network.query(query)
    }
    
    if let body = body {
      
      network = network.body(body)
    }
    
    network.data { (data, status) in
      
      let resultModel = RequestResultModel(data)
      
      DispatchQueue.main.async {
        
        handle(resultModel)
      }
      
    }
    
  }
  
  public class func refresh(_ method: WMNetwork.HTTPMethod,
                     with apiPath: NetworkManager.APIPath,
                     query: [String : Any]? = nil,
                     body: [String : Any]? = nil,
                     handle: @escaping CompleteHandle) {
    
    // 2、请求地址
    var urlStringWithQuery = apiPath.api
    
    // 3、生成Query，并附加到请求地址后
    if let query = query, query.count > 0 {

      urlStringWithQuery.append("?")
      urlStringWithQuery.append(query.map { "\($0)=\($1)" }.joined(separator: "&"))

    }
    
    // 4、对请求地址进行编码
    guard let urlStringWithQueryAndEncod = urlStringWithQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
    
    guard let url = URL(string: urlStringWithQueryAndEncod) else { return }
    var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20)
    request.httpMethod = method.rawValue
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      
      let resultModel = RequestResultModel(data)
      
      DispatchQueue.main.async {
        
        handle(resultModel)
      }
    }
    task.resume()
    
  }
  
  public class func upload(from data: Data, withName name: String, to apiPath: NetworkManager.APIPath, progressHandle: @escaping ProgressHandle, completeHandle: @escaping CompleteHandle) {
    
    WMNetwork.isDebug = true
    
    let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
    let contentType: String = "multipart/form-data; boundary=\(boundary)"
    
    var body = Data()
    
    var pre: String = ""
    var sub: String = ""
    
    pre += "--\(boundary)\r\n"
    pre += "Content-Disposition:form-data; name=\"file\"; filename=\"1506095123.mp4\"\r\n"
    pre += "Content-Type: video/MOV\r\n\r\n"
    
    sub += "\r\n"
    sub += "--\(boundary)\r\n"
    sub += "Content-Disposition:form-data; name=\"fileName\""
    sub += "\r\n\r\n\(name)\r\n"
    sub += "--\(boundary)--"
    //print(name)
    //print("1、\(body.count)")
    if let temp = pre.data(using: String.Encoding.utf8) {
      
      body.append(temp)
    }
    //print("2、\(body.count)")
    body.append(data)
    //print("3、\(body.count)")
    if let temp = sub.data(using: String.Encoding.utf8) {
      
      body.append(temp)
    }
    //print("4、\(body.count)")
    //    WMNetwork.request(.post, apiPath.api, isDebug: true).form(body).contentType(contentType).progress({ (sendedCount, totalCount, partailData) in
    //
    //      progressHandle(Float(sendedCount)/Float(totalCount))
    //
    //    }).data({ (data, status) in
    //
    //      let resultModel = RequestResultModel(data)
    //      DispatchQueue.main.async {
    //
    //        completeHandle(resultModel)
    //      }
    //
    //    })
    WMNetwork.request(.post, apiPath.api, isDebug: true).contentType(contentType).progress({ (sendedCount, totalCount, partailData) in
      
      progressHandle(Float(sendedCount)/Float(totalCount))
      
    }).upload(with: body, { (data, status) in
      
      let resultModel = RequestResultModel(data)
      DispatchQueue.main.async {
        
        completeHandle(resultModel)
      }
      
    })
  }
  
}

// MARK: - API
public extension NetworkManager {
  
  enum APIPath : String {
    
    /// 基路径
    case productBasePath = "http://fandomschool.cn/api/"
    case developBasePath = "http://haha.51feijin.com/api/"
    
    
    /// 首页
    case home = "home"
    
    /// 活动列表首页
    case homeActivityList = "activity"
    
    /// 活动详情-奖项
    case activityDetailForAward = "activity/detail"
    /// 活动详情-明星列表
    case activityDetailForVoteList = "activity/starList"
    /// 活动投票-明星、组合、歌曲投票
    case activityVote = "activity/voteStar"
    /// 活动投票-饭友列表
    case activityVoteForFansList = "activity/riceFriend"
    
    /// 抽奖公告列表
    case lotteryPlacardList = "prize/list"
    /// 进行抽奖
    case lotteryAction = "prize/create"
    
    /// 评论列表-包括活动奖项投票中的评论及明星资讯中评论
    case commentList = "comment/list"
    /// 评论
    case comment = "comment/create"
    /// 评论点赞、取消
    //case commentCommend = "comment/nice"
    
    /// 分享
    case share = "share/callback"
    /// 我的投票总数
    case myVoteCount = "myVotes/countVotes"
    /// 我的爱豆
    case favoriteList = "my/beans/list"
    /// 热门明星
    case starHotList = "star/hot/list"
    /// 明星库列表
    case starLibraryList = "star/list"
    /// 明星搜索使用starLibraryList
    //case starSearchList
    /// 明星资讯详情
    case starNewsDetail = "news/detail"
    /// 明星详情
    case starDetail = "star/detail"
    /// 关注明星
    case focus = "star/focus"
    /// 取消关注明星
    case unfocus = "star/not/focus"
    /// 明星资讯点赞、取消
    case newsCommend = "news/nice"
    
    /// 关注或取消关注用户
    case focusOrUnfocusUser = "community/focus"
    
    /// 歌曲详情
    case musicDetail = "music/detail"
    
    /// 获取用户信息
    case getUserInfo = "security/getUserInfo"
    /// 编辑用户信息
    case editUserInfo = "security/editInfo"
    /// 修改头像
    case editAvatar = "upload/avatar"
    /// 修改昵称
    case editNickName = "security/updateNickname"
    /// 修改个性签名
    case editSignature = "security/signature"
    /// 我的投票列表
    case myVoteList = "myVotes"
    /// 签到列表
    case attendanceRecordList = "sign/list"
    /// 签到
    case attendance = "sign/create"
    /// 系统通知列表
    case systemMessageList = "message/list"
    /// 我的钱包-获取余额
    case myBalance = "myWithdraw/balance"
    /// 我的钱包-提交提现申请
    case withdraw = "myWithdraw/withdraw"
    /// 我的钱包-银行卡列表
    case bankCardList = "myWithdraw/banks"
    /// 我的钱包-获取提现记录
    case withdrawRecordList = "myWithdraw/withdraws"
    /// 内购产品列表
    case productList = "recharge/priceList"
    /// 充值-创建订单
    case order = "order/apply"
    /// 充值-内购购买成功
    case paySuccess = "ios/inAppPurchase/callback"
    
    //// 兑换
    case exchange = "cdkey/conversion"
    /// 兑换记录列表
    case exchangeRecordList = "cdkey/list"
    
    /// 手机注册
    case mobileRegister = "security/register"
    /// 邮箱注册
    case emailRegister = "security/registerEmail"
    /// 登陆
    case login = "security/login"
    /// 快速登陆
    case quickLogin = "security/authorizationLogin"
    /// 退出
    case logout = "security/logout"
    /// 修改密码
    case editPassword = "security/modifypassword"
    /// 重置密码
    case resetPassword = "security/forgetPassword"
    /// 获取手机验证码
    case mobileVerifyCode = "mobile/code"
    /// 获取邮箱验证码
    case emailVerifyCode = "email/code"
    /// 重置密码验证码
    case resetVerifyCode = "security/sendForgetPasswordCode"
    /// 绑定手机
    case bindPhone = "security/bindPhone"
    /// 绑定邮箱
    case bindEmail = "security/bindEmail"
    
    /// 搜索-视频
    case searchVideo = "videos/search"
    /// 搜索-首页
    case searchHome = "videos/searchHome"
    /// 搜索-用户
    case searchUser = "videos/searchUser"
    
    /// 用户-详情
    //case userDetail = "community/user/detail"
    /// 用户-关注的用户列表
    case userAttentedUserList = "community/user/attentionList"
    /// 用户-粉丝列表
    case userFansUserList = "community/user/fansList"
    
    /// 视频-首页
    case videoHomeList = "videos/home"
    /// 视频-热门视频列表
    case videoHotList = "videos/hot"
    /// 视频-推荐列表
    case videoCommendList = "videos/recommend"
    /// 视频-最新列表
    case videoNewestList = "videos/newest"
    /// 视频-其他分类列表
    case videoOtherList = "videos/channel"
    /// 视频-详情
    case videoDetail = "videos/detail"
    /// 视频-评论刷新
    case videoCommentRefresh = "videos/refreshComment"
    /// 视频-弹幕刷新
    case videoBarrageRefresh = "videos/refreshBarrage"
    /// 视频-发布弹幕
    case videoBarrageSubmit = "videos/barrage"
    /// 视频-打赏白饭团
    case videoRewardWhiteOnigiri = "videos/nice"
    /// 视频-打赏金饭团
    case videoRewardGoldOnigiri = "videos/reward"
    /// 视频-上线（视频）
    case videoOnline = "videos/isOnLine"
    /// 视频-收藏视频
    case videoCollect = "videos/collect"
    /// 视频-取消收藏视频
    case videoUncollect = "videos/cancelCollect"
    /// 视频-分类
    case videoCategoryList = "video/category"
    /// 视频-上传
    case uploadVideo = "video/upload"
    /// 视频-提交
    case videoCommit = "video/create"
    /// 视频列表
    case videoList = "video"
    /// 视频-点赞
    case videoCommand = "video/nice"
    /// 视频-上报／举报
    case videoReport = "feedback/create"
    
    /// 视屏打赏记录
    case videoRewardRecordList = "videos/rewards"
    
    
    /// 我收藏的视频
    case myCollectedVideos = "videos/collects"
    /// 我的视频列表
    case myVideoList = "myVideo"
    /// 删除我的视频
    case myVideoDelete = "myVideo/remove"
    
    
    /// 启动广告
    case launchAD = "spread/home"
    /// 检查版本
    case checkVersion = "version/isNew"
    
    /// 图形验证码
    case captcha = "security/captcha"
    
    
    
    
    
    
    
    var isDevelop: Bool {
      
      return API.isDevelop
    }
    
    /// 获取Api路径
    public var api: String {
      
      if self.isDevelop {
        
        return APIPath.developBasePath.rawValue.appending(self.rawValue)
      }
      
      return APIPath.productBasePath.rawValue.appending(self.rawValue)
    }
  }
}














