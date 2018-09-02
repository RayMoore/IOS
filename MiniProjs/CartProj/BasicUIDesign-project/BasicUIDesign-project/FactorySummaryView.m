//
//  FactorySummaryView.m
//  BasicUIDesign-project
//
//  Created by Ray on 09/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "FactorySummaryView.h"
#import "CheckoutPriceChangeObserver.h"
#import "CheckoutTaxChangeObserver.h"
#import "CartMainViewController.h"

@interface FactorySummaryView()
@property (assign,atomic) CGFloat totalPrice;
@property (assign,atomic) CGFloat totalTax;
@property (weak, nonatomic) IBOutlet UILabel *totalTaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (strong, atomic) CartMainViewController *controller;
//@property (strong, nonatomic) CheckoutPriceChangeObserver *checkoutObserverForTotalPrice;
//@property (strong, nonatomic) CheckoutTaxChangeObserver *checkoutObserverForTotalTax;


@end

@implementation FactorySummaryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setupWithController:(CartMainViewController*)controller{
    if(self.controller == nil){
        self.controller = controller;
    }
//    if(self.checkoutObserverForTotalPrice != nil){
//        [self removeObserver:self.checkoutObserverForTotalPrice forKeyPath:@"totalPrice"];
//        self.checkoutObserverForTotalPrice = nil;
//    }
//    if(self.checkoutObserverForTotalTax != nil){
//        [self removeObserver:self.checkoutObserverForTotalTax forKeyPath:@"totalTax"];
//        self.checkoutObserverForTotalTax = nil;
//    }
    
//    self.checkoutObserverForTotalPrice = [[CheckoutPriceChangeObserver alloc] initWithController:self.controller];
//    self.checkoutObserverForTotalTax = [[CheckoutTaxChangeObserver alloc] initWithController:self.controller];
//    @try{
//        [self addObserver:self.checkoutObserverForTotalPrice forKeyPath:@"totalPrice" options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:nil];
//        [self addObserver:self.checkoutObserverForTotalTax forKeyPath:@"totalTax" options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:nil];
//    }@catch(NSException *e){}
}


-(void)setPriceLabel{
    [self.totalPriceLabel setText:[@"￥" stringByAppendingFormat:@"%.2f",self.totalPrice]];
}

-(void)setTaxLabel{
    [self.totalTaxLabel setText:[@"￥" stringByAppendingFormat:@"%.2f",self.totalTax]];
}

-(void)setSummaryViewPrice:(CGFloat)price andTax:(CGFloat)tax{
    self.totalPrice = price;
    self.totalTax = tax;
    [self setPriceLabel];
    [self setTaxLabel];
    
}

-(void)substractPrice:(CGFloat)price andTax:(CGFloat)tax{
    self.totalPrice -= price;
    self.totalTax -= tax;
    [self setPriceLabel];
    [self setTaxLabel];
//    NSLog(@"after substract: tax:%.2f price:%.2f",self.totalTax,self.totalPrice);

}

-(void)addPrice:(CGFloat)price andTax:(CGFloat)tax{
    self.totalPrice += price;
    self.totalTax += tax;
    [self setPriceLabel];
    [self setTaxLabel];
//    NSLog(@"after add: tax:%.2f price:%.2f",self.totalTax,self.totalPrice);
}

-(void)getFactorySummaryDetail{
    NSLog(@"summary: tax:%.2f price:%.2f",self.totalTax,self.totalPrice);
}


-(void)dealloc{
//    [self ignoreCheckoutObserver];
}

//-(void)ignoreCheckoutObserver{
//    @try{
//        [self removeObserver:self.checkoutObserverForTotalPrice forKeyPath:@"totalPrice"];
//        [self removeObserver:self.checkoutObserverForTotalTax forKeyPath:@"totalTax"];
//    }@catch(NSException *e){}
//}

@end
