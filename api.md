### 是否绑定手机和设置密码

http://v3api.dmzj.com/account/isbindtelpwd?dmzj_token=22fda9aea049c12011d5b581ad87880c&channel=Android&version=2.7.017&timestamp=1568202740

```
{"code":0,"msg":"OK","data":{"is_bind_tel":0,"is_set_pwd":1}}
```

### 消息未读

http://v3api.dmzj.com/msg/unread/

```
{"code":0,"msg":"OK","data":{"mess_unread_num":0,"reply_unread_num":"","system_unread_num":"","reply__unread_num":0,"system__unread_num":0}}
```

## 漫画

### 漫画推荐

http://v3api.dmzj.com/recommend_new.json?channel=Android&version=2.7.017&timestamp=1568202741


### 漫画更新

http://v3api.dmzj.com/latest/100/0.json?channel=Android&version=2.7.017&timestamp=1568202741

### 首页-订阅
http://v3api.dmzj.com/recommend/batchUpdate?uid=101484479&category_id=49&channel=Android&version=2.7.017&timestamp=1568202743

### 猜你喜欢
http://v3api.dmzj.com/recommend/batchUpdate?uid=101484479&category_id=50&channel=Android&version=2.7.017&timestamp=1568202743

## 个人中心

### 个人信息
http://v3api.dmzj.com/UCenter/comicsv2/101484479.json?channel=Android&dmzj_token=22fda9aea049c12011d5b581ad87880c&version=2.7.017&timestamp=1568203263


### 登录

POST https://user.dmzj.com/loginV2/m_confirm HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Content-Length: 34
Host: user.dmzj.com
Connection: Keep-Alive
Accept-Encoding: gzip
User-Agent: okhttp/3.12.1

passwd= &nickname= 

## 新闻

### 新闻分类
http://v3api.dmzj.com/article/category.json?channel=Android&version=2.7.017&timestamp=1568204838

### 首页banner

http://v3api.dmzj.com/v3/article/recommend/header.json?channel=Android&version=2.7.017&timestamp=1568204838

### 最新
http://v3api.dmzj.com/v3/article/list/0/2/0.json?channel=Android&version=2.7.017&timestamp=1568204838

http://v3api.dmzj.com/v3/article/list/1/3/0.json?channel=Android&version=2.7.017&timestamp=1568204941
http://v3api.dmzj.com/v3/article/list/分类ID/固定3/页数0开始.json?channel=Android&version=2.7.017&timestamp=1568204983