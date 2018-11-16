

(1)简单介绍
SSKeyChains对苹果安全框架API进行了简单封装，
支持对存储在钥匙串中密码、账户进行访问，包括读取、删除和设置。
SSKeyChain的作者是大名鼎鼎的SSToolkit的作者samsoffes。
项目地址：
//https://github.com/samsoffes/sskeychain

(2)添加步骤
手动添加
在工程中加入SSKeyChain
在工程中加入Security.framework框架。
把SSKeychain.h和SSKeychain.m加到项目文件夹。


或者
Podfile中添加

pod 'SSKeychain', '~> 1.2.2'


pod install
pod update




(3)使用SSKeyChain
通过以下类方法来使用SSKeyChain（请查看SSKeyChain.h）：
+ (NSArray *)allAccounts;
+ (NSArray *)accountsForService:(NSString *)serviceName;
+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account;
+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account;
+ (BOOL)setPassword:(NSString *)password forService:(NSString*)serviceName account:(NSString *)account;



(4)调试
如果无法保存钥匙串，请使用SSKeychain.h中提供的错误代码，
例如：

NSError *error = nil;
NSString *password = [SSKeychain passwordForService:@"MyService" account:@"samsoffes"error:&error];
if ([error code] == SSKeychainErrorNotFound) {
    NSLog(@"Passwordnot found");
}

显然，你对做这个应该很熟悉了。访问钥匙串是件痛苦的事情，你要随时检查它的每个错误和失败。SSKeychain并没有使它（钥匙串）变得更稳定，它仅仅是繁琐的C APIs封装。

