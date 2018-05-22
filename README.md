#react-native-WaterMark


##安装
```
npm install react-native-watermarks --save
react-native link react-native-watermarks

rnpm install react-native-watermarks

```

##集成
reactNative0.29版本以后，需要在`MainApplication.java`文件的`getPackages`方法中添加：

```
@Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
              new MainReactPackage(),
              new CustomPackage()
      );
    }
```

```
@Override
    protected void onCreate(Bundle savedInstanceState) {


        WatermarkUtil.setActivity(this);
  }
```



##使用
```
import JQWaterMark from 'react-native-watermarks';

    JQWaterMark.markWithName('久其1', {
        horizontal_apace: '100',
        vertical_space: '100',
        cg_transform_rotation: '-0.5',
        mark_font: '20',
        mark_color: '#30666666',
    });

```


##Example
```
npm install
```
