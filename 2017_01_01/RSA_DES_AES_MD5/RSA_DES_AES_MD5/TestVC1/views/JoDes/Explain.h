//
//  ViewController11.swift
//  RSA_DES_AES_MD5
//
//  Created by xiaoyulong on 2017/9/12.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//
PHP、JAVA、C#、Object-C 通用的DES加密


PHP：

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
class JoDES {
    
    private static $_instance = NULL;
    /**
     * @return JoDES
     */
    public static function share() {
        if (is_null(self::$_instance)) {
            self::$_instance = new JoDES();
        }
        return self::$_instance;
    }
    
    /**
     * 加密
     * @param string $str 要处理的字符串
     * @param string $key 加密Key，为8个字节长度
     * @return string
     */
    public function encode($str, $key) {
        $size = mcrypt_get_block_size(MCRYPT_DES, MCRYPT_MODE_CBC);
        $str = $this->pkcs5Pad($str, $size);
        $aaa = mcrypt_cbc(MCRYPT_DES, $key, $str, MCRYPT_ENCRYPT, $key);
        $ret = base64_encode($aaa);
        return $ret;
    }
    
    /**
     * 解密
     * @param string $str 要处理的字符串
     * @param string $key 解密Key，为8个字节长度
     * @return string
     */
    public function decode($str, $key) {
        $strBin = base64_decode($str);
        $str = mcrypt_cbc(MCRYPT_DES, $key, $strBin, MCRYPT_DECRYPT, $key);
        $str = $this->pkcs5Unpad($str);
        return $str;
    }
    
    function hex2bin($hexData) {
        $binData = "";
        for ($i = 0; $i < strlen($hexData); $i += 2) {
            $binData .= chr(hexdec(substr($hexData, $i, 2)));
        }
        return $binData;
    }
    
    function pkcs5Pad($text, $blocksize) {
        $pad = $blocksize - (strlen($text) % $blocksize);
        return $text . str_repeat(chr($pad), $pad);
    }
    
    function pkcs5Unpad($text) {
        $pad = ord($text {strlen($text) - 1});
        if ($pad > strlen($text))
            return false;
        
        if (strspn($text, chr($pad), strlen($text) - $pad) != $pad)
            return false;
        
        return substr($text, 0, - 1 * $pad);
    }
    
}





C#

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
public class MyDes
{
    /// <summary>
    /// DES加密方法
    /// </summary>
    /// <param name="strPlain">明文</param>
    /// <param name="strDESKey">密钥</param>
    /// <param name="strDESIV">向量</param>
    /// <returns>密文</returns>
    public static string Encode(string source, string _DESKey)
    {
        StringBuilder sb = new StringBuilder();
        using (DESCryptoServiceProvider des = new DESCryptoServiceProvider())
        {
            byte[] key = ASCIIEncoding.ASCII.GetBytes(_DESKey);
            byte[] iv = ASCIIEncoding.ASCII.GetBytes(_DESKey);
            byte[] dataByteArray = Encoding.UTF8.GetBytes(source);
            des.Mode = System.Security.Cryptography.CipherMode.CBC;
            des.Key = key;
            des.IV = iv;
            string encrypt = "";
            using (MemoryStream ms = new MemoryStream())
            using (CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write))
            {
                cs.Write(dataByteArray, 0, dataByteArray.Length);
                cs.FlushFinalBlock();
                encrypt = Convert.ToBase64String(ms.ToArray());
            }
            return encrypt;
        }
    }
    
    /// <summary>
    /// 进行DES解密。
    /// </summary>
    /// <param name="pToDecrypt">要解密的base64串</param>
    /// <param name="sKey">密钥，且必须为8位。</param>
    /// <returns>已解密的字符串。</returns>
    public static string Decode(string source, string sKey)
    {
        byte[] inputByteArray = System.Convert.FromBase64String(source);//Encoding.UTF8.GetBytes(source);
        using (DESCryptoServiceProvider des = new DESCryptoServiceProvider())
        {
            des.Key = ASCIIEncoding.ASCII.GetBytes(sKey);
            des.IV = ASCIIEncoding.ASCII.GetBytes(sKey);
            System.IO.MemoryStream ms = new System.IO.MemoryStream();
            using (CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write))
            {
                cs.Write(inputByteArray, 0, inputByteArray.Length);
                cs.FlushFinalBlock();
                cs.Close();
            }
            string str = Encoding.UTF8.GetString(ms.ToArray());
            ms.Close();
            return str;
        }
    }
}


Object-C

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
248
249
250
251
252
253
254
255
256
257
258
259
260
261
262
263
264
265
266
267
268
269
270
271
272
273
274
275
276
277
278
279
280
281
282
283
284
/***  JoDes.h ***/

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface JoDes : NSObject

