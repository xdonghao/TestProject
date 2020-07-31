<?php
header('content-type:text/json;charset=utf8');
include 'config.php';
include 'functions.php';

if(isset($_GET['date'])){
	$date = str_split($_GET['date'],4);
}else{
	$date[0]=date('Y',time());
	$date[1]=date('md',time());
}

if($qudao==1){
	//阿里云
	$base_url = 'http://calendar.market.alicloudapi.com/v4/';
}elseif($qudao==2){
	//api51
	$base_url = 'http://data.api51.cn/apis/rili/';
}
$type = $_GET['type'];
if($type=='gettime'){
	$res['now']=time();
	$res['date']=date('Y-m-d H:i:s',time());
	echo json_encode($res);
}else{
	$rand = $_GET['_'];
$url = $base_url."?date=".$date[0].$date[1]."&type=".$type."&_=".$rand."&token=".$token;
 //echo $url;



		//缓存begin
							$path = '../datas';
							//以请求地址作为缓存路径
		$code = $date[0].$date[1].$type;
		//以请求参数为缓存名称，同一个参数缓存一次
		$file_dir = $path.'/';
		$dir=   $file_dir.$code.'.json';
	 	//$result = file_get_contents($dir);
     
		if(is_dir($file_dir)){
		//	 echo 1;
				if( is_file($dir) ){
			//		 echo 2;
			//文件存在，判断时间再 读取
			$left_time =time() - filemtime($dir);
			//echo $left_time;
					if($left_time>10){
						// echo 3;
						//大于设定的时间，需要请求
						$result = api51_curl($url,'',0,$appcode);
						//echo $result;
						$test_arr  = strlen($result);
						if($test_arr>file_get_contents($dir)){
						file_put_contents($dir, $result);//更新缓存文件
						}else{
							$result = file_get_contents($dir);
						}
						
					}else{
						 //echo 4;
						//echo $dir;
						//小于等于设定的时间，不需要请求，直接获取缓存数据
						$result = file_get_contents($dir);
						//echo $result;
					}
				}else{
						// echo "文件不存在，获取";
						$result = $result = api51_curl($url,'',0,$appcode);
						file_put_contents($dir, $result);//创建文件
				}
		}else{
			mkdir($file_dir,0777,true); //创建文件夹
			$result = $result = api51_curl($url,'',0,$appcode);
			file_put_contents($dir, $result);//创建文件
			}
		//缓存end
            /* */
		echo $result;

}
?>