//
//  GameScene.swift
//  Sprike1
//
//  Created by 1234 on 2024/4/8.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let Max_x=930
    let Min_x=120
    let Min_y=80
    let Max_y=1480
    var record:[Int] = []
    
    let step=30
    let player=SKSpriteNode(imageNamed: "player")
    var puppet_name:String=""
    
    
    var WallsLocation:[WallLocation] = []
    var view1 = SKSpriteNode()
    var title=SKLabelNode()
    var close=SKSpriteNode()
    var Finish:Bool=false
    var isMedal:Bool=false
    
    func GetData(_ data:[WallLocation]){
        self.WallsLocation=data
    }
    
    override func didMove(to view: SKView) {
        print("(\(size.width),\(size.height))")
        self.backgroundColor = .white
        player.size=CGSize(width: 60, height: 60)
        let back=SKSpriteNode(imageNamed: "草地")
        back.zPosition = -1
        back.position=CGPoint(x: size.width/2, y: size.height/2)
        back.size=CGSize(width: size.width, height: size.height)
        addChild(back)
        
        let medal_text=SKLabelNode()
        medal_text.text="恭喜你！ 成功解锁\(puppet_name)勋章碎片"
        medal_text.fontName="Arial"
        medal_text.fontSize=40
        medal_text.fontColor = .white
        medal_text.position=CGPoint(x: size.width/2, y: size.height/2-300)
        medal_text.alpha=0
        medal_text.zPosition=2
        medal_text.name="medal_text"
        addChild(medal_text)
        
        let medal_get=SKSpriteNode(imageNamed: "get")
        medal_get.position=CGPoint(x: size.width/2, y: 500)
        medal_get.size=CGSize(width:250, height: 80)
        medal_get.zPosition=2
        medal_get.alpha=0
        medal_get.name="medal_get"
        addChild(medal_get)
        
        let medal_right=SKSpriteNode(imageNamed: puppet_name.prefix(2)+"_right")
        medal_right.position=CGPoint(x: size.width/2+100, y: size.height/2)
        medal_right.size=CGSize(width: 300, height: 500)
        medal_right.zPosition=2
        medal_right.name="medal"
        medal_right.alpha=0
        addChild(medal_right)
        
        
        let map=SKSpriteNode(imageNamed: "background1")
        map.size=CGSize(width:size.width-200, height: 1200)
        map.position=CGPoint(x: size.width/2, y: size.height/2+70)
        map.anchorPoint=CGPoint(x: 0.5, y: 0.5)
        map.zPosition = -1
        map.name="map"
        
        addChild(map)
        
        let ADV=SKLabelNode(text: "已解锁奇遇")
        let ADImg=SKSpriteNode(imageNamed: "unknow")
        let Progress=SKLabelNode()
        ADV.fontName="Arial"
        ADV.fontColor = .black
        ADV.fontSize=60
        ADV.position=CGPoint(x: size.width/2-100, y: 1700)
        ADImg.position=CGPoint(x: size.width/2+90, y: 1730)
        ADImg.size=CGSize(width: 75, height: 75)
        Progress.text=":\(record.count)/5"
        Progress.position=CGPoint(x: size.width/2+190, y: 1700)
        Progress.fontName="Arial"
        Progress.fontColor = .red
        Progress.fontSize=60
        Progress.name="Progress"
        addChild(ADV)
        addChild(ADImg)
        addChild(Progress)
        
        view1=SKSpriteNode(color: .green, size: CGSize(width: 700, height: 900))
        view1.position=CGPoint(x:size.width/2,y:size.height/2+100)
        addChild(view1)
        view1.alpha=0
        view1.zPosition=2
        
        title=SKLabelNode()
        title.fontName="Arial"
        title.fontSize=50
        title.fontColor = .orange
        title.position=CGPoint(x: size.width/2, y: 1500)
        title.alpha=0
        title.zPosition=2
        
        addChild(title)
        let content=SKLabelNode()
        content.position=CGPoint(x: size.width/2, y: 630)
        content.fontSize=22
        content.fontName="Arial"
        content.numberOfLines=0
        content.preferredMaxLayoutWidth=700
        content.name="content"
        content.zPosition=2
        content.alpha=0
        
        addChild(content)
        
        let MedalLabel=SKLabelNode()
        MedalLabel.fontName="Arial"
        MedalLabel.fontSize=40
        MedalLabel.position=CGPoint(x: size.width/2+100, y: size.height/2-100)
        
        close=SKSpriteNode(imageNamed: "close")
        close.position=CGPoint(x:size.width/2, y: 450)
        close.size=CGSize(width: 100, height: 100)
        close.alpha=0
        addChild(close)
        close.name="close"
        close.zPosition=2
        
        let ToAr=SKSpriteNode(color: .gray, size: CGSize(width: 250, height: 70))
        let mask = SKShapeNode(rectOf:ToAr.frame.size)
        let path = UIBezierPath(roundedRect: ToAr.frame, byRoundingCorners: [.topLeft, .topRight,.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 5, height: 5))
            mask.path = path.cgPath
        ToAr.name="ToAr"
        ToAr.position=CGPoint(x: size.width/2, y: 450)
        ToAr.zPosition=2
        ToAr.alpha=0
        addChild(ToAr)
        
        let ARText=SKLabelNode(text: "连接现实")
        ARText.name="ARText"
        ARText.position=CGPoint(x: size.width/2, y: 440)
        ARText.zPosition=2
        ARText.alpha=0
        ARText.fontName="Arial"
        ARText.fontSize=35
        addChild(ARText)
        
        
        player.position=CGPoint(x:395,y:410)
        addChild(player)
        for i in 0..<6{
            let unknow=SKSpriteNode(imageNamed: "unknow")
            unknow.name="unknow\(i+1)"
            unknow.size=CGSize(width: 80, height: 75)
            switch i{
            case 0:
                unknow.position=CGPoint(x: 440, y: 625)
                unknow.name="unknow1"
                break
            case 1:
                unknow.position=CGPoint(x: 280, y: 700)
                unknow.name="unknow2"
                break
            case 2:
                unknow.position=CGPoint(x: 540, y: 988)
                unknow.size=CGSize(width: 80, height: 70)
                unknow.name="unknow3"
                break
            case 3:
                unknow.position=CGPoint(x: 230, y: 1450)
                unknow.name="unknow4"
                break
            case 4:
                unknow.position=CGPoint(x: 400, y: 1520)
                unknow.name="unknow5"
                break
            case 5:
                unknow.position=CGPoint(x: 820, y: 1180)
                unknow.name="unknow6"
                break
            default:
                break
            }
            addChild(unknow)
        }
        
        let LongTapLeft=UILongPressGestureRecognizer(target: self, action: #selector(HandleLeft))
        self.childNode(withName: "left")?.inputView?.addGestureRecognizer(LongTapLeft)
        }
    
    @objc func HandleLeft(ges:UILongPressGestureRecognizer){
        switch ges.state {
                case .began:
                    print("Long press began")
                    // 你可以在这里执行长按开始时的操作
                case .ended:
                    print("Long press ended")
                    // 你可以在这里执行长按结束时的操作
                default:
                    break
                }
        
    }
    
    func ViewToSee(_ x:Int){
        print("View1--\(x)")
        if let Img=(self.childNode(withName: "img")){
            Img.removeFromParent()
        }
        if(x != 3&&record.contains(x)==false){
            record.append(x)
        }
        var imgName=""
        switch x{
        case 1:
            view1.color = .gray
            title.text="解锁一个戏剧 ————《金鳞记》"
            imgName="金鳞记"
            (self.childNode(withName: "content") as! SKLabelNode).text =
            """
            《金鳞记》讲述了书生张珍与金丞相之女牡丹指腹为婚，不幸亲亡家败，只好前往金府投亲。金父见其衣衫褴褛，借口“金家三代不招白女婿”命于碧波潭畔草庐攻读，张珍每于夜深人静，在潭边自叹心事；碧波潭鲤鱼精，为感张珍朝夕之情，于夜间变作牡丹小姐模样，去书房倾诉相思之情。一日金丞相偕夫人游园赏梅，直至月出东方，谯楼二更。张珍闯入园内去赴鲤鱼之约，正巧遇牡丹小姐，欲上前倾叙，小姐惊呼，一口咬定张珍无礼造次，丞相大怒，将张逐出府外。鲤鱼见张珍受屈，忙赶至街坊，向他解释这场误会并与张珍同返故里，途中又被丞相双双捉回。由此真假牡丹，难分皂白。金丞相相请包公断案，龟精亦因受鲤鱼相求，化作假包公往金府一同审案。经过复杂曲折的审问后，真包公亦明知真牡丹嫌贫爱富，假牡丹义重情深，因不愿撤散这对人间美眷，专退不问。金丞相无法，又请张天师捉拿妖精，鲤鱼精守护着张珍边战边退。正值天兵追急，罗网重重的千钧一发之际，幸喜观音出手相救，鲤鱼精为了爱情，宁可丢弃千年道行，也不愿随观音往南海修炼成仙。最后，她忍痛剥下金鳞三片，坠落红尘，与张珍结为百年之好，同甘共苦。
            """
            (self.childNode(withName: "content") as! SKLabelNode).fontSize=24
            break
        case 2:
            imgName="故事"
            view1.color = .green
            title.text="解锁一个故事 ————进驻平城"
            (self.childNode(withName: "content") as! SKLabelNode).text =
            """
            汉高祖刘邦率军进驻平城，被匈奴大军包围。毛顿的妻子毛氏带领强兵来到平城边，伺机攻城。一个多月后，平城的汉军粮草告罄，饿死，没有援军可救。
            
            这个城市处于危险之中，刘邦处于焦虑状态。刘邦的辅导员陈平中尉在走访中发现：茅盾以前是个好色的人。他偷偷地要了花和柳树。

            陈平利用马登的弱点来了解开石的心理状态。他让工匠们做许多漂亮的木偶。每个木偶都有几根丝线。然后他让士兵们每天背着线，引导木偶美女们在城垛上走来走去，跳舞跳舞。

            木偶美女很迷人。他误以为城里有那么多美女。他怕攻克平城后，会选择美人和妾，于是下令退却。就这样，平城的围攻解除了。

            刘邦登基后，认为木偶美女为国家做出了巨大贡献，给每一个木偶美女以妃嫔贵族的称号，并将这些木偶美女珍藏在国库中作为国宝。到汉文帝时，乐府模仿木偶，在宫廷演出，还作为迎宾拜神驱魔的仪式。
            """
            (self.childNode(withName: "content") as! SKLabelNode).fontSize=23
            print((self.childNode(withName: "content") as! SKLabelNode).calculateAccumulatedFrame().size.height)
            break
        case 3:
            let alter=SKLabelNode(text: "抱歉，当前位置无惊喜😓")
            alter.position=CGPoint(x: size.width/2, y: size.height/2)
            alter.fontName="Arial"
            alter.fontColor = .red
            alter.fontSize=50
            let action=SKAction.sequence([
                SKAction.wait(forDuration: 1.5),
                SKAction.fadeOut(withDuration: 0.25)
            ])
            addChild(alter)
            alter.run(action)
            return
        case 4:
            view1.color = .orange
            title.text="解锁一个人物 ————谢发"
            imgName="人物"
            (self.childNode(withName: "content") as! SKLabelNode).text =
            """
            谢发（1908-1966年），家名鸿发，字柏雄，梅州市梅城东山下市角人，是著名的木偶艺术家、梅县木偶剧团（又称梅县民艺线剧团）创始人。创作出许多富有民间艺术的木偶剧，演技臻于炉火纯青，深受群众的喜爱，博得国内外艺术家的赞赏。

            1952年春，谢发在广州与苏联功勋艺术家、莫斯科木偶艺术剧院院长奥布拉兹卓夫进行艺术交流。他表演了提线木偶《化子进城》中的“弄蛇”“舞狮”等绝招，苏联专家看后为之心折，盛赞谢发控线的10个指头灵巧得堪与钢琴家相媲美，并邀请谢发到苏联各大城市表演。

            由于谢发取得卓越的艺术成就，1956年被吸收为中国戏剧家协会会员，嗣后又被评为高级知识分子。
            """
            (self.childNode(withName: "content") as! SKLabelNode).fontSize=28
            break
        case 5:
            if((self.childNode(withName:"unknow5") as! SKSpriteNode).alpha != 1&&isMedal == false){
                let alter=SKLabelNode(text: "糟糕，你有其它奇遇未解锁😡")
                alter.position=CGPoint(x: size.width/2, y: size.height/2)
                alter.fontName="Arial"
                alter.fontColor = .red
                alter.fontSize=50
                let action=SKAction.sequence([
                    SKAction.wait(forDuration: 1.5),
                    SKAction.fadeOut(withDuration: 0.25)
                ])
                addChild(alter)
                alter.run(action)
                return
            }
            else{
                view1.color = .red
                Finish = !Finish
                title.text="恭喜解锁最后一个奇遇 ————《火焰山》"
                imgName="火焰山"
                (self.childNode(withName: "content") as! SKLabelNode).text =
            """
           唐僧师徒取经途中，被火焰山阻断去路。孙悟空到芭蕉洞借扇灭火，被铁扇公主用宝扇扇到海外仙山。幸遇灵石仙翁赠“定风珠”相助，又回到芭蕉洞施计钻入铁扇公主腹中，逼其交出宝扇。铁扇公主借给一把假扇，使孙悟空、猪八戒灭火不成，反遭烈焰烧灼。孙悟空又潜入碧波潭，盗走金睛兽，变身作牛魔王，重返芭蕉洞骗得宝扇。牛魔王恼恨交加，与孙悟空各显神通，大战一场。牛魔王战败降服，铁扇公主无奈献扇灭火。唐僧师徒翻越火焰山，再登取经之路。
           """
                (self.childNode(withName: "content") as! SKLabelNode).fontSize=30
            }
            break
        case 6:
            view1.color = .black
            title.text="解锁一个木偶 ————钟馗"
            imgName="木偶"
            (self.childNode(withName: "content") as! SKLabelNode).text =
            """
            传说他是唐初终南山人，生得豹头环眼，铁面虬鬓，相貌奇丑；然而他却是一个才华横溢、满腹经纶的风流人物。他平素为人刚直、不惧邪祟。唐玄宗登基那年，他赴长安应试，作《瀛州待宴》五篇，被主考官誉称“奇才”，取为贡士之首。可是殿试时，奸相卢杞竟以貌取人，迭进谗言，使钟馗落选。钟馗一怒之下，撞殿柱而死，震惊朝野。德宗下昭封钟馗为“驱魔大神”，遍行天下“斩妖驱邪”；并用状元官职殡葬。传说唐明皇睡梦中见一小鬼偷了杨贵妃的紫香囊和唐明皇的玉笛，绕殿而奔，这时有一大鬼捉住小鬼并把他吃了。大鬼相貌奇丑无比，头戴破纱帽，身穿蓝袍、角带、足踏朝靴，自称是终南山落第进士，因科举不中，撞死于阶前。他对唐明皇说：“誓与陛下除尽天下之妖孽。”唐明惊醒后得病。病愈后下诏画师吴道子按照梦境绘成《钟馗捉鬼图》批告天下以祛邪魅佑平安。吴道子挥笔而就，原来吴道子也做了个同样的梦，所以“恍若有睹”，因而一蹴而就。
            """
            (self.childNode(withName: "content") as! SKLabelNode).fontSize=25
            break
        default:
            break
        }
        print(imgName)
        let img=SKSpriteNode(imageNamed: imgName)
        img.inputView?.contentMode = .scaleAspectFit
        img.position=CGPoint(x: size.width/2, y: 1300)
        img.size=CGSize(width: 700, height: 300)
        img.alpha=0
        img.name="img"
        img.zPosition=2
        addChild(img)
        if let t=(self.childNode(withName: "content") as? SKLabelNode){
            let height=t.calculateAccumulatedFrame().size.height//计算文本高度
            t.position.y=630+500-height
        }
                
        // 设置大小与场景相同
        self.childNode(withName: "map")?.alpha=0.6
        self.childNode(withName: "unknow1")?.alpha=0
        self.childNode(withName: "unknow2")?.alpha=0
        self.childNode(withName: "unknow3")?.alpha=0
        self.childNode(withName: "unknow4")?.alpha=0
        self.childNode(withName: "unknow5")?.alpha=0
        self.childNode(withName: "unknow6")?.alpha=0

        let action=SKAction.fadeAlpha(to: 1.0, duration: 1.3)
        let waitAction = SKAction.wait(forDuration: 1.0) // 等待1秒
        let fadeSequence = SKAction.sequence([waitAction, action])
         
        // 将渐现动作放入组动作中，并在场景中运行
        let groupAction = SKAction.group([fadeSequence])
        if(x==5){
            print(Finish)
            isFsh[puppet_name.prefix(2)+"_right"]=true
            if(isMedal==false){
                isMedal = !isMedal
                self.childNode(withName: "medal")?.run(action)
//                close.run(action)
                self.childNode(withName: "medal_text")?.run(action)
                self.childNode(withName: "medal_get")?.run(action)
                return
            }
            else{
                self.childNode(withName: "ToAr")?.run(action)
                self.childNode(withName: "ARText")?.run(action)
            }
            
        }else{
            print("Finish=\(Finish),x=\(x)")
            close.run(action)
        }
        view1.run(action)
        title.run(action)
        self.childNode(withName: "img")?.run(action)
        self.childNode(withName: "content")?.run(action)
        (self.childNode(withName: "Progress") as! SKLabelNode).text="\(record.count)/5"
        self.childNode(withName: "ADV")
    }
    
    func ViewToDiss(){
        let action=SKAction.fadeAlpha(to: 0, duration: 0.8)
        
        view1.run(action)
        close.run(action)
        title.run(action)
        self.childNode(withName:"img")?.run(action)
        self.childNode(withName: "content")?.run(action)
        self.childNode(withName: "map")?.alpha=1
        for i in 1..<7{
            if(!record.contains(i)){
                self.childNode(withName: "unknow\(i)")?.alpha=1
            }
        }
    }
    
    func Diss2(){
        self.childNode(withName: "medal")?.alpha=0
        self.childNode(withName: "medal_text")?.alpha=0
        self.childNode(withName: "medal_get")?.alpha=0
    }
    
         
       
    override func update(_ currentTime: TimeInterval) {
        //放不断更新的内容
        // Called before each frame is rendered
        if(record.count != 4){
            self.childNode(withName:"unknow5")?.alpha=0.2
        }else{
            self.childNode(withName: "unknow5")?.alpha=1
        }
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch=touches.first{
            let loc=touch.location(in: self)
            if let node=atPoint(loc) as? SKSpriteNode{
                switch node.name{
                case "unknow1":
                    print("unknow1")
                    ViewToSee(1)
                    break
                case "unknow2":
                    print("unknow2")
                    ViewToSee(2)
                    break
                case "unknow3":
                    
                    print("unknow3")
                    ViewToSee(3)
//                    vc.str="unknow3"
                    break
                case "unknow4":
                    print("unknow4")
                    ViewToSee(4)
                    break
                case "unknow5":
                    print("unknow5")
                    ViewToSee(5)
                    break
                case "unknow6":
                    print("unknow6")
                    ViewToSee(6)
                    break
                case "close":
                    print("close")
                    ViewToDiss()
                case "ToAr":
                
                    break
                case "medal_get":
                    Diss2()
                    ViewToSee(5)
                    break
                default:
                    break
                
                }
                
                print("(\(self.player.position.x),\(self.player.position.y))")
            }
        }
        
        func captureScreenshot(vc: UIViewController) -> UIImage? {
            // 创建一个与当前屏幕尺寸相同的图形上下文
            let format = UIGraphicsImageRendererFormat()
            format.scale = UIScreen.main.scale
            let renderer = UIGraphicsImageRenderer(size: UIScreen.main.bounds.size, format: format)
            
            // 在图形上下文中绘制当前页面内容
            let image = renderer.image { context in
                let currentView = vc.view!
                currentView.drawHierarchy(in: currentView.bounds, afterScreenUpdates: true)
            }
            return image
        }
    }
    
}