+ (NSString *) encode:(NSString *)str key:(NSString *)key;
+ (NSString *) decode:(NSString *)str key:(NSString *)key;

@end


/***  JoDes.m ***/
//
//  XLEncrytHelper.m
//  NewHoldGold
//
//  Created by 梁鑫磊 on 13-12-27.
//  Copyright (c) 2013年 zsgjs. All rights reserved.
//

#import "JoDes.h"

@interface JoDes()

+ (NSString *) encodeBase64WithString:(NSString *)strData;
+ (NSString *) encodeBase64WithData:(NSData *)objData;
+ (NSData *) decodeBase64WithString:(NSString *)strBase64;

+ (NSString *)doCipher:(NSString *)sTextIn key:(NSString *)sKey
               context:(CCOperation)encryptOrDecrypt;

@end

@implementation JoDes

+ (NSString *) encode:(NSString *)str key:(NSString *)key
{
    // doCipher 不能编汉字，所以要进行 url encode
    NSMutableString* str1 = [JoDes urlEncode:str];
    NSMutableString* encode = [NSMutableString stringWithString:[JoDes doCipher:str1 key:key context:kCCEncrypt]];
    [JoDes formatSpecialCharacters:encode];
    return encode;
}

+ (NSString *) decode:(NSString *)str key:(NSString *)key
{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    [JoDes reformatSpecialCharacters:str1];
    NSString *rt = [JoDes doCipher:str1 key:key context:kCCDecrypt];
    return rt;
}

