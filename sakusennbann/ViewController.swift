//
//  ViewController.swift
//  sakusennbann
//
//  Created by USER on 2017/02/28.
//  Copyright © 2017年 juri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //スタンプの画像が入った配列
    var imageNameArray: [String] = ["透明丸 2", "透明丸"]
    var touchView = TouchView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
    var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
    @IBOutlet var redbutton: UIButton!
    @IBOutlet var bluebutton: UIButton!
    @IBOutlet var LabelX: UILabel!
    @IBOutlet var LabelY: UILabel!
    var ArrayX = [CGFloat]()
    var ArrayY = [CGFloat]()
    var animecount = 0
    let saiseitimer = Timer()
    let memorytimer = Timer()
    
    
    //選択しているスタンプの番号
    var imageIndex: Int = 0
    var redtag: Int = 0
    var bluetag: Int = 0
    
    //背景画像を表示させるImageView
    @IBOutlet var haikeiImageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        
        
    }
    @IBAction func stop() {
    memorytimer.invalidate()
    }
    func move() {
        //座標を読み込む
        print("タイマー動いてます")
        ArrayX.append(touchView.frame.origin.x)
        print(ArrayX)
        ArrayY.append(touchView.frame.origin.y)
        print(ArrayY)
    }
    
    
    
    @IBAction func  selectedFirst() {
        imageIndex = 1
        redtag = redtag + 1
        appearInView(imageIndex)
        print("タグの番号は",imageView.tag)
        touchView.color = "red"
    }
    
    
    @IBAction func  selectedSecond() {
        imageIndex = 2
        bluetag = bluetag + 1
        appearInView(imageIndex)
        print("タグの番号は",imageView.tag)
        touchView.color = "blue"
        
    }
    
    
    
    
    func appearInView(_ redOrBlue: Int){
        touchView = TouchView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        
        if redOrBlue == 1{
            imageView.tag = redtag
            let image:UIImage = UIImage(named: imageNameArray[0])!
            imageView.image = image
            
            
            
            touchView.center = CGPoint(x:30,y:30)
            //７つ置いたらボタンを使用不可に
            //            redtag = redtag + 1
            if redtag == 7{
                redbutton.isEnabled = false
            }
            
            
        }else if redOrBlue == 2 {
            imageView.tag = bluetag
            let image:UIImage = UIImage(named: imageNameArray[1])!
            imageView.image = image
            
            
            touchView.center = CGPoint(x:80,y:30)
            //７つ置いたらボタンを使用不可に
            //            bluetag = bluetag + 1
            if bluetag == 7{
                bluebutton.isEnabled = false
            }
            
            
        }
        self.view.addSubview(touchView)
        touchView.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        // ロングプレスを定義
        //let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(LongPressCodeViewController.longPressView(_:)))  //Swift2.2以前
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressView(sender:)))  //Swift3
        longPressGesture.minimumPressDuration = 1  //1秒間以上押された場合にロングプレスとする
        longPressGesture.allowableMovement = 30  //ロングプレスを判定する指が動いていい範囲、単位はpx
        
        touchView.addGestureRecognizer(longPressGesture)
        
        
        func animation(){
            UIView.animate(withDuration: 0.05,
                           //アニメーション中の処理
                animations: { () -> Void in
                    self.imageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            }){ (Bool) -> Void in
                self.imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }
        
        
        
    }
    
    
    //"今からルートを記憶しますよボタン(=記憶ボタン)"を押す
    //image(丸)を選択してドラッグする
    //ドラッグした時のルート（座標）を記憶
    //ドラッグが終わったら元の位置にimageを戻す
    //（ドラッグしたルートにパスを描けたらなおよい）
    //再生ボタンで記憶したルート上をimageが移動
    
    
    
    class TouchView: UIView{
        
        var latesttouch: UITouch!
        var color:String = "aiueo"
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            print("色は",color)
        }
        
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch:UITouch = touches.first!
            // 移動する前の座標を取得.
            let prevLocationX = touch.previousLocation(in: self).x
            let prevLocationY = touch.previousLocation(in: self).y
            
            // 移動した先の座標を取得.
            let locationX = touch.location(in: self).x
            let locationY = touch.location(in: self).y
            
            
            // ドラッグで移動したx, y距離をとる.
            let deltaX: CGFloat = locationX - prevLocationX
            let deltaY: CGFloat = locationY - prevLocationY
            
            // CGRect生成
            var myFrame: CGRect = self.frame
            
            // 移動した分の距離をmyFrameの座標にプラスする.
            myFrame.origin.x += deltaX
            myFrame.origin.y += deltaY
            // frameにmyFrameを追加.
            self.frame = myFrame
        }
        
        // タッチイベントの検出
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            latesttouch = touches.first!
            print("image touched")
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    /// ロングプレス時に実行される
    
    func longPressView(sender: UILongPressGestureRecognizer) {
        print("Long Press")
        //self.touchView.removeFromSuperview()
        touchView = sender.view as! ViewController.TouchView
        //アラートを出す
        let alert:UIAlertController = UIAlertController(title:"削除",message:"選択した丸を削除します。", preferredStyle: .alert)
        
        //OKボタン
        alert.addAction(
            UIAlertAction(
                title:"OK",
                style: UIAlertActionStyle.default,
                handler: {action in
                    //ボタンが押された時の動作
                    NSLog("OKボタンが押されました")
                    sender.view?.removeFromSuperview()
                    
                    if self.touchView.color == "red"{
                        self.redtag = self.redtag - 1
                        print("削除したので赤のタグ番号は",self.redtag)
                        if self.redtag == 7{
                            self.redbutton.isEnabled = false
                        }else{
                            self.redbutton.isEnabled = true
                        }
                    }else{
                        self.bluetag = self.bluetag - 1
                        print("削除したので青のタグ番号は",self.bluetag)
                        if self.bluetag == 7{
                            self.bluebutton.isEnabled = false
                        }else{
                            self.bluebutton.isEnabled = true
                        }
                    }
            }
            )
        )
        present(alert, animated: true, completion: nil)
        
        
        
        
        func testSlider(sender: UISlider) {
            
            
        }
        
        
        
        
        
        
        
        
        func store() {
            
        }
        
    }
    
    
    
    @IBAction func saisei() {
        let saiseitimer = Timer.scheduledTimer(
            timeInterval:0.1,
            target: self,
            selector: #selector(ViewController.anime),
            userInfo: nil,
            repeats: true   )
        
    }
    @IBAction func memory () {
        let memorytimer = Timer.scheduledTimer(
            timeInterval:0.1,
            target: self,
            selector: #selector(ViewController.move),
            userInfo: nil,
            repeats: true   )
        
        
        
    }
    
    
    
    
    
    
    
    func anime() {
        
        touchView.frame.origin.x = ArrayX[animecount]
        touchView.frame.origin.y = ArrayY[animecount]
        animecount = animecount + 1
        
        
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

