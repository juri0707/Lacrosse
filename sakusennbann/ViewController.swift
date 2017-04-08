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
//    var ArrayX = [CGFloat]()
//    var ArrayY = [CGFloat]()
    var animecount = 0
    var saiseitimer = Timer()
    var memorytimer = Timer()
    var saisei2timer = Timer()
    var Gotimer = Timer()
    var kosu = 0
    var motonoitiX = [CGFloat]()
    var motonoitiY = [CGFloat]()
    let alert2:UIAlertController = UIAlertController(title:"記憶をし直します",message:"再度記憶ボタンを押して始めてください", preferredStyle: .alert)
    let alert3:UIAlertController = UIAlertController(title:"繰り返し",message:"もう一度再生ボタンを押してください", preferredStyle: .alert)
    @IBOutlet var mySlider: UISlider!
    var mimimumS = 0
    var maximumS = [Float]()
    var imageIndex: Int = 0
    var redtag: Int = 0
    var bluetag: Int = 0
    var Scount = 0.0
    var Nokori = [Float]()
    var tomattatoko = 0
    var moveTag: Int = 0
    
    //背景画像を表示させるImageView
    @IBOutlet var haikeiImageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
    }
        func move() {
        //座標を読み込む
        print("memoryタイマーは動いてます")
        touchView.touchArrayX1.append(touchView.frame.origin.x)
        print("配列1は",touchView.touchArrayX1)
        touchView.touchArrayY1.append(touchView.frame.origin.y)
        print("配列1は",touchView.touchArrayY1)
            motonoitiX = [touchView.touchArrayX1[0]]
            motonoitiY = [touchView.touchArrayY1[0]]

    }
    func move2() {
        //座標を読み込む
        print("memoryタイマーは動いてます")
        touchView.touchArrayX2.append(touchView.frame.origin.x)
        print("配列２は",touchView.touchArrayX2)
        touchView.touchArrayY2.append(touchView.frame.origin.y)
        print("配列２は",touchView.touchArrayY2)
        motonoitiX = [touchView.touchArrayX2[0]]
        motonoitiY = [touchView.touchArrayY2[0]]
        
    }

    @IBAction func stop() {
        if moveTag == 1 {
        if memorytimer.isValid {
            //タイマーが動作していたら止める
            memorytimer.invalidate()
            print("memoryタイマーが止まりました")
            kosu = touchView.touchArrayX1.count
            print("要素の個数は",kosu)
            mySlider.minimumValue = 0
            mySlider.maximumValue = Float(touchView.touchArrayX1.count / 10)
            print("スライダーの最大値が",mySlider.maximumValue,"になりました")
            mySlider.value = 0
            print(mySlider.value)
        }
            
        }else if moveTag == 2 {
            if memorytimer.isValid {
                //タイマーが動作していたら止める
                memorytimer.invalidate()
                print("memoryタイマーが止まりました")
                kosu = touchView.touchArrayX2.count
                print("要素の個数は",kosu)
                mySlider.minimumValue = 0
                mySlider.maximumValue = Float(touchView.touchArrayX2.count / 10)
                print("スライダーの最大値が",mySlider.maximumValue,"になりました")
                mySlider.value = 0
                print(mySlider.value)
            }
 
        }
    }
    
    @IBAction func teishiandgo() {

        if saiseitimer.isValid {
            saiseitimer.invalidate()
            print("再生タイマーが一時停止")
            print(touchView.touchArrayX1)
            saisei2timer.invalidate()
            print("スライダーが一時停止")
            print("スライダーの最大値は",mySlider.maximumValue)
            print("何秒たったか",Scount)
            tomattatoko = Int(mySlider.value)
            print("止まったとこの値は",tomattatoko)
        }else{
            Gotimer = Timer.scheduledTimer(
                timeInterval:0.1,
                target: self,
                selector: #selector(ViewController.slider),
                userInfo: nil,
                repeats: true   )
            Gotimer = Timer.scheduledTimer(
                timeInterval:0.1,
                target: self,
                selector: #selector(ViewController.anime1),
                userInfo: nil,
                repeats: true   )
        }
    }
    //次押したら
    //timer.maximum - timer.value = 残りの秒数 = var nokori
    //5 - 2 = 3つまり残り三秒タイマーを動かす
    //最大値は変わらず５で、現在値は2
    //タイマーの秒数を制限 = nokori
    //メソッドを作成　nokori
    //noko riメソッドの何かがnokoriと同値になったら、タイマーストップ
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
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressView(sender:)))  //Swift3
        longPressGesture.minimumPressDuration = 1  //1秒間以上押された場合にロングプレスとする
        longPressGesture.allowableMovement = 30  //ロングプレスを判定する指が動いていい範囲、単位はpx
        
        touchView.addGestureRecognizer(longPressGesture)
        //タップを定義
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(ViewController.tap(_:)))
        touchView.addGestureRecognizer(tapGesture)
        //ダブルタップを定義
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.doubleTapAction(_:)))

        doubleTapGesture.numberOfTapsRequired = 2
        touchView.addGestureRecognizer(doubleTapGesture)
        

        
        
        
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
        var touchArrayX1 = [CGFloat]()
        var touchArrayY1 = [CGFloat]()
        var touchArrayX2 = [CGFloat]()
        var touchArrayY2 = [CGFloat]()
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
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
    
       //タップ時に実行される
    func tap(_ sender: UITapGestureRecognizer){
        print("tapped!")
        
        
    }
    
    //ダブルタップ時に実行される
    func doubleTapAction(_ sender: UITapGestureRecognizer) {
        print("doubletapped!")
        touchView.tag = moveTag
        moveTag = moveTag + 1
        print("動かそうとしているのは",moveTag)

    }
    

        /// ロングプレス時に実行される
    func longPressView(sender: UILongPressGestureRecognizer) {
        print("Long Press")
        touchView = sender.view as! ViewController.TouchView
                //アラートを出す
        let alert1:UIAlertController = UIAlertController(title:"削除",message:"選択した丸を削除します。", preferredStyle: .alert)
        
        
        //削除ボタン
        alert1.addAction(
            UIAlertAction(
                title:"OK",
                style: UIAlertActionStyle.default,
                handler: {action in
                    //ボタンが押された時の動作
                    NSLog("OKボタンが押されました")
                    sender.view?.removeFromSuperview()
                    self.moveTag = self.moveTag - 1
                    print(self.moveTag)
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
        present(alert1, animated: true, completion: nil)
        
        
        func store() {
        }
        
    }
    
    
    @IBAction func tsuika () {
        
        
        
    }
    //
    @IBAction func saisei() {
        print("再生ボタンが押されました")
        print("現在の位置は",mySlider.value)
        animecount = 0
        print("0から数えます")
        if moveTag == 1 {
        if Scount == 0 {
            print("Scountは0です")
        saiseitimer = Timer.scheduledTimer(
            timeInterval:0.1,
            target: self,
            selector: #selector(ViewController.anime1),
            userInfo: nil,
            repeats: true   )
        
        saisei2timer = Timer.scheduledTimer(
            timeInterval:0.1,
            target: self,
            selector: #selector(ViewController.slider),
            userInfo: nil,
            repeats: true   )
        }else{
            print("Scountは0ではありませんもう一度押して")
            Scount = 0
            }
        }else if moveTag == 2 {
            if Scount == 0 {
                print("Scountは0です")
                saiseitimer = Timer.scheduledTimer(
                    timeInterval:0.1,
                    target: self,
                    selector: #selector(ViewController.anime2),
                    userInfo: nil,
                    repeats: true   )
                
                saisei2timer = Timer.scheduledTimer(
                    timeInterval:0.1,
                    target: self,
                    selector: #selector(getter: ViewController.mySlider),
                    userInfo: nil,
                    repeats: true   )
            }else{
                print("Scountは0ではありませんもう一度押して")
                Scount = 0
            }

            
        
    }else if moveTag == 3 {
    
    
        }else if moveTag == 4 {
    
            
        }else if moveTag == 5 {
    

        }else if moveTag == 6 {
    

        }else if moveTag == 7 {
    

        }else if moveTag == 8 {
    
    }


    }

    @IBAction func memory () {
        if self.moveTag == 1 {
        
        if touchView.touchArrayX1.count == 0, touchView.touchArrayY1.count == 0{
            memorytimer = Timer.scheduledTimer(
            timeInterval:0.1,
            target: self,
            selector: #selector(ViewController.move),
            userInfo: nil,
            repeats: true   )
        }else{
            animecount = 0
            touchView.touchArrayX1.removeAll()
            print(touchView.touchArrayX1.count)
            touchView.touchArrayY1.removeAll()
            print(touchView.touchArrayY1.count)
            //OKボタン
            alert2.addAction(
                UIAlertAction(
                    title:"OK",
                    style: UIAlertActionStyle.default,
                    handler: {action in
                        //ボタンが押された時の動作
                        NSLog("OKボタンが押されました")
                        self.touchView.frame.origin.y = self.motonoitiY[0]
                        self.touchView.frame.origin.x = self.motonoitiX[0]
            }
            )
            )
            present(alert2, animated: true, completion: nil)
        }
        }else if self.moveTag == 2 {
            if touchView.touchArrayX2.count == 0, touchView.touchArrayY2.count == 0{
                memorytimer = Timer.scheduledTimer(
                    timeInterval:0.1,
                    target: self,
                    selector: #selector(ViewController.move2),
                    userInfo: nil,
                    repeats: true   )
            }else{
                animecount = 0
                touchView.touchArrayX2.removeAll()
                print(touchView.touchArrayX2.count)
                touchView.touchArrayY2.removeAll()
                print(touchView.touchArrayY2.count)
                //OKボタン
                alert2.addAction(
                    UIAlertAction(
                        title:"OK",
                        style: UIAlertActionStyle.default,
                        handler: {action in
                            //ボタンが押された時の動作
                            NSLog("OKボタンが押されました")
                            self.touchView.frame.origin.y = self.motonoitiY[0]
                            self.touchView.frame.origin.x = self.motonoitiX[0]
                    }
                    )
                )
                present(alert2, animated: true, completion: nil)
            }

        }
    }

    //再生する。再生し終わったら再生タイマー止める
        func anime1() {
        if animecount < touchView.touchArrayX1.count {
            touchView.frame.origin.x = touchView.touchArrayX1[animecount]
            touchView.frame.origin.y = touchView.touchArrayY1[animecount]
            animecount = animecount + 1
            print("再生タイマーがスタート")
        } else {
            saiseitimer.invalidate()
            print("再生タイマーストップ")
        }
            
            
            
    }
    func anime2() {
        
        if animecount < touchView.touchArrayX2.count {
            touchView.frame.origin.x = touchView.touchArrayX2[animecount]
            touchView.frame.origin.y = touchView.touchArrayY2[animecount]
            animecount = animecount + 1
            print("再生タイマーがスタート")
        } else {
            saiseitimer.invalidate()
            print("再生タイマーストップ")
        }
    }
    //スライダーのタイマー(saisei2timer)のメソッド
    func slider() {
        Scount = Scount + 0.1
        mySlider.value = Float(Int(Scount))
        print(mySlider.value)
        if mySlider.value == Float(mySlider.maximumValue) {
            saisei2timer.invalidate()
            print("再生終了")
        }

        
        
            }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

