//
//  RechargeView.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-6.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "RechargeView.h"
#import "AppDelegate.h"
#import "UIButton+Bootstrap.h"
#import "PayAddModel.h"
#import "BuyVipView.h"

#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"
#import "AlipayPrepareSecurePayModel.h"
#import "AlixLibService.h"

@implementation RechargeView

-(id)initMy{
    if (self=[super init]) {
        
        
        rect=[[UIScreen mainScreen] bounds];
        _isCardRecharge = NO;
        lastCLickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIViewController * main = [AppDelegate App].tabBarController;
        _myView = [[UIView alloc] init];
        _myView.frame = main.view.frame;
        _myView.backgroundColor=[UIColor blackColor];
        _myView.alpha=0;
        _myView.userInteractionEnabled=YES;
        
        backgroundImageView = [[UIImageView alloc]init];
        backgroundImageView.image = [UIImage imageNamed:@"ConfirmationBuy.png"];
        [self addSubview:backgroundImageView];
        
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditingself)];
        tap.numberOfTapsRequired=1;
//        [_myView addGestureRecognizer:tap];
        [self addGestureRecognizer:tap];
//        rect.size.height - 400
        self.frame=CGRectMake(72 , 303, 552, rect.size.width- 350);
        tmpRect=self.frame;
        
        self.backgroundColor=[UIColor whiteColor];
        
        UIView*heatView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 552, 80)];
        heatView.backgroundColor=[UIColor clearColor];
        
        dismissBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [dismissBtn setImage:[UIImage imageNamed:@"X.png"] forState:UIControlStateNormal];
        dismissBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [dismissBtn addTarget:self  action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        dismissBtn.backgroundColor=[UIColor clearColor];
        dismissBtn.frame=CGRectMake(30, 30, 30, 30);
        dismissBtn.hidden = NO;
        [heatView addSubview:dismissBtn];
        
        
        CGRect rect1 = heatView.frame;
        titleLabe=[[UILabel alloc]initWithFrame:rect1];
        titleLabe.textColor=[UIColor blackColor];
        titleLabe.text=@"我要充值";
        titleLabe.font=[UIFont boldSystemFontOfSize:HEADVIEW_TITLESIZE];
        titleLabe.alpha = HEADVIEW_TITLE_ALPHA;
        titleLabe.textAlignment=NSTextAlignmentCenter;
        titleLabe.backgroundColor=[UIColor clearColor];
        [heatView addSubview:titleLabe];
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(30, 30, 30, 30);
        [backBtn setImage:[UIImage imageNamed:@"返回2.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(dismissSucceedView) forControlEvents:UIControlEventTouchUpInside];
        [heatView addSubview:backBtn];
        backBtn.hidden = YES;
        
//        UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 5, 20)];
//        view1.backgroundColor = [Commonality colorFromHexRGB:@"ef3363"];
//        [self addSubview:view1];
//        
//        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 80, 20)];
//        lab.textColor = [Commonality colorFromHexRGB:@"ef3363"];
//        lab.text = @"点卡充值";
//        lab.font = [UIFont boldSystemFontOfSize:17];
//        lab.backgroundColor = [UIColor clearColor];
//        [self addSubview:lab];
//        
//        UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(115, 110, rect.size.height - 400 -160, 1)];
//        view2.backgroundColor = [UIColor blackColor];
//        view2.alpha = 0.2;
//        [self addSubview:view2];
        
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 81.5, self.frame.size.width, 44.5)];
        headView.backgroundColor = [UIColor whiteColor];
        [self addSubview:headView];
        
        cardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cardBtn.frame = CGRectMake(0, 0, self.frame.size.width/2, 44.5);
        cardBtn.backgroundColor = [UIColor clearColor];
        [cardBtn setTitle:@"点卡充值" forState:UIControlStateNormal];
        [cardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cardBtn.tag = 506;
        cardBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        cardBtn.alpha = 0.6;
        [cardBtn addTarget:self action:@selector(payType:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:cardBtn];
        
        _indicator = [[UIView alloc] initWithFrame:CGRectMake(0, 41.5, self.frame.size.width/2, 3)];
        _indicator.backgroundColor = [UIColor redColor];
        [headView addSubview:_indicator];
        
        alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        alipayBtn.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, 44.5);
        alipayBtn.backgroundColor = [UIColor clearColor];
        [alipayBtn setTitle:@"支付宝充值" forState:UIControlStateNormal];
        [alipayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        alipayBtn.tag = 507;
        alipayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        alipayBtn.alpha = 0.6;
        [alipayBtn addTarget:self action:@selector(payType:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:alipayBtn];
        
        
        
        
        JYTextField * numBerFiled = [[JYTextField alloc]initWithFrame:CGRectMake((rect.size.height - 400)/2-175 - 30, 182, 350, 51)
                                                          cornerRadio:6
                                                          borderColor:[Commonality colorFromHexRGB:@"c3c3c3"]
                                                          borderWidth:0.5
                                                           lightColor:nil
                                                            lightSize:0
                                                     lightBorderColor:nil];
        [numBerFiled setPlaceholder:@"请输入点卡密码"];
        numBerFiled.backgroundColor = [Commonality colorFromHexRGB:@"f0f0f0"];
        numBerFiled.tag = 600;
        numBerFiled.delegate = self;
        [self addSubview:numBerFiled];
        
        
        buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buyBtn.frame = CGRectMake((rect.size.height - 400)/2-175 - 30, 247, 350, 51);
        [buyBtn setTitle:@"确定" forState:UIControlStateNormal];
        [buyBtn addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
        buyBtn.backgroundColor=color_4;
        [buyBtn childrenBtnStyleForBtn:buyBtn];
        UIView * btnBackView = [Commonality makeButtonShadowViewWhitbtn:buyBtn];
        [self addSubview:btnBackView];
        [self addSubview:_myView];
        [self addSubview:heatView];
        
        [Commonality setImgViewStyle:self];
        self.layer.cornerRadius = 5;
//        rect.size.height - 400
        
        
        
        paySucceedView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 552, 230)];
        paySucceedView.backgroundColor = [Commonality colorFromHexRGB:@"ef3363"];
        [self addSubview:paySucceedView];
        
        UIImageView * imageView= [[UIImageView alloc] initWithFrame:CGRectMake((552)/2-115, 60, 40, 40)];
        imageView.image = [UIImage imageNamed:@"ok2.png"];
        imageView.backgroundColor = [UIColor clearColor];
        [paySucceedView addSubview:imageView];
        
        imageView= [[UIImageView alloc] initWithFrame:CGRectMake(80, 55, 40, 40)];
        imageView.image = [UIImage imageNamed:@"radio.png"];
        imageView.backgroundColor = [UIColor clearColor];
        [paySucceedView addSubview:imageView];
        
        UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 552, 50)];
        lab1.text = @"充值成功!";
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.textColor = [UIColor whiteColor];
        lab1.font = [UIFont boldSystemFontOfSize:40];
        lab1.backgroundColor = [UIColor clearColor];
        [paySucceedView addSubview:lab1];
        
        
        pointsLab = [[UILabel alloc] initWithFrame:CGRectMake(190, 130, rect.size.height - 400, 30)];
        pointsLab.textColor = [UIColor whiteColor];
        pointsLab.textAlignment = NSTextAlignmentLeft;
        pointsLab.font = [UIFont boldSystemFontOfSize:15];
        pointsLab.text = @"wat5etyet";
        pointsLab.alpha = 0.8;
        pointsLab.backgroundColor = [UIColor clearColor];
        [paySucceedView addSubview:pointsLab];
        
        UIImageView * imv = [[UIImageView alloc] initWithFrame:CGRectMake(552 - 80 - 50- 50, 40, 150, 150)];
        imv.image = [UIImage imageNamed:@"ok.png"];
        imv.backgroundColor = [UIColor clearColor];
        [paySucceedView addSubview:imv];
        paySucceedView.hidden = YES;
        
        alipayView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.frame.origin.y + 44.5 + 29, headView.frame.size.width, 354 - headView.frame.origin.y - 44.5 - 32)];
        alipayView.backgroundColor = [UIColor whiteColor];
        [self addSubview:alipayView];
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, headView.frame.size.width, 354 - headView.frame.origin.y - 44.5 - 32 - 47.5 - 20)];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        myTableView.backgroundColor = self.backgroundColor;
        myTableView.scrollEnabled = NO;
        [alipayView addSubview:myTableView];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(25, alipayView.frame.size.height - 60, 50, 30)];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = @"总价:";
        lab.alpha = alpha_4;
        lab.font = font_5;
        lab.textColor = [UIColor blackColor];
        [alipayView addSubview:lab];
        
        pointLab = [[UILabel alloc] initWithFrame:CGRectMake(80, alipayView.frame.size.height - 65, 180, 40)];
        pointLab.backgroundColor = [UIColor clearColor];
        pointLab.alpha = 1;
        pointLab.font = font_8;
        pointLab.textColor = color_4;
        [alipayView addSubview:pointLab];
        
        UIButton * aliPayBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        aliPayBtn1.frame = CGRectMake(alipayView.frame.size.width - 45 - 130, alipayView.frame.size.height - 75, 130, 51);
