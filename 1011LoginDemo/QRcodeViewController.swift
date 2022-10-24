//
//  QRcodeViewController.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/10/21.
//

import UIKit
import AVFoundation  //引用相機相關的套件

class QRcodeViewController: UIViewController {
    
    
    // 將相機拍攝到的畫面投射到View上面
    @IBOutlet weak var QRCodeProjection: UIView!
    // 讀出來的字串顯示在label上
    @IBOutlet weak var outputlabel: UILabel!
    
    var dataText: String!
    
    // 管理相機擷取的輸入輸出
    var captureSession: AVCaptureSession?
    // 預覽畫面，將相機擷取到的畫面預覽在這上面
    var previewLayer: AVCaptureVideoPreviewLayer?
    // 掃描畫面的美化(加綠色框框）
    var qrCodeBounds: UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 261))
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 3
        return view
    }
    
    public func showAnyOutputText(outputStr:String)
    {
        outputlabel.text = outputStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func doCamerRead(_ sender: Any) {
        callingScanner()
    }
    
    
    @IBAction func doInquireButton(_ sender: Any) {
        
        dataText = outputlabel.text
        print(dataText!)
        performSegue(withIdentifier: "nextPageSegue", sender: nil)
    }
    
    //Segue
    @IBSegueAction func nextpageSegue(_ coder: NSCoder) -> NextPageViewController? {
        let controller = NextPageViewController(coder: coder)
        controller?.dataText = dataText
        return controller
    }
    
    
    //UIViewController即將消失的時候停用掃瞄器，可以防止在背景的時候還在掃描
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if(captureSession?.isRunning == true){
            captureSession?.stopRunning()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension QRcodeViewController{
    //呼叫掃描器
    public func callingScanner(){
        //不是nil的話就(啟動/停止掃瞄器)
        if let capture = captureSession{
            //三元運算子簡化判斷captureSession檢測執行中所要做的事情
            capture.isRunning ? capture.stopRunning() : capture.startRunning()
        }else{
            //初始化
            configurationScanner()
            //重新呼叫一次(應該不會再進來第二次)
            callingScanner()
        }
    }
    
    //設定captureSession
    private func configurationScanner(){
        // 設定 Camera Capture
        captureSession = AVCaptureSession()
        
        //建立captureSession物件，並且將上面的AVCaptureDeviceInput實體設定進去
        if let deviceInput = getAVCaptureDeviceInput(){
            // 將取到的deviceInput塞入captureSession
            if captureSession?.addInput(deviceInput) == nil{
                failed() // Simulator mostly
                return
            }
        }
        //實體化一個AVCaptureMetadataOutput實體並設定至captureSession
        setAVCaptureMetadataOutput()
        // 設定preview的畫面要呈現在哪邊
        setQRCodePreview()
        //設置邊框
        //qrCodeBounds的畫面設定已經在宣告變數的時候做好了
        //這邊就是將.alpha調成0加到cameraContainerView上做預備顯示掃描框框的顯示
        qrCodeBounds.alpha = 0
        QRCodeProjection.addSubview(qrCodeBounds)
        //原先的範例是做完設定後馬上啟動
        //這邊想分開設定Scanner和執行Scanner的部分
        //因此拉出來在callingScanner()上啟動掃瞄器
    }
    
    
    
    
    //依照取得的相機建立AVCaptureDeviceInput實體
    private func getAVCaptureDeviceInput() -> AVCaptureDeviceInput?
    {
        var videoInput: AVCaptureDeviceInput? = nil
        //取得使用相機的權限，這裡就用預設的相機
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else
        {
            print("無法獲取相機裝置")
            return videoInput
        }
        //由獲取的裝置嘗試建立AVCaptureDeviceInput實體
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            // 假如有錯誤發生、印出錯誤描述
            print(error.localizedDescription)
        }
        return videoInput
    }
    
    //因為要掃描的是QRCode，解析的資訊會變成metadata輸出，要娶的是AVCaptureMetadataOutput實體
    private func setAVCaptureMetadataOutput(){
        // 需要先addOutput之後才能做細部設定
        // 先做設定再addOutput會出錯
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession?.addOutput(metadataOutput) == nil{
            failed()
            return
        }
        //使用 DispatchQueue.main 來取得預設的主佇列(眾多範例、文件都這麼寫)
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        // 告訴 App 我們所想要處理 metadata 的對象對象類型，解析QRCode的列舉就是[qr]
        metadataOutput.metadataObjectTypes = [.qr] // Also have things like Face, body, cats
    }
    
    
    // 設定掃描預覽畫面範圍
    private func setQRCodePreview(){
        if let session = captureSession{
            //直接建立就不用擔心有nil的情況讓程式崩潰
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            //這邊previewLayer.frame設定可能會出點差錯
            //這是指定預覽畫面在呈現時的位置與大小
            //用view.layer.bounds表示preview在顯示的時候是整個UIViewController的view
            //如果想指定呈現在固定的小範圍就要用範例的cameraContainerView做設定
            //也許之前的版本只要addSublayer就可以塞到cameraContainerView拉好的小框框
            //但現在嘗試就是無法這麼做，或許還要多點研究
            //            previewLayer!.frame = view.layer.bounds
            previewLayer!.frame = QRCodeProjection.layer.bounds
            previewLayer!.videoGravity = .resizeAspectFill
            QRCodeProjection.layer.addSublayer(previewLayer!)
        }
    }
    //失敗的提示
    private func failed() {
        let ac = UIAlertController(title: "Scanning failed", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
}

//要取得掃描後的資訊，就需要引用AVCaptureMetadataOutputObjectsDelegate
//實作metadataOutput這個方法就可以取到掃描之後的資料
extension QRcodeViewController:AVCaptureMetadataOutputObjectsDelegate
{
    //Override
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)
    {
        //還有看到一種是這樣取回資料
        //metadataObjects[0] as? AVMetadataMachineReadableCodeObject
        //感覺應該是相同的方式
        if let metadataObject = metadataObjects.first
        {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            //取到的字顯示出來
            showAnyOutputText(outputStr: stringValue)
            //顯示掃描到的QRCode打個框框讓使用者知道
            let qrCodeObject = previewLayer?.transformedMetadataObject(for: readableObject)
            showQRCodeBounds(frame: qrCodeObject?.bounds)
            //(選擇)完成掃描後停止繼續掃描
            callingScanner()
        }
    }
    
    //顯示框框在掃描到的QRCode上
    func showQRCodeBounds(frame: CGRect?) {
        guard let frame = frame else { return }
        
        qrCodeBounds.layer.removeAllAnimations() // resets any previous animations and cancels the fade out
        qrCodeBounds.alpha = 1
        qrCodeBounds.frame = frame//設定顯示的位置
        //加入animate讓框框自動消失
        UIView.animate(withDuration: 0.2, delay: 1, options: [], animations: { // after 1 second fade away
            self.qrCodeBounds.alpha = 0
        })
    }
}

