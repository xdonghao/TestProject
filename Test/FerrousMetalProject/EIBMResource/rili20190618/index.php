<?php

if( is_file('api/config.php') ){
	include 'api/config.php';
	if(isset($qudao)==false  ){
		header("location:install.php");
	}
	
}else{
	header("location:install.php");
}

?>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>财经日历</title>

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>   
	<meta name="csrf-token" content=""/>

 

            <link rel="stylesheet" type="text/css" href="style/css/style-commons.css"/>
    <link rel="stylesheet" type="text/css" href="style/css/ucenterUI.css">

    <link rel="stylesheet" type="text/css" href="style/css/style-rili.css"/>
    <style>
        body {
            padding: 0;
        }
    </style>

    
        
        
        

    
</head>
<body >
<div class="l-wrap">
    
        <div class="jin-rili">
    <div class="jin-rili_header">
        <div class="jin-rili_tab">
            <ul id="J_rili_tab" class="jin-rili_tab-list">
                <li class="jin-rili_tab-item J_rili_tabItem active">数据</li>
                <li class="jin-rili_tab-item J_rili_tabItem">事件</li>
                <li class="jin-rili_tab-item J_rili_tabItem">假期</li>
            </ul>
        </div>
        <div class="jin-rili_header-btn">
            <a href="javascript:;" id="J_datepicker_btn">
                <i class="jin-icon jin-icon_calendar1"></i>
                <input readonly="true" value="12" class="calendars" type="text">
            </a>
            <a href="javascript:;" class="J_riliFilterBtn">
                <i class="jin-icon jin-icon_filter"></i>
            </a>
        </div>
    </div>
    <!-- 选择星期 -->
    <div id="J_riliWeeks" class="jin-rili_week">
    </div>
    <div class="jin-rili_body">
        <!-- 经济数据一览 -->
        <div class="jin-rili_content J_rili_content">
            <!-- 标题 -->
            <div class="jin-rili_content-h">
                <!-- 筛选 -->
                <a href="javascript:;" class="jin-rili_filter J_riliFilterBtn">
                    <i class="jin-icon jin-icon_filter"></i><span>筛选</span>
                </a>
                <!-- 选择日历 -->
                <div class="jin-rili_calendar">
                    <i class="jin-icon jin-icon_calendar1"></i>
                    <input id="J_datepicker" type="text" name="" value="">
                </div>
                <h3 class="jin-rili_content-title"><span class="J_riliDateTitle"></span>经济数据一览</h3>
            
            </div>
            <div class="jin-rili_content-b">
                <div class="jin-table">
                    <div class="jin-table-head is-open-page J_rili_table_head">
                        <div data-type="fixed">
                            <div class="jin-table-head_wrap">
                                <div style="width: 7%;" class="jin-table-head_item">时间</div>
                                <div style="width: 5%;" class="jin-table-head_item">国/区</div>
                                <div style="width: 34%;" class="jin-table-head_item">指标名称</div>
                                <div style="width: 10%;" class="jin-table-head_item">重要性</div>
                                <div style="width: 8%" class="jin-table-head_item">前值</div>
                                <div style="width: 8%;" class="jin-table-head_item">预测值</div>
                                <div style="width: 9%" class="jin-table-head_item">公布值</div>
                                <div style="width: 13%" class="jin-table-head_item">
                                    <div class="jin-rili_content-selKind">
                                        <a href="javascript:;" id="J_selKind" class="jin-select"><span>影响</span><i class="jin-icon jin-icon_expand"></i></a>
                                    </div>
                                </div>
                    
                            </div>
                        </div>
                    </div>
                    <table class="jin-table_body">
                        <colgroup>
                            <col width="7%" />
                            <col width="5%" />
                            <col width="34%" />
                            <col width="10%" />
                            <col width="8%" />
                            <col width="8%" />
                            <col width="9%" />
                            <col width="13%" />
                        </colgroup>
                        <tbody id="J_economicsWrap">
                            <tr>
                                <td colspan="9">加载中......</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!-- 财经大事一览 -->
        <div class="jin-rili_content J_rili_content">
            <!-- 标题 -->
            <div class="jin-rili_content-h">
                <h3 class="jin-rili_content-title"><span class="J_riliDateTitle"></span>财经大事一览</h3>
            </div>
            <div class="jin-rili_content-b">
                <div class="jin-table">
                    <div class="jin-table-head is-open-page J_rili_table_head">
                        <div data-type="fixed">
                            <div class="jin-table-head_wrap">
                                <div style="width: 8%;" class="jin-table-head_item">时间</div>
                                <div style="width: 10%;" class="jin-table-head_item">国家/地区</div>
                                <div style="width: 15%;" class="jin-table-head_item">城市</div>
                                <div style="width: 12%;" class="jin-table-head_item">重要性</div>
                                <div style="width: 47%;" class="jin-table-head_item">事件</div>
                            </div>
                        </div>
                    </div>
                </div>
                <table class="jin-table_body">
                    <colgroup>
                        <col width="8%" />
                        <col width="10%" />
                        <col width="15%" />
                        <col width="12%" />
                        <col width="47%" />
                    </colgroup>
                    <tbody id="J_eventWrap">
                        <tr>
                            <td colspan="5">加载中......</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 假期休市一览 -->
        <div class="jin-rili_content J_rili_content">
            <!-- 标题 -->
            <div class="jin-rili_content-h">
                <h3 class="jin-rili_content-title"><span class="J_riliDateTitle"></span>假期休市一览</h3>
            </div>
            <div class="jin-rili_content-b">
                <div class="jin-table">
                    <div class="jin-table-head is-open-page J_rili_table_head">
                        <div data-type="fixed">
                            <div class="jin-table-head_wrap">
                                <div style="width: 15%;" class="jin-table-head_item">时间</div>
                                <div style="width: 15%;" class="jin-table-head_item">国家/地区</div>
                                <div style="width: 20%;" class="jin-table-head_item">市场</div>
                                <div style="width: 15%;" class="jin-table-head_item">节日名称</div>
                                <div style="width: 35%;" class="jin-table-head_item">详细安排</div>
                            </div>
                        </div>
                    </div>
                    <table class="jin-table_body">
                        <colgroup>
                            <col width="15%" />
                            <col width="15%" />
                            <col width="20%" />
                            <col width="15%" />
                            <col width="35%" />
                        </colgroup>
                        <tbody id="J_holidayWrap">
                            <tr>
                                <td colspan="5">加载中......</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div id="J_rili_list" class="jin-rili_list">
        <ul id="J_economicsWrapMobile" class="jin-rili_list-wrap J_rili_listItem">
            <li class="jin-rili_list-empty">
                <img src="style/img/empty_rili.png">
                <p>加载中......</p>
            </li>
        </ul>
        <ul id="J_eventWrapMobile" class="jin-rili_list-wrap J_rili_listItem">
            <li class="jin-rili_list-empty">
                <img src="style/img/empty_event.png">
                <p>加载中......</p>
            </li>
        </ul>
        <ul id="J_holidayWrapMobile" class="jin-rili_list-wrap J_rili_listItem">
            <li class="jin-rili_list-empty">
                <img src="style/img/empty_holiday.png">
                <p>加载中......</p>
            </li>
        </ul>
    </div>
