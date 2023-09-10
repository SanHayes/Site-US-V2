<?php
namespace app\api\controller;
use think\Controller;
use think\Db;
use think\Loader;

class Base extends Controller
{
    public function __construct(){
		parent::__construct();
		//网站配置信息
		$this->conf = getconf();
		if($this->conf['is_close'] != 1){
            header('Location:/error.html');
            exit;
        }
        $uid = input('uid','');
        if($uid){
			db('userinfo')->where(['uid'=>$uid])->update(['online'=>1,'update_time'=>time()]);
		}
	}
}
