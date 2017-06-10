<%--
  Created by IntelliJ IDEA.
  User: wangty
  Date: 2017/6/3
  Time: 下午8:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();

%>
<!doctype html>
<html lang = zh-CN>
<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="<%=contextPath%>/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" sizes="96x96" href="<%=contextPath%>/assets/img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Quantour III</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="<%=contextPath%>/assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="<%=contextPath%>/assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="<%=contextPath%>/assets/css/paper-dashboard.css" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <%--<link href="<%=contextPath%>/assets/css/demo.css" rel="stylesheet" />--%>


    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="<%=contextPath%>/assets/css/themify-icons.css" rel="stylesheet">

    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script>
    <script src="<%=contextPath%>/assets/js/echarts.js"></script>

    <script type="text/javascript">

        function getKLine1Info(code){

            var sdate = document.getElementById("sDate").value;
            var ldate = document.getElementById("lDate").value;
            var code = String(code);

            while(code.length < 6){
                code = "0" + code;
            }
//            alert(code);

            $.ajax({
                url: '<%=request.getContextPath()%>/stockinfo/getDayKLineInfo',
                data: {codeid:code, sdate:sdate, ldate:ldate},
                dataType: "json",
                success: function (result) {
                    klinedata = JSON.parse(result);
                    fillCharts1(klinedata,code);
                },
                error:function () {
                    alert("!");
                }
            });

        }
        function getKLine2Info(code){

            var sdate = document.getElementById("sDate").value;
            var ldate = document.getElementById("lDate").value;
            var code = String(code);

            while(code.length < 6){
                code = "0" + code;
            }
//            alert(code);

            $.ajax({
                url: '<%=request.getContextPath()%>/stockinfo/getDayKLineInfo',
                data: {codeid:code, sdate:sdate, ldate:ldate},
                dataType: "json",
                success: function (result) {
                    klinedata = JSON.parse(result);
                    fillCharts2(klinedata,code);
                },
                error:function () {
                    alert("!");
                }
            });

        }

        function splitData(rawdata) {
            var categoryData = [];
            var values = [];
            for (var i = 0; i < rawdata.length; i++) {
                categoryData.push(rawdata[i].splice(0,1)[0]);
                values.push(rawdata[i]);
            }
            return {
                categoryData: categoryData,
                values: values
            };
        }

        function calculateMA(dayCount,data) {
            var result = [];
            for (var i = 0, len = data0.values.length; i < len; i++) {
                if (i < dayCount) {
                    result.push('-');
                    continue;
                }
                var sum = 0;
                for (var j = 0; j < dayCount; j++) {
                    sum += data0.values[i - j][1];
                }
                result.push(sum / dayCount);
            }
            return result;
        }


        function fillCharts1(rawdata,codeid){
            var daykline1 = echarts.init(document.getElementById('dayKLine1'));

//            alert("!");

            data0 = splitData(rawdata);

            daykline1.setOption(my_option ={
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross'
                        }
                    },
                    title:{
                        text: codeid+":k线图",
                        textStyle:{
                            fontSize: 16
                        },
                        left: 40
                    },
                    legend: {
                        data: ['日K', 'MA5', 'MA10', 'MA20', 'MA30']
                    },
                    toolbox: {
                        show: true,
                        feature: {
                            dataZoom: {
                                yAxisIndex: 'none'
                            },
                            saveAsImage: {}
                        },
                        right:20
                    },
                    grid: {
                        left: '10%',
                        right: '10%',
                        bottom: '15%'
                    },
                    xAxis: {
                        type: 'category',
                        data: data0.categoryData,
                        scale: true,
                        boundaryGap : false,
                        axisLine: {onZero: false},
                        splitLine: {show: false},
                        splitNumber: 20,
                        min: 'dataMin',
                    },
                    yAxis: {
                        scale: true,
                        splitArea: {
                            show: true
                        }
                    },
                    dataZoom: [
                        {
                            type: 'inside',
                            start: 95,
                            end: 100
                        },
                        {
                            show: true,
                            type: 'slider',
                            y: '90%',
                            start: 95,
                            end: 100
                        }
                    ],
                    series: [
                        {
                            name: '日K',
                            type: 'candlestick',
                            data: data0.values,
                            markPoint: {
                                label: {
                                    normal: {
                                        formatter: function (param) {
                                            return param != null ? Math.round(param.value) : '';
                                        }
                                    }
                                },
                                data: [
                                    {
                                        name: 'XX标点',
                                        coord: ['2013/5/31', 2300],
                                        value: 2300,
                                        itemStyle: {
                                            normal: {color: 'rgb(41,60,85)'}
                                        }
                                    },
                                    {
                                        name: 'highest value',
                                        type: 'max',
                                        valueDim: 'highest'
                                    },
                                    {
                                        name: 'lowest value',
                                        type: 'min',
                                        valueDim: 'lowest'
                                    },
                                    {
                                        name: 'average value on close',
                                        type: 'average',
                                        valueDim: 'close'
                                    }
                                ],
                                tooltip: {
                                    formatter: function (param) {
                                        return param.name + '<br>' + (param.data.coord || '');
                                    }
                                }
                            },
                            markLine: {
                                symbol: ['none', 'none'],
                                data: [
                                    [
                                        {
                                            name: 'from lowest to highest',
                                            type: 'min',
                                            valueDim: 'lowest',
                                            symbol: 'circle',
                                            symbolSize: 10,
                                            label: {
                                                normal: {show: false},
                                                emphasis: {show: false}
                                            }
                                        },
                                        {
                                            type: 'max',
                                            valueDim: 'highest',
                                            symbol: 'circle',
                                            symbolSize: 10,
                                            label: {
                                                normal: {show: false},
                                                emphasis: {show: false}
                                            }
                                        }
                                    ],
                                    {
                                        name: 'min line on close',
                                        type: 'min',
                                        valueDim: 'close'
                                    },
                                    {
                                        name: 'max line on close',
                                        type: 'max',
                                        valueDim: 'close'
                                    }
                                ]
                            }
                        },
                        {
                            name: 'MA5',
                            type: 'line',
                            data: calculateMA(5,data0),
                            smooth: true,
                            lineStyle: {
                                normal: {opacity: 0.5}
                            }
                        },
                        {
                            name: 'MA10',
                            type: 'line',
                            data: calculateMA(10,data0),
                            smooth: true,
                            lineStyle: {
                                normal: {opacity: 0.5}
                            }
                        },
                        {
                            name: 'MA20',
                            type: 'line',
                            data: calculateMA(20,data0),
                            smooth: true,
                            lineStyle: {
                                normal: {opacity: 0.5}
                            }
                        },
                        {
                            name: 'MA30',
                            type: 'line',
                            data: calculateMA(30,data0),
                            smooth: true,
                            lineStyle: {
                                normal: {opacity: 0.5}
                            }
                        },

                    ]
                }
            );
        }
        function fillCharts2(rawdata,codeid){
            var daykline2 = echarts.init(document.getElementById('dayKLine2'));

//            alert("!");

            data0 = splitData(rawdata);

            daykline2.setOption(my_option ={
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross'
                        }
                    },
                    title:{
                        text: codeid +":k线图",
                        textStyle:{
                            fontSize: 16
                        },
                        left: 40
                    },

                    legend: {
                        data: ['日K', 'MA5', 'MA10', 'MA20', 'MA30']
                    },
                    toolbox: {
                        show: true,
                        feature: {
                            dataZoom: {
                                yAxisIndex: 'none'
                            },
                            saveAsImage: {}
                        },
                        right:20
                    },
                    grid: {
                        left: '10%',
                        right: '10%',
                        bottom: '15%'
                    },
                    xAxis: {
                        type: 'category',
                        data: data0.categoryData,
                        scale: true,
                        boundaryGap : false,
                        axisLine: {onZero: false},
                        splitLine: {show: false},
                        splitNumber: 20,
                        min: 'dataMin',
                    },
                    yAxis: {
                        scale: true,
                        splitArea: {
                            show: true
                        }
                    },
                    dataZoom: [
                        {
                            type: 'inside',
                            start: 95,
                            end: 100
                        },
                        {
                            show: true,
                            type: 'slider',
                            y: '90%',
                            start: 95,
                            end: 100
                        }
                    ],
                    series: [
                        {
                            name: '日K',
                            type: 'candlestick',
                            data: data0.values,
                            markPoint: {
                                label: {
                                    normal: {
                                        formatter: function (param) {
                                            return param != null ? Math.round(param.value) : '';
                                        }
                                    }
                                },
                                data: [
                                    {
                                        name: 'XX标点',
                                        coord: ['2013/5/31', 2300],
                                        value: 2300,
                                        itemStyle: {
                                            normal: {color: 'rgb(41,60,85)'}
                                        }
                                    },
                                    {
                                        name: 'highest value',
                                        type: 'max',
                                        valueDim: 'highest'
                                    },
                                    {
                                        name: 'lowest value',
                                        type: 'min',
                                        valueDim: 'lowest'
                                    },
                                    {
                                        name: 'average value on close',
                                        type: 'average',
                                        valueDim: 'close'
                                    }
                                ],
                                tooltip: {
                                    formatter: function (param) {
                                        return param.name + '<br>' + (param.data.coord || '');
                                    }
                                }
                            },
                            markLine: {
                                symbol: ['none', 'none'],
                                data: [
                                    [
                                        {
                                            name: 'from lowest to highest',
                                            type: 'min',
                                            valueDim: 'lowest',
                                            symbol: 'circle',
                                            symbolSize: 10,
                                            label: {
                                                normal: {show: false},
                                                emphasis: {show: false}
                                            }
                                        },
                                        {
                                            type: 'max',
                                            valueDim: 'highest',
                                            symbol: 'circle',
                                            symbolSize: 10,
                                            label: {
                                                normal: {show: false},
                                                emphasis: {show: false}
                                            }
                                        }
                                    ],
                                    {
                                        name: 'min line on close',
                                        type: 'min',
                                        valueDim: 'close'
                                    },
                                    {
                                        name: 'max line on close',
                                        type: 'max',
                                        valueDim: 'close'
                                    }
                                ]
                            }
                        },
                        {
                            name: 'MA5',
                            type: 'line',
                            data: calculateMA(5,data0),
                            smooth: true,
                            lineStyle: {
                                normal: {opacity: 0.5}
                            }
                        },
                        {
                            name: 'MA10',
                            type: 'line',
                            data: calculateMA(10,data0),
                            smooth: true,
                            lineStyle: {
                                normal: {opacity: 0.5}
                            }
                        },
                        {
                            name: 'MA20',
                            type: 'line',
                            data: calculateMA(20,data0),
                            smooth: true,
                            lineStyle: {
                                normal: {opacity: 0.5}
                            }
                        },
                        {
                            name: 'MA30',
                            type: 'line',
                            data: calculateMA(30,data0),
                            smooth: true,
                            lineStyle: {
                                normal: {opacity: 0.5}
                            }
                        },

                    ]
                }
            );
        }

        function addUl(name) {
            var text = name;
            var tag = 0;
            var ul =document.getElementById("choosed_list");
            var lis=ul.getElementsByTagName('li');

            if(lis.length !== 0){               //分析是否已被选中
                for(var i=0;i<lis.length;i++){
                    var as = lis[i].getElementsByTagName('a');
                    var oldcode = as[0].innerHTML;
                    if(text === oldcode){
                        tag = 1;
                        break;
                    }
                }
            }

            if(tag === 0 && lis.length !== 2){                      //已被选中将不再被添加,上限为2

                var li =document.createElement("li");
                var a1=document.createElement("a");
                var a2=document.createElement("a");



                a1.innerHTML=name;
                a2.innerHTML="x";
                a2.style="padding-left: 10px;padding-right: 20px";

                li.id=a1;
                li.onclick=function(){deleteUl(this)};
                li.appendChild(a1);
                li.appendChild(a2);


                ul.appendChild(li);
            }


        }

        function doCompare() {                  //对比功能
            var codename1 = "";
            var codename2 = "";
            var ul = document.getElementById("choosed_list");
            var lis= ul.getElementsByTagName('li');

            codename1 = lis[0].getElementsByTagName('a')[0].innerHTML;
            codename2 = lis[1].getElementsByTagName('a')[0].innerHTML;
//        for(var i =0;i<lis.length;i++){
//            var as = lis[i].getElementsByTagName('a');
//
//            codeList = codeList+as[0].innerHTML;
//        }

//        $("#test").html(codeList);

            $.ajax({            //传：两个股票代码，得到对比数据绘图
                type:"POST",
                url:'<%=request.getContextPath()%>/compare/doCompare',
                data:{codename1:codename1, codename2:codename2},
                dataType:"json",
                cache:false,
                success:function (data) {
                    mydata = JSON.parse(data);
//                    alert(mydata);
//                    alert(typeof mydata);
//                    alert(mydata.codeid1);
//                    alert(mydata.codeid2);
                    getKline1(mydata.codeid1);
                    getKline2(mydata.codeid2);
                    getStock1BasicInfo(mydata.codeid1);
                    getStock2BasicInfo(mydata.codeid2);
                    getLogLine(mydata.codeid1,mydata.codeid2);

//                if(mydata=="{}"){
//                    alert("no message");
//                }else{
//                    $("#test").html("");
//                    $.each(mydata,function (i,item) {
//                        var li=document.createElement("li");
//                        li.innerHTML=item;
//                        $("#test").appendChild(li);
//                    })
//                }
                }
            });
        }

        function getLogLine(id1, id2){

            var sdate = document.getElementById("sDate").value;
            var ldate = document.getElementById("lDate").value;
            var code1 = String(id1);
            var code2 = String(id2);

            while(code1.length < 6){
                code1 = "0" + code1;
            }
            while(code2.length < 6){
                code2 = "0" + code2;
            }

            $.ajax({
                type:"POST",
                url: '<%=request.getContextPath()%>/compare/getLogLine',
                data: {codeid1:code1,codeid2:code2, sdate:sdate, ldate:ldate},
                dataType: "json",
                success:function(result){
                    mylogdata = JSON.parse(result);
                    fillLogCharts1(JSON.parse(mylogdata.code1),code1);
                    fillLogCharts2(JSON.parse(mylogdata.code2),code2);
                }
            });

        }

        function splitLogData(rawdata){
            var categoryData = [];
            var values = [];

            for(var i = 0; i < rawdata.length; i++){
                categoryData.push(rawdata[i].splice(0,1)[0]);
                values.push(rawdata[i][0]);
            }
            return{
                categoryLogData: categoryData,
                logValues: values
            };
        }

        function fillLogCharts1(rawlogdata,codeid){
            var logLine1 = echarts.init(document.getElementById('logLine1'));

            data0 = splitLogData(rawlogdata);

            logLine1.setOption(option={
                title:{
                    text: codeid  + ":对数收益方差",
                    textStyle:{
                        fontSize: 16
                    },
                    left: 40
                },
                toolbox: {
                    show: true,
                    feature: {
                        dataZoom: {
                            yAxisIndex: 'none'
                        },
                        magicType: {type: ['line', 'bar']},
                        restore: {},
                        saveAsImage: {}
                    },
                    right:20
                },
                xAxis:  {
                    type: 'category',
                    boundaryGap: false,
                    data: data0.categoryLogData
                },
                yAxis: {
                    scale:true,
                    splitArea: {
                        show: true
                    }
                },
                dataZoom: [
                    {
                        type: 'inside',
                        start: 95,
                        end: 100
                    },
                    {
                        show: true,
                        type: 'slider',
                        y: '90%',
                        start: 95,
                        end: 100
                    }
                ],
                series:
                    {
                        name:'对数收益率',
                        type:'line',
                        data: data0.logValues,
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'}
                            ]
                        },
                        markLine: {
                            data: [
                                {type: 'average', name: '平均值'}
                            ]
                        }
                    }

            });
        }

        function fillLogCharts2(rawlogdata,codeid){
            var logLine2 = echarts.init(document.getElementById('logLine2'));

            data0 = splitLogData(rawlogdata);

            logLine2.setOption(option={
                title:{
                    text: codeid + ":对数收益方差",
                    textStyle:{
                        fontSize: 16
                    },
                    left: 40
                },
                toolbox: {
                    show: true,
                    feature: {
                        dataZoom: {
                            yAxisIndex: 'none'
                        },
                        magicType: {type: ['line', 'bar']},
                        restore: {},
                        saveAsImage: {}
                    },
                    right:20
                },
                xAxis:  {
                    type: 'category',
                    boundaryGap: false,
                    data: data0.categoryLogData
                },
                yAxis: {
                    scale:true,
                    splitArea: {
                        show: true
                    }
                },
                dataZoom: [
                    {
                        type: 'inside',
                        start: 95,
                        end: 100
                    },
                    {
                        show: true,
                        type: 'slider',
                        y: '90%',
                        start: 95,
                        end: 100
                    }
                ],
                series: [
                    {
                        name:'对数收益率',
                        type:'line',
                        data: data0.logValues,
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'}
                            ]
                        },
                        markLine: {
                            data: [
                                {type: 'average', name: '平均值'}
                            ]
                        }
                    },
                ]

            });
        }


        function deleteUl(objs){
            var ul=document.getElementById("choosed_list");

            ul.removeChild(objs);
        }

        function addCodelist(tbody_name){           //用于向热门，收藏添加条目
            var t=document.getElementById(tbody_name);
            var _tr=document.createElement('tr');
            var td1=document.createElement('td');
            var td2=document.createElement('td');
            var _th=document.createElement('th');
            var _a=document.createElement('a');

            td1.innerHTML="修改成股票名称";
            td1.id="股票名称"

            td2.innerHTML="股票代码";
            td2.id="股票代码";

            a.innerHTML="添加";
            a.onclick=function () {addUl("股票名称+股票代码")}

            _th.appendChild(_a);

            _tr.appendChild(td1);
            _tr.appendChild(td2);
            _tr.appendChild(_th);

            t.appendChild(_tr);

        }

        function deleteAllUl(){         //清空选择
            var ul = document.getElementById("choosed_list");
            ul.innerHTML="";
        }

    </script>