</div>
<script id="J_rili_filterTpl" type="text/template">
    <div class="jin-rili_filter-box">
        <div class="jin-rili_filter-item">
            <h3 class="jin-rili_filter-title">状 态</h3>
            <div class="jin-rili_filter-list">
                <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch active" data-name="all">全 部</a>
                <a href="/" class="jin-rili_filter-btn">今日</a>
                <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-name="未公布" data-type="actual">未公布</a>
                <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-name="重要" data-type="important">重要</a>
            </div>
        </div>
        <div class="jin-rili_filter-item">
            <h3 class="jin-rili_filter-title">按照国家/地区条件查询</h3>
            <div class="l-cell">
                <div class="l-cell_item jin-rili_filter-l">
                    <h4>地 区</h4>
                </div>
                <div class="l-cell_item jin-rili_filter-r">
                    <div class="jin-rili_filter-list">
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch active" data-name="all">全 部</a>
                    </div>
                </div>
            </div>
            <div class="l-cell">
                <div class="l-cell_item jin-rili_filter-l">
                    <h4>欧 洲</h4>
                </div>
                <div class="l-cell_item jin-rili_filter-r">
                    <div class="jin-rili_filter-list">
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="欧元区">欧元区</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="德国">德 国</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch  " data-type="country" data-name="英国">英 国</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch  " data-type="country" data-name="法国">法 国</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch  " data-type="country" data-name="瑞士">瑞 士</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch  " data-type="country" data-name="意大利">意大利</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="西班牙">西班牙</a>
                    </div>
                </div>
            </div>
            <div class="l-cell">
                <div class="l-cell_item jin-rili_filter-l">
                    <h4>北 美</h4>
                </div>
                <div class="l-cell_item jin-rili_filter-r">
                    <div class="jin-rili_filter-list">
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="美国">美 国</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="加拿大">加拿大</a>
                    </div>
                </div>
            </div>
            <div class="l-cell">
                <div class="l-cell_item jin-rili_filter-l">
                    <h4>亚 洲</h4>
                </div>
                <div class="l-cell_item jin-rili_filter-r">
                    <div class="jin-rili_filter-list">
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch" data-type="country" data-name="中国">中 国</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="日本">日 本</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="韩国">韩 国</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="印度">印 度</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="香港">香 港</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="台湾">台 湾</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="新加坡">新加坡</a>
                    </div>
                </div>
            </div>
            <div class="l-cell">
                <div class="l-cell_item jin-rili_filter-l">
                    <h4>澳 洲</h4>
                </div>
                <div class="l-cell_item jin-rili_filter-r">
                    <div class="jin-rili_filter-list">
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="澳大利亚">澳大利亚</a>
                        <a href="javascript:;" class="jin-rili_filter-btn J_riliFilterSwitch " data-type="country" data-name="新西兰">新西兰</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>
    
    </div>
        <script type="text/javascript" src="style/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="style/js/underscore-min.js"></script>
    <script src="style/js/rsa.js"></script>
    <script src="style/js/main.js"></script>

    <script type="text/javascript" src="style/js/socket.io.js"></script>
    <script type="text/javascript" src="style/js/chunk.js"></script>
    <script type="text/javascript" src="style/js/commons.js"></script>
    <script type="text/javascript" src="style/js/riliV1.js"></script>
 
</body>
</html>