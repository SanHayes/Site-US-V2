<?php
namespace app\api\controller;
use think\Db;
use think\Cookie;



class Index extends Base
{

	/**
	 * 首页 行情列表
	 * @author lukui  2017-02-18
	 * @return [type] [description]
	 */
    public function index()
    {
        //获取产品信息
        $pro = db('productdata')->where('isdelete',0)->order('sort')->select();
        $img_data = Db::name('productinfo')->field('pid,img,ptitle')->select();
        $imgarr = array();
        $namearr = array();
        foreach ($img_data as $kk => $vv){
            $imgarr[$vv['pid']] = $vv['img'];
            $namearr[$vv['pid']] = $vv['ptitle'];
        }
        foreach ($pro as $k => $v) {
            $pro[$k]['is_deal'] = ChickIsOpen($v['pid']);
        	$pro[$k]['img'] = $imgarr[$v['pid']];
        	$pro[$k]['Name'] = $namearr[$v['pid']];
        	$pro[$k]['Price'] = number_format($v['Price'],4,'.','');
        }
        $data = [];
        $data['pro'] = $pro;
        $notices = db('notice')->where(['state' => 1])->order('id desc')->limit(3)->select();
        $this->assign('notices', $notices);
        $data['notices'] = $notices;
        // 轮播图
		$gallery = db('gallery')->where(['state'=>1])->order('sort asc,id asc')->select();
        $data['gallery'] = $gallery;
		// 判断注册登录送彩金
		$caijin = cache('caijin');
		if($caijin) cache('caijin', NULL);
		$data['caijin'] = $caijin;
        return json(['code'=>200,'data'=>$data,'msg'=>'success']);
    }
    
    public function notice()
    {
        $notices = db('notice')->where(['state' => 1])->order('id desc')->limit(3)->select();
        return json(['code'=>200,'data'=>$notices,'msg'=>'success']);
    }

	public function ajax_order(){
		$pro_length = 50;
		$phone_pre_arr = array("139","138","137","136","135","134","159","158","157","150","151","152","187","188","130","131","132","156","155","133","153","189");
		$phone_pre_length = count($phone_pre_arr);
		//$price_arr = array(100,200,300,400,500,600,700,800,500,500,1000,1000,5000,5000,10000,20000);
		//$price_arr_length = count($price_arr);
		$type_arr = array('买涨','买跌');
		$type_arr_length = count($type_arr);
		$order_pub = array();
		for($i=0;$i<$pro_length;$i++){
			//$rand_pid_index = rand(0,($pro_length - 1));
			$phone_pre_index = rand(0,($phone_pre_length - 1));
			//$rand_price_index = rand(0,($price_arr_length - 1));
			//$rand_type_index = rand(0,($type_arr_length - 1));

			$o_pub = array();
			//$o_pub['buytime'] = time();
			//$o_pub['pid'] = $id_arr[$rand_pid_index];
			$o_pub['phone'] = $phone_pre_arr[$phone_pre_index] . "****" . rand(1000,9999);


			//$o_pub['price'] = $price_arr[$rand_price_index];

			$o_pub['price'] = $this->getrd();

			/*
			else if(rand(1,100)>=80){
				$o_pub['price'] = 50 * rand(0,100);
			}
			*/

			//$o_pub['otype'] = $type_arr[$rand_type_index];
			array_push($order_pub,$o_pub);
		}


		//foreach($order_pub as $k => $v){
			//$order_pub[$k]['buytime'] = date("H:i:s",$v['buytime']);
		//}
		 echo json_encode($order_pub);
	}

