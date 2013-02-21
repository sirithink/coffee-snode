#coffee-snode [![依赖模块状态](http://david-dm.org/ChunMengLu/coffee-snode.png)](http://david-dm.org/ChunMengLu/coffee-snode)

#简介
这是一个nodejs的博客

采用 `Express.js 3.0` mvc框架`MySQL`数据库和`Jade`模版引擎，使用CoffeeScript编写!

基于`appfog`云空间，详情请访问官网：
```
https://console.appfog.com/
```
演示地址[dreamlu.net](http://www.dreamlu.net/)

#build and run
将CoffeeScript编译成js

打开命令行build: 
```
build.bat
```

打开另一个run:

```
strat.bat
```

请删除掉views/common/_layout.jade中的`百度统计`代码！

# 代码清理
使用`clear.bat`会在项目同级目录生成一个`temp`目录，

`temp`中的代码用来上传到`Appfog`！
```
clear.bat
```

如果有不明白或问题可联系email：596392912@qq.com Thanks！

灵感来自 [coffee-mvc](https://github.com/xizhang/coffee-mvc)
