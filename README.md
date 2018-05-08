#react-native-BGNativeModule


##安装
```
rnpm install react-native-nativemodule
```

##集成
reactNative0.29版本以后，需要在`MainApplication.java`文件的`getPackages`方法中添加：

```
@Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
              new MainReactPackage(),
              new BGNativeExamplePackage()
      );
    }
```

##使用
```
import BGNativeModuleExample from 'react-native-nativemodule-example';

BGNativeModuleExample.testPrint("Jack", {
    height: '1.78m',
    weight: '7kg'
});
```


##Example
```
npm install
```
