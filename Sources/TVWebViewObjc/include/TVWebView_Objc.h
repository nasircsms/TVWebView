//
//  WebView.h
//  Browser
//
//  Created by nasir on 24/08/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TVWebView_ObjcDelegate <NSObject>

- (void) didFailWithError:(NSError *) error;

@end

@interface TVWebView_Objc : UIView
@property(nonatomic, weak) id<TVWebView_ObjcDelegate> delegate;

- (void) loadURL: (NSURL*)url;
- (void) reload;
- (void) enableInteraction: (BOOL)isEnabled;
- (nullable NSString*) evaluateJavascript: (NSString*)js;
@end

NS_ASSUME_NONNULL_END