//        [aliPayBtn1 redStyle];
        aliPayBtn1.backgroundColor = color_4;
        [aliPayBtn1 childrenBtnStyleForBtn:aliPayBtn1];
        UIView * viewq = [Commonality makeButtonShadowViewWhitbtn:aliPayBtn1];
        [aliPayBtn1 setTitle:@"付款" forState:UIControlStateNormal];
        [aliPayBtn1 addTarget:self action:@selector(aliPay) forControlEvents:UIControlEventTouchUpInside];
        [aliPayBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [alipayView addSubview:viewq];
        alipayView.hidden = YES;
    }
    return self;
}

-(id)initMyWithFrame:(CGRect )newRect
{
    if (self=[super init]) {
        
        
        rect=[[UIScreen mainScreen] bounds];
        _isCardRecharge = NO;
        lastCLickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.frame=CGRectMake(0 , 0, newRect.size.width, newRect.size.height);
        tmpRect=self.frame;
        
        self.backgroundColor=color_21;
        
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        headView.backgroundColor = [Commonality colorFromHexRGB:@"f1f1f1"];
        [self addSubview:headView];
        
        
        cardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cardBtn.frame = CGRectMake(0, 0, self.frame.size.width/2, 50);
        cardBtn.backgroundColor = color_21;
        [cardBtn setTitle:@"点卡充值" forState:UIControlStateNormal];
        [cardBtn setTitleColor:color_2 forState:UIControlStateNormal];
        cardBtn.tag = 506;
        cardBtn.titleLabel.font = font_5;
        cardBtn.alpha = 1;
        [cardBtn addTarget:self action:@selector(payType:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:cardBtn];
        
        _indicator = [[UIView alloc] initWithFrame:CGRectMake(0, 41.5, self.frame.size.width/2, 3)];
        _indicator.backgroundColor = [UIColor redColor];
        [headView addSubview:_indicator];
        _indicator.hidden = YES;
        
        alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        alipayBtn.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, 50);
        alipayBtn.backgroundColor = color_18;
        [alipayBtn setTitle:@"支付宝充值" forState:UIControlStateNormal];
        [alipayBtn setTitleColor:color_2 forState:UIControlStateNormal];
        alipayBtn.tag = 507;
        alipayBtn.titleLabel.font = font_5;
        alipayBtn.alpha = 1;
        [alipayBtn addTarget:self action:@selector(payType:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:alipayBtn];        
        
        JYTextField * numBerFiled = [[JYTextField alloc]initWithFrame:CGRectMake(newRect.size.width/2 - 208.5, 100, 417, 51)
                                                          cornerRadio:6
                                                          borderColor:[Commonality colorFromHexRGB:@"c3c3c3"]
                                                          borderWidth:0.5
                                                           lightColor:nil
                                                            lightSize:0
                                                     lightBorderColor:nil];
        [numBerFiled setPlaceholder:@"请输入点卡密码"];
        numBerFiled.backgroundColor = [UIColor whiteColor];
        numBerFiled.tag = 600;
        numBerFiled.delegate = self;
        [self addSubview:numBerFiled];
        
        
        buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buyBtn.frame = CGRectMake(newRect.size.width/2 - 208.5, 175, 417, 51);
        [buyBtn setTitle:@"确定" forState:UIControlStateNormal];
        [buyBtn addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
        buyBtn.backgroundColor=color_4;
        [buyBtn childrenBtnStyleForBtn:buyBtn];
        UIView * btnBackView = [Commonality makeButtonShadowViewWhitbtn:buyBtn];
        [self addSubview:btnBackView];
        

       
        paySucceedView = [[UIView alloc] initWithFrame:CGRectMake(80, 139 + 50, 552, 230)];
//        paySucceedView.backgroundColor = [Commonality colorFromHexRGB:@"ef3363"];
        paySucceedView.backgroundColor = [UIColor clearColor];
        [self addSubview:paySucceedView];
        
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, -50, paySucceedView.frame.size.width, paySucceedView.frame.size.height + 100)];
        imageView1.image = [UIImage imageNamed:@"Success_bg.png"];
        [paySucceedView addSubview:imageView1];
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(30, 30, 30, 30);
        [backBtn setImage:[UIImage imageNamed:@"返回2.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(dismissSucceedView) forControlEvents:UIControlEventTouchUpInside];
        [imageView1 addSubview:backBtn];
        backBtn.hidden = YES;
        
        UIButton * rechargeButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 20, 70, 30)];
        rechargeButton.backgroundColor = [UIColor clearColor];
        rechargeButton.titleLabel.font = font_3;
        rechargeButton.titleLabel.textColor = [UIColor whiteColor];
        rechargeButton.alpha = alpha_4;
        rechargeButton.titleLabel.text = @"再充一次";
        [rechargeButton addTarget:self action:@selector(rechargeButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [imageView1 addSubview:rechargeButton];
        imageView1.userInteractionEnabled = YES;
        
        
        UIImageView * imageView= [[UIImageView alloc] initWithFrame:CGRectMake((552)/2-115, 60, 40, 40)];
        imageView.image = [UIImage imageNamed:@"ok2.png"];
        imageView.backgroundColor = [UIColor clearColor];
        [paySucceedView addSubview:imageView];
        
        imageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, 40, 40)];
        imageView.image = [UIImage imageNamed:@"radio.png"];
        imageView.backgroundColor = [UIColor clearColor];
        [paySucceedView addSubview:imageView];
        
        UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 552, 50)];
        lab1.text = @"充值成功!";
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.textColor = [UIColor whiteColor];
        lab1.font = [UIFont boldSystemFontOfSize:40];
        lab1.backgroundColor = [UIColor clearColor];
        [paySucceedView addSubview:lab1];
        
        
        pointsLab = [[UILabel alloc] initWithFrame:CGRectMake(190, 130, rect.size.height - 400, 30)];
        pointsLab.textColor = [UIColor whiteColor];
        pointsLab.textAlignment = NSTextAlignmentLeft;
        pointsLab.font = [UIFont boldSystemFontOfSize:15];
        pointsLab.text = @"wat5etyet";
        pointsLab.alpha = 0.8;
        pointsLab.backgroundColor = [UIColor clearColor];
        [paySucceedView addSubview:pointsLab];
        
