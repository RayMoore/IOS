//
//  Contact+CoreDataProperties.h
//  ContactDemo
//
//  Created by amao on 16/7/19.
//  Copyright © 2016年 NetEase. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

@interface Contact (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *mobile;

@end

NS_ASSUME_NONNULL_END
