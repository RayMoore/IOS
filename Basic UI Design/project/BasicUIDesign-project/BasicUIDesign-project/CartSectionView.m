//
//  CartSectionView.m
//  BasicUIDesign-project
//
//  Created by Ray on 09/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "CartSectionView.h"

@interface CartSectionView()
@property (weak, nonatomic) IBOutlet UIImageView *allChoose;
@property (weak, nonatomic) IBOutlet UILabel *factoryName;
@property (assign,atomic) BOOL ifAllChoose;
@property (assign,atomic) NSInteger currentSection;
@property (strong,atomic) CartMainViewController *currentController;
@end

@implementation CartSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setAddressLabelName:(NSString*) name andMainController:(CartMainViewController*)controller{
    self.factoryName.text = [name stringByAppendingString:@"发货"];
    self.currentController = controller;
}

-(void)setSection:(NSInteger)section{
    self.currentSection = section;
}

-(void)tapAllChoose{
    if(self.ifAllChoose == CHOOSE){
        self.ifAllChoose = NOT_CHOOSE;
        self.allChoose.image = [UIImage imageNamed:NOT_CHOOSE_IMG];
        [self.currentController sectionAllChoose:self.currentSection andSelection:NOT_CHOOSE];
    }else{
        self.ifAllChoose = CHOOSE;
        self.allChoose.image = [UIImage imageNamed:CHOOSE_IMG];
        [self.currentController sectionAllChoose:self.currentSection andSelection:CHOOSE];
    }
}

-(BOOL)getChooseStatus{
    return self.ifAllChoose;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapAllChoose)];
    tapGesture.numberOfTapsRequired = 1;
    [self.allChoose addGestureRecognizer:tapGesture];
    self.ifAllChoose = CHOOSE;
    self.allChoose.image = [UIImage imageNamed:CHOOSE_IMG];
}



@end