//        UIImageView * imv = [[UIImageView alloc] initWithFrame:CGRectMake(552 - 80 - 50- 50, 40, 150, 150)];
//        imv.image = [UIImage imageNamed:@"ok.png"];
//        imv.backgroundColor = [UIColor clearColor];
//        [paySucceedView addSubview:imv];
        
        paySucceedBagegroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, newRect.size.width, newRect.size.height)];
        paySucceedBagegroundView.backgroundColor = color_21;
        
        
        [paySucceedBagegroundView addSubview:paySucceedView];
        
        paySucceedBagegroundView.hidden = YES;
        [self addSubview:paySucceedBagegroundView];
        
        alipayView = [[UIView alloc] initWithFrame:CGRectMake(90, headView.frame.origin.y + 44.5 + 29 + 20, headView.frame.size.width - 180, 354 - headView.frame.origin.y - 44.5 - 32)];
        alipayView.backgroundColor = color_21;
        [self addSubview:alipayView];
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, alipayView.frame.size.width, 354 - headView.frame.origin.y - 44.5 - 32 - 47.5 - 20)];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        myTableView.backgroundColor = [UIColor clearColor];
        myTableView.scrollEnabled = NO;
        [alipayView addSubview:myTableView];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(25, alipayView.frame.size.height - 60, 50, 30)];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = @"总价:";
        lab.alpha = alpha_4;
        lab.font = font_5;
        lab.textColor = [UIColor blackColor];
        [alipayView addSubview:lab];
        
        pointLab = [[UILabel alloc] initWithFrame:CGRectMake(80, alipayView.frame.size.height - 65, 180, 40)];
        pointLab.backgroundColor = [UIColor clearColor];
        pointLab.alpha = 1;
        pointLab.font = font_8;
        pointLab.textColor = color_4;
        [alipayView addSubview:pointLab];
        
        UIButton * aliPayBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        aliPayBtn1.frame = CGRectMake(alipayView.frame.size.width - 45 - 130, alipayView.frame.size.height - 75, 130, 51);
