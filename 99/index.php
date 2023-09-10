<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

// [ 应用入口文件 ]
header("Content-type: text/html; charset=utf-8"); 

//require 'txprotect.php';
//require '360scan.php';
if(file_exists("../install") && !file_exists("../install/install.lock")){
    // 组装安装url
    $url = $_SERVER['HTTP_HOST'].'/install/index.php';
    header("Location:http://".$url);
    die;
}

//开启session
session_start();

// 定义应用目录
//die( __DIR__ . '/application/');
define('APP_PATH', __DIR__ . '/application/');
// 加载框架引导文件
require __DIR__ . '/thinkphp/start.php';