    public function ajaxindexpro()
    {
    	//获取产品信息
        $pro = Db::name('productdata')->field('pid,Name ptitle,Price,UpdateTime,Low,High,img')->where('isdelete',0)->select();
        $img_data = Db::name('productinfo')->field('pid,img')->select();
        $imgarr = array();
        foreach ($img_data as $kk => $vv){
            $imgarr[$vv['pid']] = $vv['img'];
        }
        $newpro = array();
        foreach ($pro as $k => $v) {
        	$newpro[$v['pid']] = $pro[$k];
        	$newpro[$v['pid']]['UpdateTime'] = date('H:i:s',$v['UpdateTime']);
        	$newpro[$v['pid']]['img'] = $imgarr[$v['pid']];
        	if($v['Price'] < session('pid'.$v['pid']) ){  //跌了
        		$newpro[$v['pid']]['isup'] = 0;
        	}elseif($v['Price'] > session('pid'.$v['pid']) ){  //涨了
        		$newpro[$v['pid']]['isup'] = 1;
        	}else{  //没跌没涨
        		$newpro[$v['pid']]['isup'] = 2;
        	}
        	session('pid'.$v['pid'],$v['Price']);
        }
        return json_encode($newpro);
    }
    //添加自选
    public function adduserbind(){
        $uid = input('param.uid');
        $pid = input('param.pid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        $res = Db::name('userbind')->query("SELECT u.btime,p.* FROM wp_userbind AS u , wp_view_proinfo as p WHERE u.pid = p.pid AND u.uid=$uid AND p.pid=$pid");
        if($res){
            return json(['code'=>-2,'data'=>[],'msg'=>'该产品已绑定']);
        }
        $data = Db::name('userbind')->insert(['uid'=>$uid,'pid'=>$pid,'btime'=>date('Y-m-d H:i:s')]);
        if($data > 0){
            return json(['code'=>200,'data'=>$data,'msg'=>'success']);
        }else{
            return json(['code'=>-3,'data'=>[],'msg'=>'添加自选失败']);
        }
    }
    //删除自选
    public function deluserbind(){
        $uid = input('param.uid');
        $pid = input('param.pid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        $data = Db::name('userbind')->where(['uid'=>$uid,'pid'=>$pid])->delete();
        if($data > 0){
            return json(['code'=>200,'data'=>$data,'msg'=>'success']);
        }else{
            return json(['code'=>-4,'data'=>[],'msg'=>'删除自选失败']);
        }
    }
    //自选列表
    public function userbind(){
        $uid = input('param.uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        $data = Db::name('userbind')->table('wp_userbind u,wp_view_proinfo p')->where('u.pid = p.pid AND u.uid='.$uid)->select();
        return json(['code'=>200,'data'=>$data,'msg'=>'success']);
    }

    public function getchart()
    {

        $data['hangqing'] = '商品行情';
        $data['jiaoyijilu'] = '交易记录';
        $data['shangpinmingcheng'] = '商品名称';
        $data['xianjia'] = '现价';
        $data['zuidi'] = '最低';
        $data['zuigao'] = '最高';
        $data['xianjia'] = '现价';
        $data['xianjia'] = '现价';


        $res = json_encode($data);
        return $res;
    }

    public  function  getrd(){
        $rdarr=array(88,90,92,93,176,180,184,186,264,270,276,
            279,352,440,450,460,465,880,900,920,930,1760,1800,1840,
            4400,4500,4600,4650,8800,9000,9200,9300,17600,18000,18400,18600);

        return $rdarr[array_rand($rdarr)];
    }

    /**
     * 首页获取最新的动态数据
     */
    public  function ajaxdata() {
        $product = db('productdata')->field("pid,Name,price,isdelete")->where(array('isdelete' => 0))->select();

        foreach( $product as $k=>$val) {
         //   $rd = rand(-3,3);
          //  $product[$k]['price'] = $val['price'] +$rd*0.01*$val['price'];
          $product[$k]['price'] = number_format($val['price'],4,'.','');
            $lastprice= session('price'.$val['pid']);
            $product[$k]['is_rise']=($lastprice>=$val['price'])?1:2;//1跌2涨
            session('price'.$val['pid'],$product[$k]['price']);
        }
        return json(['code'=>200,'data'=>$product,'msg'=>'success']);
    }

    /**
     * 用户信息
     * @return mixed|string
     */
    public function userinfo() {
        $uid = input('uid');
        if($uid != ''){
            $user = db('userinfo')->where('uid', $uid)->field("usermoney,username,ustatus,nickname,oid,otype")->find();
            //推广二维码
            if(intval($user['otype']) == 101){
            	$user['oid'] = $uid;
            }
    		$user['today_count'] = db('order')->where('uid', $uid)->whereBetween('selltime', [
    			strtotime(date("Y-m-d"),time()),
    			strtotime(date('Y-m-d',strtotime('+1 day'))),
    		])->sum('ploss');
    		$user['today_count'] = isset($user['today_count'])?$user['today_count']:'0.00';
    		$user['yesterday_count'] = db('order')->where('uid', $uid)->whereBetween('selltime', [
    			strtotime(date('Y-m-d',strtotime('-1 day'))),
    			strtotime(date("Y-m-d"),time()),
    		])->sum('ploss');
    		$user['yesterday_count'] = isset($user['yesterday_count'])?$user['yesterday_count']:'0.00';
    		$user['invest_count'] = db('order')->where('uid', $uid)->sum('ploss');
    		$user['invest_count'] = isset($user['invest_count'])?$user['invest_count']:'0.00';
            return json(['code'=>200,'data'=>$user,'msg'=>'success']);
        }else{
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
    }
    
    public function member() {
        $isDownload = db('config')->where('name', 'app_show')->value('value');
        $downloadUrl = db('config')->where('name', 'app_url')->value('value');
        return json(['code'=>200,'data'=>['isDownload'=>$isDownload,'downloadUrl'=>$downloadUrl],'msg'=>'success']);
    }

    //充值显示信息
    public function pay() {
        $data = [];
        $conf = $this->conf;
        $arr=explode('|',$conf['reg_push']);
        $data['reg_push'] = $arr;
        // 充值方式
        $payment = db('payment')->where(['is_use'=>1,'isdelete'=>0])->field("id,pay_name,is_use,account_no,thumb")->order('pay_order desc')->select();
        foreach($payment as $k=>$v){
            $array = [];
            $arr = explode(',',$v['account_no']);
            foreach ($arr as $kk=>$vv){
                $sss = explode(':',$vv);
                $array[strtoupper($sss[0])] = $sss[1];
            }
            $payment[$k]['account_no'] = json_decode(json_encode($array));
        }
        $data['payment'] = $payment;
        // 入款银行
        $sysbank = db('sysbank')->find();
        $data['sysbank'] = $sysbank;
        return json(['code'=>200,'data'=>$data,'msg'=>'success']);
    }
    public function upload(){
        $file = request()->file('file');
		if($file){
		    $info = $file->getInfo();
			$suffix = 'jpg';
			$name = date('YmdHis').mt_rand(100,999);
			$path = 'public' . DS . 'uploads' . DS . date('Ymd');
			if($info['type']){
			    $suffix = explode('/',$info['type'])[1];
			}
            if (!function_exists($path)) {
                mkdirs($path);
            }
            if($file){
                $info = $file->move(UPLOADS_PATH . $path, $name.'.'.$suffix);
                if($info){
                    $img = DS . $path . DS . $name.'.'.$suffix;
                }
            }
            if($img == ''){
                return json(['code'=>-65,'data'=>[],'msg'=>'upload error!']);
            }
            return json(['code'=>200,'data'=>$img,'msg'=>'success']);
		}else{
		    return json(['code'=>-65,'data'=>[],'msg'=>'upload error!']);
		}
    }
    //充值提交
    public function paysubmit(){
        $uid = input('post.uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        $bpprice = input('post.price', 0, 'floatval');
        if(!$bpprice){
            return json(['code'=>-5,'data'=>[],'msg'=>'充值金额无效']);
        }
        $pay_type = input('post.pay_type', 5, 'intval');
        
        $truename = input('post.truename', '', 'trim');
        if(!$truename){
            return json(['code'=>-65,'data'=>[],'msg'=>'upload error!']);
        }
        $btime = input('post.btime', '', 'trim');

        if($bpprice<$this->conf['userpay_min']){
            return json(['code'=>-7,'data'=>[],'msg'=>'最小充值金额'.$this->conf['userpay_min']]);
        }elseif($bpprice>$this->conf['userpay_max']){
            return json(['code'=>-8,'data'=>[],'msg'=>'最大充值金额'.$this->conf['userpay_max']]);
        }

        // 充值方式
        $payment = db('payment')->where(['is_use'=>1,'isdelete'=>0,'id'=>$pay_type])->find();
        if(!$payment){
            return json(['code'=>-9,'data'=>[],'msg'=>'请选择充值方式']);
        }
        $user = db('userinfo')->field('usermoney')->where(['uid'=>$uid])->find();
        $bpbalance = $user['usermoney'];
        $insert = ['uid'=>$uid,'bpprice'=>$bpprice,'pay_type'=>$payment['pay_name'],'bptype'=>1,'bptime'=>time(),'btime'=>$btime?strtotime($btime):time(),'remarks'=>'Recharge','isverified'=>0,'reg_par'=>0,'bpbalance'=>$bpbalance,'truename'=>$truename,'balance_sn'=>$uid.rand(111,999).date("YmdHis")];

        $bid = db('balance')->insertGetId($insert);
        if($bid){
            return json(['code'=>200,'data'=>$bid,'msg'=>'success']);
        }else{
            return json(['code'=>-10,'data'=>[],'msg'=>'充值失败']);
        }
    }

    //历史账单
    public  function  inquiries() {
        $uid = input('post.uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
		
		$fromtime = input('fromtime','','trim');
		$totime = input('totime','','trim');
		$pid = input('pid','0','intval');

		$where = ['uid'=>$uid];
		if($fromtime && $totime){
			$where = array_merge($where,['buytime'=>[['egt',strtotime($fromtime)],['lt',strtotime($totime)+86400]]]);
		}elseif($fromtime){
			$where = array_merge($where,['buytime'=>['egt',strtotime($fromtime)]]);
		}elseif($totime){
			$where = array_merge($where,['buytime'=>['lt',strtotime($totime)+86400]]);
		}
		if($pid){
			$where = array_merge($where,['pid'=>$pid]);
		}

        $orders = db('order')->where($where)->order('oid desc')->select();
		foreach($orders as  $k=>$val) {
			$orders[$k]['name'] =$val['ptitle'];
			$orders[$k]['fx'] = ($val['ostyle']==0)?'买涨':'买跌';
			$orders[$k]['yk'] = $val['ploss'];
			$orders[$k]['money'] =$val['fee'];
		}
		$data = [];
        $data['orders'] = $orders;
        return json(['code'=>200,'data'=>$data,'msg'=>'success']);
    }
    //充值账单
    public  function allrecord() {
        $uid = input('uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        $acountrf = db('balance')->where(['uid'=>$uid,'isshow'=>1])->order('bpid desc')->select();
        $dealhis = [];
        $types = [1=>'充值',2=>'手动加款',3=>'正在充值',4=>'取消','5'=>'提现','6'=>'手动扣款',7=>'邀请奖励'];
        foreach($acountrf  as $key=>$val) {
            $dealhis[$key]['utime'] = date('Y-m-d H:i:s',$val['bptime']);
            $dealhis[$key]['reg_par'] = $val['reg_par'];
            $dealhis[$key]['realprice'] = $val['realprice'];
            $dealhis[$key]['typedesc'] =$types[$val['bptype']];
            $dealhis[$key]['money'] = $val['bpprice'];
            $dealhis[$key]['isverified']= $val['isverified'];
            $dealhis[$key]['bptype'] = $val['bptype'];
			if($val['isverified']==1){
				$dealhis[$key]['is_verify']='审核通过';
			}elseif($val['isverified']==2){
				$dealhis[$key]['is_verify']='拒绝';
			}elseif($val['isverified']==0){
				$dealhis[$key]['is_verify']='待审核';
			}else{
				$dealhis[$key]['is_verify']='审核中';
			}
            $dealhis[$key]['remarks'] = $val['remarks'];
        }
       return json(['code'=>200,'data'=>$dealhis,'msg'=>'success']);
    }
    //充值账单
    public  function accountrecord() {
        $uid = input('uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        $acountrf = db('balance')->where(['uid'=>$uid,'isshow'=>1,'bptype'=>['IN', [1,3]]])->order('bpid desc')->select();
        $dealhis = [];
        $types = [1=>'充值',2=>'手动加款',3=>'正在充值',4=>'取消','5'=>'提现','6'=>'手动扣款',7=>'邀请奖励'];
        foreach($acountrf  as $key=>$val) {
            $dealhis[$key]['utime'] = date('Y-m-d H:i:s',$val['bptime']);
            $dealhis[$key]['reg_par'] = $val['reg_par'];
            $dealhis[$key]['realprice'] = $val['realprice'];
            //$dealhis[$key]['typedesc'] =$types[$val['bptype']];
            $dealhis[$key]['typedesc'] =$types[1];
            $dealhis[$key]['money'] = $val['bpprice'];
            $dealhis[$key]['isverified']= $val['isverified'];
            $dealhis[$key]['bptype'] = $val['bptype'];
			if($val['isverified']==1){
				$dealhis[$key]['is_verify']='审核通过';
			}elseif($val['isverified']==2){
				$dealhis[$key]['is_verify']='拒绝';
			}elseif($val['isverified']==0){
				$dealhis[$key]['is_verify']='待审核';
			}else{
				$dealhis[$key]['is_verify']='审核中';
			}
            $dealhis[$key]['remarks'] = $val['remarks'];
        }
       return json(['code'=>200,'data'=>$dealhis,'msg'=>'success']);
    }
    //提现账单
    public  function withdrawrecord() {
        $uid = input('uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        $acountrf = db('balance')->where(['uid'=>$uid,'isshow'=>1,'bptype'=>5])->order('bpid desc')->select();
        $dealhis = [];
        $types = [1=>'充值',2=>'手动加款',3=>'正在充值',4=>'取消','5'=>'提现','6'=>'手动扣款',7=>'邀请奖励'];
        foreach($acountrf  as $key=>$val) {
            $dealhis[$key]['utime'] = date('Y-m-d H:i:s',$val['bptime']);
            $dealhis[$key]['reg_par'] = $val['reg_par'];
            $dealhis[$key]['realprice'] = $val['realprice'];
            $dealhis[$key]['typedesc'] =$types[$val['bptype']];
            $dealhis[$key]['money'] = $val['bpprice'];
            $dealhis[$key]['isverified']= $val['isverified'];
            $dealhis[$key]['bptype'] = $val['bptype'];
			if($val['isverified']==1){
				$dealhis[$key]['is_verify']='审核通过';
			}elseif($val['isverified']==2){
				$dealhis[$key]['is_verify']='拒绝';
			}elseif($val['isverified']==0){
				$dealhis[$key]['is_verify']='待审核';
			}else{
				$dealhis[$key]['is_verify']='审核中';
			}
            $dealhis[$key]['remarks'] = $val['remarks'];
        }

       return json(['code'=>200,'data'=>$dealhis,'msg'=>'success']);
    }
    //平台公告
    public  function historynotice() {
        $notices = db('notice')->field('title,content,time')->where(['state'=>1])->order('id desc')->limit(6)->select();
        return json(['code'=>200,'data'=>$notices,'msg'=>'success']);
    }
    //银行卡
    public  function bankcard() {
        $uid = input('post.uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        $bankcards = db('bankcard')->field('*')->where(['uid'=>$uid])->find();
        return json(['code'=>200,'data'=>$bankcards,'msg'=>'success']);
    }
    //暂时不用
    public  function card_reset() {
        $uid = input('post.uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        $res = db('bankcard')->where(['uid'=>$uid])->delete();
        if($res){
            return WPreturn('银行卡解绑成功', 1);
        }else{
            return WPreturn('银行卡解绑失败');
        }
    }
    //提现密码修改
    public function modityepwd()
    {
        $post = input('post.');
        if (request()->isPost() && $post['uid'] > 0) {
            $user = Db::name('userinfo')->where('uid', $post['uid'])->find();
            if ($user['upwd'] != $post['loginpwd']) {
                return json(['code'=>-11,'data'=>[],'msg'=>'登录密码不正确']);
            }
            if ($post['password'] != $post['cpassword']) {
                return json(['code'=>-12,'data'=>[],'msg'=>'新提现密码与确认密码不一致']);
            }
            $flag = Db::name('userinfo')->where('uid', $post['uid'])->update(['epwd' => $post['password']]);
            if ($flag) {
                return json(['code'=>200,'data'=>[],'msg'=>'success']);
            } else {
                return json(['code'=>-13,'data'=>$flag,'msg'=>'修改失败']);
            }
        }
    }
    //登录密码修改
    public function moditypwd() {
        $post = input('post.');
        if(request()->isPost() && $post['uid'] > 0){
            $user = Db::name('userinfo')->where('uid', $post['uid'])->find();
            $loginpwd = $post['loginpwd'];
            if($user['upwd'] != $loginpwd){
                return json(['code'=>-11,'data'=>[],'msg'=>'登录密码不正确']);
            }
            if($post['password'] != $post['cpassword']){
                return json(['code'=>-15,'data'=>[],'msg'=>'新登录密码与确认密码不一致']);
            }
            $upwd = $post['password'];
            if($user['upwd'] == $upwd){
                return json(['code'=>-16,'data'=>[],'msg'=>'新登录密码与原密码相同']);
            }
            $flag = Db::name('userinfo')->where('uid',$post['uid'])->update(['upwd'=>$upwd]);
            if($flag){
                return json(['code'=>200,'data'=>[],'msg'=>'success']);
            }else{
                return json(['code'=>-13,'data'=>[],'msg'=>'修改失败']);
            }
        }
    }
    //重置密码
    public  function  respwd() {
      $uid = input('post.uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
      $data = input('post.');

      $pwd  = $data['oldpwd'];
      $name =$data['name'];

      $newpwd = $data['newpwd'];
      $newpwd2 = $data['newpwd2'];
      $res = db('userinfo')->where(['uid'=>$uid,'upwd'=>$pwd])->select();
      // dump($data);
      $row = array('upwd'=>$newpwd,'username'=>$name);
      if($res && ($newpwd==$newpwd2)){
          $ok = db('userinfo')->where(['uid'=>$uid,'upwd'=>$pwd])->update($row);

          if($ok){
          return json_encode(1);
          }else{
        return json_encode(0);
          }
      }else{
            return json_encode(0);
      }

    }



    public  function  palyStep() {
        return $this->fetch();
    }


    public  function  loginout() {
        unset($_SESSION['uid']);
        $this->redirect(url('index/login/login',['t'=>time()]));
    }
    
    public function getconf() {
        $conf = getconf();
        foreach($conf as $key => $item){
            if($key == 'sys_app_url'){
                $conf[$key] = (isHTTPS() ? 'https://' : 'http://').$_SERVER['HTTP_HOST'].'/app';
            }
        }
        return json(['code'=>200,'data'=>$conf,'msg'=>'success']);
    }

    /**
     * 用户的提现功能
     * @return mixed|string
     */
    public function withdrawinfo(){
        $uid = input('uid');
        $type = input('type', 1, 'floatval');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        if($type == 1){
            $bankinfo = db('bankinfo')->where(['uid'=>$uid])->order('id desc')->find();
            $user = db('userinfo')->where('uid', $uid)->field("usermoney,username,ustatus,nickname")->find();
            if(!$bankinfo){
                return json(['code'=>200,'data'=>['bankinfo'=>NULL],'msg'=>'']);
            }else{
                return json(['code'=>200,'data'=>['bankinfo'=>$bankinfo,'userinfo'=>$user,'reg_par'=>$this->conf['reg_par']],'msg'=>'success']);
            }
        }else{
            $bankinfo = db('bankcard')->where(['uid'=>$uid])->order('id desc')->find();
            $user = db('userinfo')->where('uid', $uid)->field("usermoney,username,ustatus,nickname")->find();
            if(!$bankinfo){
                return json(['code'=>200,'data'=>['bankinfo'=>NULL],'msg'=>'']);
            }else{
                return json(['code'=>200,'data'=>['bankinfo'=>$bankinfo,'userinfo'=>$user,'reg_par'=>$this->conf['reg_par']],'msg'=>'success']);
            }
        }
    } 
    //提现提交
    public function withdraw() {
        if(input('post.')){
            $data = input('post.');
            if($data){
                $uid = $data['uid'];
                $type = $data['type'];
                if(!$uid){
                    return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
                }
                if(!$data['price']){
                    return json(['code'=>-17,'data'=>[],'msg'=>'请输入提现金额']);
                }
				if(empty($data['bankcardno'])){
					 return json(['code'=>-18,'data'=>[],'msg'=>'请设置提现银行卡']);
				}
                //验证申请金额
                $user = Db::name('userinfo')->where('uid', $uid)->find();
                if($user['ustatus'] == 1){
        			return json(['code'=>-19,'data'=>[],'msg'=>'您的账户已被冻结,请联系在线客服！']);
        		}
        		
        		if($user['ustatus'] == 2){
        			return json(['code'=>-20,'data'=>[],'msg'=>'您的账户已被限制交易,请联系在线客服！']);
        		}
                $conf = $this->conf;
                if($conf['is_cash'] != 1){
                    return json(['code'=>-21,'data'=>[],'msg'=>'抱歉！暂时无法出金']);
                }
                if($conf['cash_min'] > $data['price']){
                    return json(['code'=>-22,'data'=>[],'msg'=>'单笔最低提现金额为：'.$conf['cash_min']]);
                }
                if($conf['cash_max'] < $data['price']){
                  return json(['code'=>-23,'data'=>[],'msg'=>'单笔最高提现金额为：'.$conf['cash_max']]);
                }

                $epwd = $data['passwd'];
                if($user['upwd'] != $epwd){
                    return json(['code'=>-24,'data'=>[],'msg'=>'提款密码不正确']);
                }

                $_map['uid'] = $uid;
                $_map['bptype'] = 5;
                $_map['isverified'] = array('neq',2);
                $cash_num = db('balance')->where($_map)->whereTime('bptime', 'd')->count();

                if($cash_num + 1 > $conf['day_cash']){
                    return json(['code'=>-25,'data'=>[],'msg'=>'每天最多提现'.$conf['day_cash'].'次']);
                }
                $cash_day_max = db('balance')->where($_map)->whereTime('bptime', 'd')->sum('bpprice');
                if($conf['cash_day_max'] < $cash_day_max + $data['price']){
                    return json(['code'=>-26,'data'=>[],'msg'=>'当日累计最高提现金额为：'.$conf['cash_day_max']]);
                }



                $statrdate=Db::name("config")->where("name='role_ks'")->select();
                $txstatrdate = $statrdate[0]['value']?$statrdate[0]['value']:'9:00';
                $starttime = str_replace(':','',$txstatrdate);
				
				
                $enddate=Db::name("config")->where("name='role_js'")->select();
                $txenddate= $enddate[0]['value']?$enddate[0]['value']:'22:00';
                $endtime = str_replace(':','',$txenddate);
				if(date('Gi') < intval($starttime) || date('Gi') >  intval($endtime)){
					return json(['code'=>-27,'data'=>[],'msg'=>'出金时间为'.$txstatrdate.'-'.$txenddate]);
				}

				if($conf['sys_yue_benjin']==1){
					$user['usermoney'] = $user['usermoney']-$user['freeze']>0 ? $user['usermoney']-$user['freeze'] : 0;
				}

                //代理商的话判断金额是否够
                if($user['otype'] == 101){
                    if( ($user['usermoney'] - $data['price']) < $user['minprice'] ){
                        return json(['code'=>-28,'data'=>[],'msg'=>'提现后余额不得少于保证金，您的保证金是'.$user['minprice']]);
                    }
                }

                if( ($user['usermoney'] - $data['price']) < 0){
                    return json(['code'=>-29,'data'=>[],'msg'=>'最多提现金额为'.$user['usermoney']]);
                }

                $reg_par = round($conf['reg_par']*$data['price']/100,2);
                // if($data['price']+$reg_par>$user['usermoney']){
                //     $realprice = $user['usermoney'] - $reg_par;
                // }else{
                //     $realprice = $data['price'];
                // }


                //签约信息
              //  $mybank = db('bankcard')->where('uid',$uid)->find();

                //提现申请
                $newdata['pay_type'] = intval($type) == 0 ? 'bankinfo' : 'bankcard';
                $newdata['bpprice'] = $data['price'];
                $newdata['bptime'] = time();
                $newdata['bptype'] = 5;
                $newdata['remarks'] = 'Withdrawal';
                $newdata['uid'] = $uid;
                $newdata['isverified'] = 0;
                $newdata['bpbalance'] = 0;
                $newdata['bankid'] =input('bankid');   // $data['bankcardno'];
                $newdata['btime'] = time();
                $newdata['reg_par'] = $reg_par;
                $newdata['realprice'] = $data['price'] - $reg_par;

                //$withmoney = ($realprice + $reg_par);
                $withmoney = $data['price'];
                $bpid = Db::name('balance')->insertGetId($newdata);
                if($bpid){
                    //插入申请成功后,扣除金额
                    $editmoney = Db::name('userinfo')->where('uid',$uid)->setDec('usermoney',$withmoney);
                    if($editmoney){
                        //插入此刻的余额。
                        $usermoney = Db::name('userinfo')->where('uid',$uid)->value('usermoney');
                        Db::name('balance')->where('bpid',$bpid)->update(array('bpbalance'=>$usermoney));
                        //资金日志
                        set_price_log($uid,2,$data['price'],'提现','提现申请',$bpid,$usermoney);

                        return json(['code'=>200,'data'=>[],'msg'=>'success']);
                    }else{
                        //扣除金额失败，删除提现记录
                        Db::name('balance')->where('bpid',$bpid)->delete();
                        return json(['code'=>-30,'data'=>[],'msg'=>'提现失败！']);
                    }

                }else{
                    return json(['code'=>-30,'data'=>[],'msg'=>'提现失败！']);
                }

            }
        }
    }
    
    //添加提币地址
    public  function  add_usdt() {
        if (input('post.')) {
            $data = input('post.');
            $uid = $data['uid'];
            if(!$uid){
                return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
            }
            $item = db('bankinfo')->where(['uid'=>$uid,'isdelete'=>0])->find();
            if($item){
                return json(['code'=>-32,'data'=>[],'msg'=>'您已经绑卡了,请联系客服处理']);
            }
            $arr = [
                'address'=>$data['address'], //卡号
                'qrcode'=>$data['qrcode'], //持卡人用户名
                'uid'=>$uid,  //用户的uid
                'name'=>'USDT', //手机号码
            ];
            $res= db('bankinfo')->insert($arr);
            return json(['code'=>200,'data'=>$res,'msg'=>'success']);
        }
    }

    //添加银行卡
    public  function  add_bank() {
        if (input('post.')) {
            $data = input('post.');
			if(!$data['bankno']){
			    return json(['code'=>-18,'data'=>[],'msg'=>'请设置提现银行卡']);
			}
            $uid = $data['uid'];
            if(!$uid){
                return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
            }
            $item = db('bankcard')->where(['accntno'=>$data['bankno'],'isdelete'=>0])->find();
            if($item){
                return json(['code'=>-70,'data'=>[],'msg'=>'银行卡已存在']);
            }
            $item = db('bankcard')->where(['uid'=>$uid,'isdelete'=>0])->find();
            if($item){
                return json(['code'=>-32,'data'=>[],'msg'=>'您已经绑卡了,请联系客服处理']);
            }
            // $user = db('userinfo')->field('nickname')->where(['uid'=>$uid])->find();
            // if($user['nickname'] && $user['nickname']!=$data['accntnm']){
            //     return json(['code'=>-33,'data'=>[],'msg'=>'持卡人姓名与注册姓名不一致，请联系客服处理']);
            // }
            $arr = [
                'accntno'=>$data['bankno'], //卡号
                'accntnm'=>$data['accntnm'], //持卡人用户名
                'uid'=>$uid,  //用户的uid
                'phone'=>$data['phone'], //手机号码
               'address'=>$data['banksmall'], //分行地址
                'content'=>$data['bankname']
            ];
            $res= db('bankcard')->insert($arr);
            return json(['code'=>200,'data'=>$res,'msg'=>'success']);
        }
    }

    // 找回提款密码
    public function forgot(){
        if (!$this->uid) {
            $this->redirect(url('/index/login/login'));
        }
        if(request()->isPost()){
            $post = input('post.');
            $user = $user;
            $loginpwd = $post['loginpwd'];
            if($user['upwd'] != $loginpwd){
                return WPreturn('登录密码不正确');
            }
            if($post['password'] != $post['cpassword']){
                return WPreturn('提款密码与确认密码不一致');
            }
            $epwd = $post['password'];
            $flag = Db::name('userinfo')->where('uid',$this->uid)->update(['epwd'=>$epwd]);
            if($flag){
                return WPreturn('找回提款密码成功', 1);
            }else{
                return WPreturn('找回提款密码失败');
            }
        }else{
            return $this->fetch();
        }
    }

	public function userinvest() {
        $uid = input('get.uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        $list = db('userinvest')->where(['uid'=>$uid])->order('id desc')->select();
        $arr1 = [];
        $arr2 = [];
        foreach($list as $k=>$v){
            if($v['state'] == 1){
                $arr1[] = $v;
            }else{
                $arr2[] = $v;
            }
        }
        $data['incustodymoney'] = 0;
        $data['estimateincome'] = 0;
        foreach($arr1 as $k=>$v){
            $data['incustodymoney'] += $v['money'];
            $data['estimateincome'] += $v['interest'];
        }
        $data['totalincome'] = 0;
        foreach($arr2 as $k=>$v){
            $data['totalincome'] += $v['interest'];
        }
        
        $data['incustodynum'] = count($arr1);
        return json(['code'=>200,'data'=>$data,'msg'=>'success']);
	}
	
	public function investhistory() {
        $uid = input('get.uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
        
        
        $list = Db::name('userinvest')->where(['uid'=>$uid])->order('id desc')->paginate(input('get.limit'),false,['type' => 'Bootstrap','var_page' => 'page','page' => input('get.page')]);
        $list->getCollection()->each(function ($item, $index) use ($list) {
            $item['time'] = date('Y-m-d H:i:s', $item['time']);
            $item['totime'] = date('Y-m-d H:i:s', $item['totime']);
            $list->offsetSet($index, $item);
        });
        return json(['code'=>200,'data'=>$list,'msg'=>'success']);
	}

	public function invest() {
	    $list = Db::name('invest')->table('wp_invest i,wp_view_proinfo p')->where('i.proid = p.pid AND i.state = 1')->field('i.*,p.Name')->select();
        return json(['code'=>200,'data'=>$list,'msg'=>'success']);
	}

	public function idetail() {
		$uid = input('post.uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
		$pid = input('pid',0,'intval');
        $item = db('invest')->where(['state'=>1,'pid'=>$pid])->find();
        if(!$item){
            return WPreturn('投资项目不存在');
        }
		$this->assign('item',$item);
        return $this->fetch();
	}

	public function doinvest() {
        $uid = input('post.uid');
        if(!$uid){
            return json(['code'=>-1,'data'=>[],'msg'=>'账号ID无效']);
        }
		$pid = input('pid',0,'intval');
		$money = input('money',0,'intval');
		$user = db('userinfo')->where(['uid'=>$uid])->find();
        $item = db('invest')->where(['state'=>1,'pid'=>$pid])->find();
        $pro = db('productdata')->where(['pid'=>$item['proid']])->find();
        if(!$item){
            return json(['code'=>-34,'data'=>[],'msg'=>'投资项目不存在']);
        }
		if($money < $item['min']){
		    return json(['code'=>-35,'data'=>[],'msg'=>'投资金额必须大于最小起投金额']);
		}
		if($money > $user['usermoney']) {
			return json(['code'=>-36,'data'=>[],'msg'=>'投资失败，您的可用余额不足']);
		}
        Db::startTrans();
		if($this->conf['sys_yue_benjin']==2){
			$benjin = db('userinfo')->where(['uid'=>$uid])->setDec('usermoney',$money);
		}
		$flag = db('userinfo')->where(['uid'=>$uid])->setInc('freeze',$money);
		if($flag){
			//投资
			$idata['pid'] = $pid;
			$idata['money'] = $money;
			$idata['interest'] = round($money * $item['rates'] / 100, 2);
			$idata['Name'] = $pro['Name'];
			$idata['days'] = $item['days'];
			$idata['uid'] = $user['uid'];
			$idata['username'] = $user['username'];
			$idata['state'] = 1;
			$idata['time'] = time();
			if(0){  //if(date('H')<22){
				$idata['totime'] = strtotime(date('Y-m-d',strtotime('+'.$item['days'].' day')))+9*3600;
			}else{
				$idata['totime'] = strtotime('+'.$item['days'].' day');
			}

			$id = db('userinvest')->insertGetId($idata);
			if($id){
				//资金日志
				if($this->conf['sys_yue_benjin']==2){
					set_price_log($uid,2,$money,'利息宝','投资',$id,$user['usermoney']);
				}
				Db::commit();
				return json(['code'=>200,'data'=>[],'msg'=>'success']);
			}else{
			    Db::rollback();
				return json(['code'=>-37,'data'=>[],'msg'=>'投资失败']);
			}
		}else{
		    Db::rollback();
			return json(['code'=>-38,'data'=>[],'msg'=>'投资失败，余额不足']);
		}
	}

}
