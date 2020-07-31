
// —framework_oc n版本1.0.3


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



typedef void (^initWithSTViewControllerBlock)(void);


@interface TXAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, copy) initWithSTViewControllerBlock initWithSTViewControllerBlock;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *appPushKey;

@property (nonatomic, copy) NSString *appHost;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary * _Nullable)launchOptions;



@end

NS_ASSUME_NONNULL_END
