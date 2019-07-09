//
//  WebViewController.h
//  Runner
//
//  Created by Crow on 2019/7/9.
//  Copyright © 2019年 The Chromium Authors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController

@property(nonatomic,strong)NSMutableArray<WKWebView *>*webViews;

@property(nonatomic,strong)WKWebView *webView;

+(void)showView:(id)info;

+(void)hiddenView:(NSString *)url;

+(void)deleteView:(NSString *)url;

//+(WebViewController *)singleton;

@end


NS_ASSUME_NONNULL_END