//        [aliPayBtn1 redStyle];
        aliPayBtn1.backgroundColor = color_4;
        [aliPayBtn1 childrenBtnStyleForBtn:aliPayBtn1];
        UIView * viewq = [Commonality makeButtonShadowViewWhitbtn:aliPayBtn1];
        
        [aliPayBtn1 setTitle:@"付款" forState:UIControlStateNormal];
        [aliPayBtn1 addTarget:self action:@selector(aliPay) forControlEvents:UIControlEventTouchUpInside];
        [aliPayBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [alipayView addSubview:viewq];
        alipayView.hidden = YES;
    }
    return self;
}



-(void)aliPay
{
    if (customPriceField.isEditing) {
        [customPriceField resignFirstResponder];
    }
    AppPointModel * pointModel;
    if (lastCLickBtn) {
        pointModel = [pointsModel.list objectAtIndex:lastCLickBtn.tag - 2000];
    }else{
        pointModel = [pointsModel.list objectAtIndex:3];
    }
    
    if (pointModel.price) {
        [HttpRequest AlipayPrepareSecurePayRequestToken:[AppDelegate App].personModel.tokenid price:pointModel.price delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }else{
        [Commonality showErrorMsg:self type:0 msg:@"请输入有效金额"];
    }
}

//支付宝
-(void)prepareSecurePay
{
    NSString *appScheme = @"ivmalliPadyouyoumaoApp";
    NSString* orderInfo = [self getOrderInfo];
    NSString* signedStr = [self doRsa:orderInfo];
    
    NSLog(@"%@",signedStr);
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
	
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:@selector(paymentResult:) target:self];
}