+ (NSMutableString *)urlEncode:(NSString*)str
{
    NSMutableString* encodeStr = [NSMutableString stringWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [encodeStr replaceOccurrencesOfString:@"+" withString:@"%2B" options:NSWidthInsensitiveSearch range:NSMakeRange(0, [encodeStr length])];
    [encodeStr replaceOccurrencesOfString:@"/" withString:@"%2F" options:NSWidthInsensitiveSearch range:NSMakeRange(0, [encodeStr length])];
    return encodeStr;
}

+ (void)formatSpecialCharacters:(NSMutableString *)str
{
    [str replaceOccurrencesOfString:@"+" withString:@"$$" options:NSWidthInsensitiveSearch range:NSMakeRange(0, [str length])];
    [str replaceOccurrencesOfString:@"/" withString:@"@@" options:NSWidthInsensitiveSearch range:NSMakeRange(0, [str length])];
}


+ (void)reformatSpecialCharacters:(NSMutableString *)str
{
    [str replaceOccurrencesOfString:@"$$" withString:@"+" options:NSWidthInsensitiveSearch range:NSMakeRange(0, [str length])];
    [str replaceOccurrencesOfString:@"@@" withString:@"/" options:NSWidthInsensitiveSearch range:NSMakeRange(0, [str length])];
}

+ (NSString *)encodeBase64WithString:(NSString *)strData {
    return [JoDes encodeBase64WithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
}


+ (NSString *)encodeBase64WithData:(NSData *)objData {
    NSString *encoding = nil;
    unsigned char *encodingBytes = NULL;
    @try {
        static char encodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        static NSUInteger paddingTable[] = {0,2,1};
        
        NSUInteger dataLength = [objData length];
        NSUInteger encodedBlocks = (dataLength * 8) / 24;
        NSUInteger padding = paddingTable[dataLength % 3];
        if( padding > 0 ) encodedBlocks++;
        NSUInteger encodedLength = encodedBlocks * 4;
        
        encodingBytes = malloc(encodedLength);
        if( encodingBytes != NULL ) {
            NSUInteger rawBytesToProcess = dataLength;
            NSUInteger rawBaseIndex = 0;
            NSUInteger encodingBaseIndex = 0;
            unsigned char *rawBytes = (unsigned char *)[objData bytes];
            unsigned char rawByte1, rawByte2, rawByte3;
            while( rawBytesToProcess >= 3 ) {
                rawByte1 = rawBytes[rawBaseIndex];
                rawByte2 = rawBytes[rawBaseIndex+1];
                rawByte3 = rawBytes[rawBaseIndex+2];
                encodingBytes[encodingBaseIndex] = encodingTable[((rawByte1 >> 2) & 0x3F)];
                encodingBytes[encodingBaseIndex+1] = encodingTable[((rawByte1 << 4) & 0x30) | ((rawByte2 >> 4) & 0x0F) ];
                encodingBytes[encodingBaseIndex+2] = encodingTable[((rawByte2 << 2) & 0x3C) | ((rawByte3 >> 6) & 0x03) ];
                encodingBytes[encodingBaseIndex+3] = encodingTable[(rawByte3 & 0x3F)];
                
                rawBaseIndex += 3;
                encodingBaseIndex += 4;
                rawBytesToProcess -= 3;
            }
            rawByte2 = 0;
            switch (dataLength-rawBaseIndex) {
                case 2:
                    rawByte2 = rawBytes[rawBaseIndex+1];
                case 1:
                    rawByte1 = rawBytes[rawBaseIndex];
                    encodingBytes[encodingBaseIndex] = encodingTable[((rawByte1 >> 2) & 0x3F)];
                    encodingBytes[encodingBaseIndex+1] = encodingTable[((rawByte1 << 4) & 0x30) | ((rawByte2 >> 4) & 0x0F) ];
                    encodingBytes[encodingBaseIndex+2] = encodingTable[((rawByte2 << 2) & 0x3C) ];
                    // we can skip rawByte3 since we have a partial block it would always be 0
                    break;
            }
            // compute location from where to begin inserting padding, it may overwrite some bytes from the partial block encoding
            // if their value was 0 (cases 1-2).
            encodingBaseIndex = encodedLength - padding;
            while( padding-- > 0 ) {
                encodingBytes[encodingBaseIndex++] = '=';
            }
            encoding = [[NSString alloc] initWithBytes:encodingBytes length:encodedLength encoding:NSASCIIStringEncoding];
        }
    }
    @catch (NSException *exception) {
        encoding = nil;
        NSLog(@"WARNING: error occured while tring to encode base 32 data: %@", exception);
    }
    @finally {
        if( encodingBytes != NULL ) {
            free( encodingBytes );
        }
    }
    return encoding;
    
}

+ (NSData *)decodeBase64WithString:(NSString *)strBase64 {
    NSData *data = nil;
    unsigned char *decodedBytes = NULL;
    @try {
#define __ 255
        static char decodingTable[256] = {
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x00 - 0x0F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x10 - 0x1F
            __,__,__,__, __,__,__,__, __,__,__,62, __,__,__,63,  // 0x20 - 0x2F
            52,53,54,55, 56,57,58,59, 60,61,__,__, __, 0,__,__,  // 0x30 - 0x3F
            __, 0, 1, 2,  3, 4, 5, 6,  7, 8, 9,10, 11,12,13,14,  // 0x40 - 0x4F
            15,16,17,18, 19,20,21,22, 23,24,25,__, __,__,__,__,  // 0x50 - 0x5F
            __,26,27,28, 29,30,31,32, 33,34,35,36, 37,38,39,40,  // 0x60 - 0x6F
            41,42,43,44, 45,46,47,48, 49,50,51,__, __,__,__,__,  // 0x70 - 0x7F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x80 - 0x8F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x90 - 0x9F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xA0 - 0xAF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xB0 - 0xBF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xC0 - 0xCF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xD0 - 0xDF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xE0 - 0xEF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xF0 - 0xFF
        };
        strBase64 = [strBase64 stringByReplacingOccurrencesOfString:@"=" withString:@""];
        NSData *encodedData = [strBase64 dataUsingEncoding:NSASCIIStringEncoding];
        unsigned char *encodedBytes = (unsigned char *)[encodedData bytes];
        
        NSUInteger encodedLength = [encodedData length];
        NSUInteger encodedBlocks = (encodedLength+3) >> 2;
        NSUInteger expectedDataLength = encodedBlocks * 3;
        
        unsigned char decodingBlock[4];
        
        decodedBytes = malloc(expectedDataLength);
        if( decodedBytes != NULL ) {
            
            NSUInteger i = 0;
            NSUInteger j = 0;
            NSUInteger k = 0;
            unsigned char c;
            while( i < encodedLength ) {
                c = decodingTable[encodedBytes[i]];
                i++;
                if( c != __ ) {
                    decodingBlock[j] = c;
                    j++;
                    if( j == 4 ) {
                        decodedBytes[k] = (decodingBlock[0] << 2) | (decodingBlock[1] >> 4);
                        decodedBytes[k+1] = (decodingBlock[1] << 4) | (decodingBlock[2] >> 2);
                        decodedBytes[k+2] = (decodingBlock[2] << 6) | (decodingBlock[3]);
                        j = 0;
                        k += 3;
                    }
                }
            }
            
            // Process left over bytes, if any
            if( j == 3 ) {
                decodedBytes[k] = (decodingBlock[0] << 2) | (decodingBlock[1] >> 4);
                decodedBytes[k+1] = (decodingBlock[1] << 4) | (decodingBlock[2] >> 2);
                k += 2;
            } else if( j == 2 ) {
                decodedBytes[k] = (decodingBlock[0] << 2) | (decodingBlock[1] >> 4);
                k += 1;
            }
            data = [[NSData alloc] initWithBytes:decodedBytes length:k];
        }
    }
    @catch (NSException *exception) {
        data = nil;
        NSLog(@"WARNING: error occured while decoding base 32 string: %@", exception);
    }
    @finally {
        if( decodedBytes != NULL ) {
            free( decodedBytes );
        }
    }
    return data;
    
}


+ (NSString *)doCipher:(NSString *)sTextIn key:(NSString *)sKey
               context:(CCOperation)encryptOrDecrypt {
    NSStringEncoding EnC = NSUTF8StringEncoding;
    
    NSMutableData *dTextIn;
    if (encryptOrDecrypt == kCCDecrypt) {
        dTextIn = [[JoDes decodeBase64WithString:sTextIn] mutableCopy];
    }
    else{
        dTextIn = [[sTextIn dataUsingEncoding: EnC] mutableCopy];
    }
    NSMutableData * dKey = [[sKey dataUsingEncoding:EnC] mutableCopy];
    [dKey setLength:kCCBlockSizeDES];
    uint8_t *bufferPtr1 = NULL;
    size_t bufferPtrSize1 = 0;
    size_t movedBytes1 = 0;
    //uint8_t iv[kCCBlockSizeDES];
    //memset((void *) iv, 0x0, (size_t) sizeof(iv));
    //    Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    bufferPtrSize1 = ([sTextIn length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
    bufferPtr1 = malloc(bufferPtrSize1 * sizeof(uint8_t));
    memset((void *)bufferPtr1, 0x00, bufferPtrSize1);
    
    CCCrypt(encryptOrDecrypt, // CCOperation op
            kCCAlgorithmDES, // CCAlgorithm alg
            kCCOptionPKCS7Padding, // CCOptions options
            [dKey bytes], // const void *key
            [dKey length], // size_t keyLength //
            [dKey bytes], // const void *iv
            [dTextIn bytes], // const void *dataIn
            [dTextIn length],  // size_t dataInLength
            (void *)bufferPtr1, // void *dataOut
            bufferPtrSize1,     // size_t dataOutAvailable
            &movedBytes1);
    
    //[dTextIn release];
    //[dKey release];
    
    NSString * sResult;
    if (encryptOrDecrypt == kCCDecrypt){
        sResult = [[NSString alloc] initWithData:[NSData dataWithBytes:bufferPtr1 length:movedBytes1] encoding:EnC];
        free(bufferPtr1);
    }
    else {
        NSData *dResult = [NSData dataWithBytes:bufferPtr1 length:movedBytes1];
        free(bufferPtr1);
        sResult = [JoDes encodeBase64WithData:dResult];
    }
    return sResult;
}



@end





JAVA

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
package com.example.aric.test;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;

import android.util.Base64;

public class DES {
    
    public final static String DES_KEY_STRING = "ABSujsuu";
    
    public static String encrypt(String message, String key) throws Exception {
        Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
        
        DESKeySpec desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));
        
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
        IvParameterSpec iv = new IvParameterSpec(key.getBytes("UTF-8"));
        cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);
        
        return encodeBase64(cipher.doFinal(message.getBytes("UTF-8")));
    }
    
    public static String decrypt(String message, String key) throws Exception {
        
        byte[] bytesrc = decodeBase64(message);//convertHexString(message);
        Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
        DESKeySpec desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
        IvParameterSpec iv = new IvParameterSpec(key.getBytes("UTF-8"));
        
        cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);
        
        byte[] retByte = cipher.doFinal(bytesrc);
        return new String(retByte);
    }
    
    public static byte[] convertHexString(String ss) {
        byte digest[] = new byte[ss.length() / 2];
        for (int i = 0; i < digest.length; i++) {
            String byteString = ss.substring(2 * i, 2 * i + 2);
            int byteValue = Integer.parseInt(byteString, 16);
            digest[i] = (byte) byteValue;
        }
        
        return digest;
    }
    
    public static String toHexString(byte b[]) {
        StringBuffer hexString = new StringBuffer();
        for (int i = 0; i < b.length; i++) {
            String plainText = Integer.toHexString(0xff & b[i]);
            if (plainText.length() < 2)
                plainText = "0" + plainText;
            hexString.append(plainText);
        }
        
        return hexString.toString();
    }
    
    
    public static String encodeBase64(byte[] b) {
        return Base64.encodeToString(b, Base64.DEFAULT);
    }
    
    public static byte[] decodeBase64(String base64String) {
        return Base64.decode(base64String, Base64.DEFAULT);
    }
}