</head>
<body>

<div class="wrapper">
    <div class="sidebar" data-background-color="white" data-active-color="danger">

        <!--
            Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
            Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
        -->

        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="#" class="simple-text">
                    Quantour
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="<%=contextPath%>/dashboard/">
                        <i class="ti-panel"></i>
                        <p>主页</p>
                    </a>
                </li>
                <li>
                    <a href="<%=contextPath%>/compare/">
                        <i class="ti-flag-alt-2"></i>
                        <p>股票对比</p>
                    </a>
                </li>
                <li>
                    <a href="<%=contextPath%>/TODO">
                        <i class="ti-receipt"></i>
                        <p>股市策略</p>
                    </a>
                </li>
                <li>
                    <a href="<%=contextPath%>/doctor/">
                        <i class="ti-user"></i>
                        <p>股票诊断</p>
                    </a>
                </li>

            </ul>
        </div>
    </div>


    <div class="main-panel">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar bar1"></span>
                        <span class="icon-bar bar2"></span>
                        <span class="icon-bar bar3"></span>
                    </button>
                    <a class="navbar-brand" href="#">股票对比</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <div class="form-group" style="padding-top: 15px">
                                <input type="text" placeholder="Search" class="form-control">
                            </div>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/dashboard/login" >
                                <i class="ti-user"></i>
                                <p>登录</p>
                            </a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="ti-bell"></i>
                                <p class="notification">5</p>
                                <p>消息</p>
                                <b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="#">消息 1</a></li>
                                <li><a href="#">消息 2</a></li>
                                <li><a href="#">消息 3</a></li>
                                <li><a href="#">消息 4</a></li>
                                <li><a href="#">更多</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">
                                <i class="ti-settings"></i>
                                <p>设置</p>
                            </a>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>


        <div class="content">
            <div class="row">
                <div class="col-lg-4 col-sm-6">
                    <div class="card">
                        <div class="content">
                            <div class="row">
                                <div class="col-xs-3" style="padding-top: 10px">添加对比:</div>
                                <div class="col-xs-8">
                                    <input type="text" placeholder="代码/名称" class="form-control">
                                </div>
                            </div>
                            <ul class="list-inline" style="padding-top: 20px" id="choosed_list">
                                <%--<li >--%>
                                    <%--<a>沪深300</a>--%>
                                    <%--<a style="padding-left: 10px;padding-right: 20px">x</a>--%>
                                <%--</li>--%>
                                <%--<li>--%>
                                    <%--<a>沪深300</a>--%>
                                    <%--<a  style="padding-left: 10px">x</a>--%>
                                <%--</li>--%>
                            </ul>
                            <br>
                            <hr>
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="sDate">开始时间</label>
                                    <input id="sDate" type="date">
                                </div>
                                <div class="col-md-6">
                                    <label for="lDate">结束时间</label>
                                    <input id="lDate" type="date">
                                </div>
                            </div>
                            <hr>
                            <div class="row" style="padding-top: 10px">
                                <div class="col-xs-4">
                                    <button class="btn btn-success" onclick="doCompare()">比较</button>
                                </div>
                                <button class="btn btn-danger" onclick="deleteAllUl()">清空</button>
                            </div>
                            <hr>
                            <ul class="nav nav-pills">
                                <li class="active"><a data-toggle="pill" href="#hot">热门股票</a></li>
                                <li><a data-toggle="pill" href="#collect">收藏股票</a> </li>
                                <li><a data-toggle="pill" href="#history">历史浏览</a> </li>
                            </ul>
                            <div class="tab-content">
                                <div id="hot" class="tab-pane fade in active">
                                    <div class="content table-responsive table-full-width">
                                        <table class="table table-striped">
                                            <tbody>
                                            <tr>
                                                <td id="cold_name_1">平安银行</td>
                                                <td>0.00</td>
                                                <th><a href="#" onclick="addUl(document.getElementById('cold_name_1').innerHTML)">对比</a></th>
                                            </tr>
                                            <tr>
                                                <td id="cold_name_2">万 科Ａ</td>
                                                <td>0.00</td>
                                                <th><a href="#" onclick="addUl(document.getElementById('cold_name_2').innerHTML)">对比</a> </th>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div id="collect" class="tab-pane fade">
                                    <div class="content table-responsive table-full-width">
                                        <table class="table table-striped">
                                            <tbody>
                                            <tr>
                                                <td id="hot_name_1">工商银行</td>
                                                <td>0.00</td>
                                                <th><a href="#" onclick="addUl(document.getElementById('hot_name_1').innerHTML)">对比</a></th>
                                            </tr>
                                            <tr>
                                                <td id="hot_name_2">农业银行</td>
                                                <td>0.00</td>
                                                <th><a href="#" onclick="addUl(document.getElementById('hot_name_2').innerHTML)">对比</a> </th>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div id="history" class="tab-pane fade">
                                    <div class="content table-responsive table-full-width">
                                        <table class="table table-striped">
                                            <tbody>
                                            <tr>
                                                <td>万科A</td>
                                                <td>0.00</td>
                                                <th><a href="#">对比</a></th>
                                            </tr>
                                            <tr>
                                                <td>百度</td>
                                                <td>0.00</td>
                                                <th><a href="#">对比</a> </th>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8 col-sm-6 col-md-6">
                    <div class="card">
                        <div class="header">
                            <blockquote>股票对比</blockquote>

                            <ul class="nav nav-pills">
                                <li class="active"><a data-toggle="pill" href="#dayKline">热门股票</a></li>
                                <li><a data-toggle="pill" href="#logLine">收藏股票</a> </li>
                            </ul>

                            <div class="table-content">
                                <div  id="dayKline" class="tab-pane fade in active">
                                    <div id="dayKLine1" style="width: 750px; height: 400px;">
                                    <script>
                                        function getKline1(code) {
                                            getKLine1Info(code);
                                        }
                                    </script>
                                </div>
                                    <hr>
                                    <div id="dayKLine2" style="width: 750px; height: 400px;">
                                    <script>
                                        function getKline2(code){
                                            getKLine2Info(code);
                                        }
                                    </script>
                                </div>
                                </div>

                                <div  id="logLine" class="tab-pane fade">
                                    <div id="logLine1" style="width: 750px; height: 400px;">

                                    </div>
                                    <hr>
                                    <div id="logLine2" style="width: 750px; height: 400px;">

                                    </div>

                                </div>
                            </div>

                            <%--<hr>--%>
                            <%----%>
                             <%--<hr>--%>
                        </div>

                        <div class="content">
                            <%--<div id="chartPreferences" class="ct-chart ct-perfect-fourth"></div>--%>

                            <%--<hr>--%>
                            <blockquote>基本指标对比</blockquote>
                            <div class="content table-responsive table-full-width">
                                <script>
                                    function getStock1BasicInfo(code) {
//
//                                        $.ajax({
//                                            type : "POST",
//                                            url: '',
//                                            data:{id:code},
//                                            dataType:"json",
//                                            success:function (result) {
//
//                                            }
//                                        });
                                    }

                                    function getStock2BasicInfo(code){

                                    }
                                </script>
                                
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>对比项</th>
                                        <th>最高价格</th>
                                        <th>最低价格</th>
                                        <th>涨跌幅</th>
                                        <th>成交量</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>工商银行</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.0%</td>
                                        <th>1000000</th>
                                    </tr>
                                    <tr>
                                        <td>农业银行</td>
                                        <td>0.00</td>
                                        <td>0.00</td>
                                        <td>0.0%</td>
                                        <th>1000000</th>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div>
                                <p id="test">
                                    text
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>

</div>
</body>

<!--   Core JS Files   -->
<script src="<%=contextPath%>/assets/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="<%=contextPath%>/assets/js/bootstrap-checkbox-radio.js"></script>

<!--  Charts Plugin -->
<script src="<%=contextPath%>/assets/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="<%=contextPath%>/assets/js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

<!-- Paper Dashboard Core javascript and methods for Demo purpose -->
<script src="<%=contextPath%>/assets/js/paper-dashboard.js"></script>

<%--<!-- Paper Dashboard DEMO methods, don't include it in your project! -->--%>
<%--<script src="<%=contextPath%>/assets/js/demo.js"></script>--%>

<script>

</script>
<%--<script type="text/javascript">--%>
    <%--$(document).ready(function(){--%>

        <%--demo.initChartist();--%>

        <%--$.notify({--%>
            <%--icon: 'ti-gift',--%>
            <%--message: "Welcome to <b>Paper Dashboard</b> - a beautiful Bootstrap freebie for your next project."--%>

        <%--},{--%>
            <%--type: 'success',--%>
            <%--timer: 4000--%>
        <%--});--%>

    <%--});--%>
<%--</script>--%>
</html>
