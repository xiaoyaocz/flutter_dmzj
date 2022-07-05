# 动漫之家Flutter V3

master及v2分支代码太过于混乱，此分支重新创建了一个Flutter项目，从零开始。

## 新特性

- 支持平板、桌面端
- 更美观的UI
- 代码优化，使用更加流畅

## 框架

- `GetX` 状态管理、路由管理、国际化
- `Dio` 网络请求
- `Hive` 数据存储

## 目录结构

- `app` 一些通用的类及样式
- `services` 提供数据存储等服务
- `requests` 请求的封装
- `generated` 生成的国际化文件
- `modules` 模块，每个模块会有两个文件，view及controller
- `widgets` 自定义的小组件
- `routes` 路由定义
- `models` 实体类
- `storage` Hive实体类