-(NSString*)getOrderInfo
{
    /*
	 *点击获取prodcut实例并初始化订单信息
	 */
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    
    order.tradeNO = myAlipay.outTradeNo; //订单ID（由商家自行制定）
	order.productName = myAlipay.subject; //商品标题
	order.productDescription = myAlipay.body; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",myAlipay.totalFee]; //商品价格
	order.notifyURL =  [BASE stringByAppendingString:myAlipay.notifyURL]; //回调URL
    
    [AppDelegate App].outTradeNo = myAlipay.outTradeNo;
    [AppDelegate App].totalFee = myAlipay.totalFee;
    
	NSLog(@"order=%@",order);
	return [order description];
    
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

-(void)paymentResultDelegate:(NSString *)result
{
    NSLog(@"%@",result);
}

//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            //            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
            //			id<DataVerifier> verifier;
            //            verifier = CreateRSADataVerifier(key);
            //
            //			if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                //验证签名成功，交易结果无篡改
            //			}
            
            [HttpRequest AlipayTradeResultRequestToken:[AppDelegate App].personModel.tokenid outTradeNo:myAlipay.outTradeNo price:myAlipay.totalFee delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}

//支付宝


-(void)payType:(UIButton * )btn
{
    if (btn.tag == 506) {
        alipayView.hidden = YES;
        _indicator.frame = CGRectMake(0, 41.5, self.frame.size.width/2, 3);
        if (_isFromMainShowing == NO&& _isFromMainShowingExt == YES) {
            btn.backgroundColor = color_21;
            alipayBtn.backgroundColor = color_18;
        }
    }
    else if (btn.tag == 507)
    {
        [self endEditing:YES];
        alipayView.hidden = NO;
        _indicator.frame = CGRectMake(self.frame.size.width/2, 41.5, self.frame.size.width/2, 3);
        if (_isFromMainShowing == NO&& _isFromMainShowingExt == YES) {
            btn.backgroundColor = color_21;
            cardBtn.backgroundColor = color_18;
        }
    }
}

-(void)choosePayPoint:(UIButton *)btn
{
    if (lastCLickBtn == btn) {
        return;
    }
    if (btn == customPriceButton) {
        [customPriceField becomeFirstResponder];
    }else{
        [customPriceField resignFirstResponder];
    }
    
    AppPointModel * pointModel = [pointsModel.list objectAtIndex:btn.tag - 2000];
    pointLab.text = [NSString stringWithFormat:@"%0.2f元",pointModel.price];
    btn.backgroundColor = color_6;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lastCLickBtn.backgroundColor = color_14;
    [lastCLickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    lastCLickBtn = btn;
}

-(void)endEditingself
{
    [self endEditing:YES];
}

-(void)dismissSucceedView
{
    paySucceedView.hidden = YES;
    backBtn.hidden = YES;
    dismissBtn.hidden = NO;
    titleLabe.text = @"我要充值";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (pointsModel.list.count % 3 > 0) {
        return pointsModel.list.count/3 + 1;
    }
    return pointsModel.list.count/3+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    
    for (int i = 0; i < 3; i++) {
        if (pointsModel.list.count > indexPath.row * 3 + i + 1) {
//            UIButton * btn1 = (UIButton *)[cell viewWithTag:indexPath.row * 3 + i + 2000];
            UIView * view1 = [cell viewWithTag:indexPath.row * 3 + i + 2000 + 5000];
            UIButton * btn1 = (UIButton *)[view1 viewWithTag:indexPath.row * 3 + i + 2000];
            AppPointModel * pointModel = [pointsModel.list objectAtIndex:indexPath.row * 3 + i];
            if (view1 == nil) {
                btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                btn1.frame = CGRectMake(30 + (140 + 20) * i, 0, 140, 51);
                btn1.backgroundColor = color_14;
                [btn1 setTitle:[NSString stringWithFormat:@"%0.2f猫币",pointModel.points] forState:UIControlStateNormal];
                [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn1.tag = indexPath.row * 3 + i + 2000;
                btn1.alpha = 1;
                btn1.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
                btn1.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                btn1.layer.borderWidth = 1;
                btn1.layer.borderColor = [UIColor lightGrayColor].CGColor;
                //            [btn1 setBackgroundImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(choosePayPoint:) forControlEvents:UIControlEventTouchUpInside];
                
                [btn1 childrenBtnStyleForBtn:btn1];
                view1 = [Commonality makeButtonShadowViewWhitbtn:btn1];
                view1.tag = indexPath.row * 3 + i + 2000 + 5000;
                [cell addSubview:view1];
            }
            if (indexPath.section == 0&&indexPath.row == 0&&!i) {
                lastCLickBtn = btn1;
                lastCLickBtn.backgroundColor = color_6;
                [lastCLickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                pointLab.text = [NSString stringWithFormat:@"%0.2f元",pointModel.price];
            }
            
        }
        else if (pointsModel.list.count == indexPath.row * 3 + i+1) {
            UIView * view1 = [cell viewWithTag:indexPath.row * 3 + i + 2000 + 5000];
            customPriceButton = (UIButton *)[view1 viewWithTag:indexPath.row * 3 + i + 2000];
            AppPointModel * pointModel = [pointsModel.list objectAtIndex:indexPath.row * 3 + i];
            if (view1 == nil) {
                customPriceField = [[JYTextField alloc]initWithFrame:CGRectMake(30, 0, 458, 51)
                                                                  cornerRadio:6
                                                                  borderColor:[Commonality colorFromHexRGB:@"c3c3c3"]
                                                                  borderWidth:0.5
                                                                   lightColor:nil
                                                                    lightSize:0
                                                             lightBorderColor:nil];
                customPriceField.backgroundColor = [Commonality colorFromHexRGB:@"f0f0f0"];
                customPriceField.placeholder = @"其他金额";
                customPriceField.textColor = [UIColor blackColor];
                customPriceField.delegate = self;
                customPriceField.clearsOnBeginEditing = YES;
                customPriceField.keyboardType = UIKeyboardTypeNumberPad;
                customPriceField.returnKeyType = UIReturnKeyDone;
                customPriceField.tag = 900;
                customPriceField.delegate = self;
                [cell addSubview:customPriceField];
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)rechargeButtonTouched
{
    [self show];
}

-(void)recharge
{
    [self endEditing:YES];
    
    if ([Commonality isEnableWIFI]==0) {
        [Commonality showErrorMsg:self type:0 msg:FAIILURE];
        return;
    }
    JYTextField * filed =(JYTextField *) [self viewWithTag:600];
    if ([Commonality isEmpty:filed.text]) {
        [Commonality showErrorMsg:self type:0 msg:@"点卡密码不能为空哦!"];
        return;
    }
    
    buyBtn.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    [HttpRequest PayRequest:AppDelegate.App.personModel.tokenid points:[self getCardNum] fee:@"" password:AppDelegate.App.personModel.password delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

-(void)show{
    
    
    alipayView.hidden = YES;
    
    _hihel=YES;
    paySucceedView.hidden = YES;
    
    paySucceedBagegroundView.hidden = YES;
    
//    [lastCLickBtn setBackgroundImage:nil forState:UIControlStateNormal];
    JYTextField * nubFied = (JYTextField*)[self viewWithTag:600];
    nubFied.text = nil;
    dismissBtn.hidden = NO;
    backBtn.hidden = YES;
    [AppDelegate App].reloadBalanceDelegate = self;
    
    if (_isFromMainShowingExt) {
        alipayBtn.backgroundColor = color_18;
        cardBtn.backgroundColor = color_21;
        [HttpRequest pointsRequestToken:[AppDelegate App].personModel.tokenid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
        return;
    }
    
    if (_isFromMainShowing == YES) {
        UIWindow*wind=[UIApplication sharedApplication].keyWindow;
        UIViewController * main = [AppDelegate App].tabBarController;
        self.center=CGPointMake(tmpRect.origin.x+tmpRect.size.width/2, tmpRect.origin.y+tmpRect.size.height);
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.center = wind.center;
                         }];
        
        
        UIView * view1 = [main.view.subviews lastObject];
        UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
        
        if (view1 != [AppDelegate App].tabBarController.customContentView) {
            view1.hidden = YES;
            view2.hidden = YES;
        }

        _myView.frame = CGRectMake(0, 0, main.view.frame.size.width, main.view.frame.size.height);
        _myView.alpha = 0.5;
        [main.view addSubview:_myView];
        //    624 552
        self.frame = CGRectMake(main.view.frame.size.width/2 - 276, main.view.frame.size.height/2 - 209, 552, 354);
        backgroundImageView.frame = CGRectMake(-10, -10, self.frame.size.width + 20, self.frame.size.height + 30);
        [main.view addSubview:self];

    }
    else
    {
        UIWindow*wind=[UIApplication sharedApplication].keyWindow;
        UIViewController * main = [AppDelegate App].personView;
        self.center=CGPointMake(tmpRect.origin.x+tmpRect.size.width/2, tmpRect.origin.y+tmpRect.size.height);
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.center = wind.center;
                         }];
        
        
        UIView * view1 = [main.view.subviews lastObject];
        UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
        
        if (view1 != [AppDelegate App].tabBarController.customContentView) {
            view1.hidden = YES;
            view2.hidden = YES;
        }
        
        _myView.frame = CGRectMake(0, 0, main.view.frame.size.width, main.view.frame.size.height);
        _myView.alpha = 0.5;
        [main.view addSubview:_myView];
        //    624 552
        self.frame = CGRectMake(main.view.frame.size.width/2 - 276, main.view.frame.size.height/2 - 209, 552, 354);
        backgroundImageView.frame = CGRectMake(-10, -10, self.frame.size.width + 20, self.frame.size.height + 30);
        [main.view addSubview:self];

    }
    [HttpRequest pointsRequestToken:[AppDelegate App].personModel.tokenid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

-(void)dismiss{

    [AppDelegate App].reloadBalanceDelegate = nil;
    UIViewController * main;
    if (_isFromMainShowing == YES) {
        main = [AppDelegate App].tabBarController;
    }else{
        main = [AppDelegate App].personView;
    }
    [UIView animateWithDuration:1.0
                     animations:^{
                         CGAffineTransform transform = CGAffineTransformScale(self.transform,0,0);
                         [self setTransform:transform];
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:self cache:YES];
                     } completion:^(BOOL finished) {
                         _hihel=YES;
                         [self removeFromSuperview];
                         [_myView removeFromSuperview];
                         
                         UIView * view1 = [main.view.subviews lastObject];
                         UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
                         view1.hidden = NO;
                         view2.hidden = NO;
                         
                         if ([view1 isKindOfClass:[BuyVipView class]]) {
                             BuyVipView * buyView = (BuyVipView *)view1;
                             buyView.balanceLab.text = [NSString stringWithFormat:@"帐号余额：%@猫币",[AppDelegate App].personModel.balance];
                         }
                         if ([view2 isKindOfClass:[BuyVipView class]]) {
                             BuyVipView * buyView = (BuyVipView *)view2;
                             buyView.balanceLab.text = [NSString stringWithFormat:@"帐号余额：%@猫币",[AppDelegate App].personModel.balance];
                         }
                         
                         if ([view1 isKindOfClass:[UserView class]]) {
                             UserView * user = (UserView *)view1;
                             [user.myTableView reloadData];
                         }
                         if ([view2 isKindOfClass:[UserView class]]) {
                             UserView * user = (UserView *)view2;
                             [user.myTableView reloadData];
                         }
                         
                         self.transform = CGAffineTransformIdentity;
                         
                     }];
}

-(void) GetErr:(ASIHTTPRequest *)request
{
    [AppDelegate App].tabBarController.view.alpha = 1;
    self.userInteractionEnabled = YES;
    buyBtn.userInteractionEnabled = YES;
    [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
}
-(void) GetResult:(ASIHTTPRequest *)request
{
    self.userInteractionEnabled = YES;
    buyBtn.userInteractionEnabled = YES;
    NSData *responseData = [request responseData];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"dic is %@",dictionary);
    if(dictionary==nil){
        [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
        [AppDelegate App].tabBarController.view.alpha = 1;
    }else{
        if (request.tag == POINTS_TYPE) {
            pointsModel = [[AppPointsModel alloc] initWithDictionary:dictionary];
            [myTableView reloadData];
            return;
        }
        else if (request.tag == ALIPAYPREPARESECUREPAY_TYPE)
        {
            myAlipay = [[AlipayPrepareSecurePayModel alloc]initWithDictionary:dictionary];
            if (myAlipay.errorCode == 0) {
                [self prepareSecurePay];
                [AppDelegate App].tabBarController.view.alpha = 0;
            }
            return;
        }
        else if (request.tag == ALIPAYTRADERESULT_TYPE)
        {
            [AppDelegate App].tabBarController.view.alpha = 1;
            if ([[dictionary objectForKey:@"errorCode"] intValue] == 0) {
                
                double point = [[[dictionary objectForKey:@"data"] objectForKey:@"points"] floatValue];
                double balance =  [AppDelegate.App.personModel.balance doubleValue] + point;
                AppDelegate.App.personModel.balance = [NSString stringWithFormat:@"%0.2f",balance];
                [[AppDelegate App].personView.userView.myTableView reloadData];
                
                
                if (!_isFromMainShowingExt) {
                    [[AppDelegate App].personView showRechargeSucessViewPop:[NSString stringWithFormat:@"账户余额：%0.2f猫币",balance] isMain:_isFromMainShowing];
                }else{
                    [[AppDelegate App].personView showRechargeSuccessView:[NSString stringWithFormat:@"账户余额：%0.2f猫币",balance]];
                }
                JYTextField * filed =(JYTextField *) [self viewWithTag:600];
                filed.text = nil;
                
                AppPointModel * pointModel = [pointsModel.list objectAtIndex:3];
                pointModel.points = 0;
                pointModel.price = 0;
                pointLab.text = [NSString stringWithFormat:@"%0.2f元",pointModel.price];
                customPriceField.text = nil;
                return;
                paySucceedView.hidden = NO;
                alipayView.hidden = YES;
                paySucceedBagegroundView.hidden = NO;
                paySucceedView.hidden = NO;
                titleLabe.text = @"完成";
                backBtn.hidden = NO;
                dismissBtn.hidden = YES;
//                [[AppDelegate App].userView.myTableView reloadData];
                return;
            }
            else
            {
                [Commonality showErrorMsg:self type:0/*[[dictionary objectForKey:@"errorCode"] intValue]*/ msg:LINGKERROR];
                return;
            }
            
        }
        else if (request.tag == 0)
        {
            PayAddModel *lm=[[PayAddModel alloc]initWithDictionary:dictionary];
            if (lm.result==0) {
                
                double point = [[[dictionary objectForKey:@"data"] objectForKey:@"points"] floatValue];
                double balance =  [AppDelegate.App.personModel.balance doubleValue] + point;
                AppDelegate.App.personModel.balance = [NSString stringWithFormat:@"%0.2f",balance];
                [[AppDelegate App].personView.userView.myTableView reloadData];
                
                if (!_isFromMainShowingExt) {
                    [[AppDelegate App].personView showRechargeSucessViewPop:[NSString stringWithFormat:@"账户余额：%0.2f猫币",balance] isMain:_isFromMainShowing];
                }else{
                    [[AppDelegate App].personView showRechargeSuccessView:[NSString stringWithFormat:@"账户余额：%0.2f猫币",balance]];
                }
                JYTextField * filed =(JYTextField *) [self viewWithTag:600];
                filed.text = nil;
                return;
                
                paySucceedView.hidden = NO;
                paySucceedBagegroundView.hidden = NO;
                titleLabe.text = @"完成";
                backBtn.hidden = NO;
                dismissBtn.hidden = YES;
                pointsLab.text = [NSString stringWithFormat:@"账户余额：%0.2f猫币",lm.balance];
                AppDelegate.App.personModel.balance = [NSString stringWithFormat:@"%0.2f",lm.balance];
                filed =(JYTextField *) [self viewWithTag:600];
                filed.text = nil;
//                [[AppDelegate App].userView.myTableView reloadData];
                return;
            }
            else{
                if (lm.result == 221) {
                    [Commonality showErrorMsg:self type:0 msg:@"您已经使用过此次活动赠送的充值卡进行充值"];
                    return;
                }
                [Commonality showErrorMsg:self type:lm.result msg:nil];
            }
        }
    }

}

-(void) reloadBalance:(NSDictionary *)DataDic
{
    [self reloadUI:DataDic];
}

-(void)reloadUI:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"errorCode"] intValue] == 0) {
        paySucceedBagegroundView.hidden = NO;
        paySucceedView.hidden = NO;
        alipayView.hidden = YES;
        
        paySucceedView.hidden = NO;
        titleLabe.text = @"完成";
        backBtn.hidden = NO;
        dismissBtn.hidden = YES;
        double point = [[[dictionary objectForKey:@"data"] objectForKey:@"points"] floatValue];
        double balance =  [AppDelegate.App.personModel.balance doubleValue] + point;
        AppDelegate.App.personModel.balance = [NSString stringWithFormat:@"%0.2f",balance];
        pointsLab.text = [NSString stringWithFormat:@"账户余额：%0.2f猫币",balance];
        JYTextField * filed =(JYTextField *) [self viewWithTag:600];
        filed.text = nil;
//        [[AppDelegate App].userView.myTableView reloadData];
        return;
    }
    else
    {
        [Commonality showErrorMsg:self type:0/*[[dictionary objectForKey:@"errorCode"] intValue]*/ msg:LINGKERROR];
        return;
    }

}

#pragma mark -

#pragma mark textfield methods

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (_isFromMainShowingExt) {
        return YES;
    }
//    if (_isFromMainShowing == NO) {
//        return YES;
//    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 80, 552, 354);
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == customPriceField) {
        if (!_isFromMainShowingExt) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 80, 552, 354);
        }
        return YES;
    }
    if (_isFromMainShowingExt) {
        return YES;
    }
//    if (_isFromMainShowing == NO) {
//        return YES;
//    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 80, 552, 354);
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == customPriceField) {
        lastCLickBtn.backgroundColor = color_14;
        [lastCLickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        lastCLickBtn = nil;
        pointLab.text = [NSString stringWithFormat:@"%0.2f元",0.0f];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == customPriceField) {
        AppPointModel * pointModel = [pointsModel.list objectAtIndex:3];
        pointModel.points = [textField.text doubleValue];
        pointModel.price = [textField.text doubleValue];
        pointLab.text = [NSString stringWithFormat:@"%0.2f元",pointModel.price];
        
        if ((![textField.text rangeOfString:@"猫币"].length)&&(textField.text.length)) {
            textField.text = [textField.text stringByAppendingString:@"猫币"];
        }
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == customPriceField) {
        
        [self endEditing:YES];
    }
    if (_isFromMainShowingExt) {
        return YES;
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 80, 552, 354);
    return YES;
}
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
#define NUMBERS @"0123456789"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 "
#define NUMBERSPERIOD @"0123456789."


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if (textField == customPriceField) {
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERSPERIOD ] invertedSet]; //invertedSet 方法是去反字符,把所有的除了数字的字符都找出来
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];  //componentsSeparatedByCharactersInSet 方法是把输入框输入的字符string 根据cs中字符一个一个去除cs字符并分割成单字符并转化为 NSArray, 然后componentsJoinedByString 是把NSArray 的字符通过 ""无间隔连接成一个NSString字符 赋给filtered.就是只剩数字了.
        
        
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
            
        {
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                            message:@"请输入数字"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil];
//            
//            [alert show];
            return NO;
        }
        
        // Add any predicate testing here
        if(range.location>3){
//            [Commonality showErrorMsg:self type:0 msg:@"别充这么多钱，好吗？"];
            return NO;
        }
        pointLab.text = [NSString stringWithFormat:@"%0.2f元",[[textField.text stringByAppendingString:string] floatValue]];
        return basicTest;

    }
    
    if (range.location == 4 || range.location == 9 || range.location == 14 || range.location == 19) {
        if (![string isEqualToString:@""]) {
            textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
        }
    }
    
    if(range.location>23){
        [Commonality showErrorMsg:self type:0 msg:@"点卡密码输入不能超过20位"];
        return NO;
    }else{
        return YES;
    }
    return YES;
}

-(NSString *)getCardNum
{
    JYTextField * filed =(JYTextField *) [self viewWithTag:600];
    NSString * str;
    if (filed.text.length == 19 || filed.text.length == 20 ) {
        str = [NSString stringWithFormat:@"%@%@%@%@",[filed.text substringWithRange:NSMakeRange(0, 4)],[filed.text substringWithRange:NSMakeRange(5, 4)],[filed.text substringWithRange:NSMakeRange(10, 4)],[filed.text substringWithRange:NSMakeRange(15, 4)]];
    }
    else if (filed.text.length == 24)
    {
        str = [NSString stringWithFormat:@"%@%@%@%@%@",[filed.text substringWithRange:NSMakeRange(0, 4)],[filed.text substringWithRange:NSMakeRange(5, 4)],[filed.text substringWithRange:NSMakeRange(10, 4)],[filed.text substringWithRange:NSMakeRange(15, 4)],[filed.text substringWithRange:NSMakeRange(20, 4)]];
    }
    else
    {
        return filed.text;
    }
    return str;
}
-(void)customPriceFieldBecomeEdit
{
    [customPriceField becomeFirstResponder];
}
@end
