<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>服务订单表</title>
    <t:base type="bootstrap,bootstrap-table,layer"></t:base>
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap/css/bootstrap-dialog.css">
    <script src="${webRoot}/plug-in/bootstrap/js/bootstrap-dialog.js" type="text/javascript"></script>
    <script src="${webRoot}/js/common.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${webRoot}/plug-in/ztree/bootstrap_zTree/css/bootstrapStyle/bootstrapStyle.css">
    <script type="text/javascript" src="${webRoot}/plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js"></script>
</head>
<body>
<div class="panel-body" style="padding-bottom: 0px;">
    <div class="accordion-group">
        <div id="collapse_search" class="accordion-body collapse">
            <div class="accordion-inner">
                <div class="panel panel-default" style="margin-bottom: 0px;">
                    <div class="panel-body">
                        <form id="apiOrderForm" onkeydown="if(event.keyCode==13){reloadTable();return false;}">
                            <div class="col-xs-12 col-sm-6 col-md-4">
                                <label for="appName">应用名称：</label>
                                <div class="input-group" style="width: 100%">
                                    <input type="text" class="form-control input-sm" id="appName" name="appName"/>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-4">
                                <label for="createDate_begin">创建日期：</label>
                                <div class="input-group" style="width: 100%">
                                    <input type="text" class="form-control input-sm laydate-date" id="createDate_begin"
                                           name="createDate_begin"/>
                                    <span class="input-group-addon">
								                        <span class="glyphicon glyphicon-calendar"></span>
								                    </span>
                                    <span class="input-group-addon input-sm">~</span>
                                    <input type="text" class="form-control input-sm laydate-date" id="createDate_end"
                                           name="createDate_end"/>
                                    <span class="input-group-addon">
								                        <span class="glyphicon glyphicon-calendar"></span>
								                    </span>
                                </div>
                            </div>

                            <div class="col-xs-12 col-sm-6 col-md-4">
                                <div class="input-group col-md-12" style="margin-top: 20px">
                                    <a class='btn btn-success' onclick="searchList();"><span
                                            class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</a>&nbsp
                                    <a class='btn btn-warning' onclick="searchRest();"><span
                                            class="glyphicon glyphicon-repeat" aria-hidden="true"></span>重置</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="panel-body" style="padding-top: 0px; padding-bottom: 0px;">
    <div id="toolbar">
        <button id="btn_detail" onclick="goOrderDetailPage()"  class="btn btn-info btn-sm">
            <span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查看
        </button>
        <a class="btn btn-default btn-sm" data-toggle="collapse" href="#collapse_search" id="btn_collapse_search"> <span
                class="glyphicon glyphicon-search" aria-hidden="true"></span> 检索 </a>
    </div>
    <div class="table-responsive">
        <table id="apiOrderList"></table>
    </div>
</div>
<script type="text/javascript">

    $(".laydate-datetime").each(function(){
        var _this = this;
        laydate.render({
            elem: this,
            format: 'yyyy-MM-dd HH:mm:ss',
            type: 'datetime'
        });
    });
    $(".laydate-date").each(function(){
        var _this = this;
        laydate.render({
            elem: this
        });
    });


    $(function () {
        //1.初始化Table
        var oTable = new TableInit();
        oTable.Init();
    });

    var TableInit = function () {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function () {
            $('#apiOrderList').bootstrapTable({
                url: 'order.do?orderDatagrid&listType=order', //请求后台的URL（*）
                method: 'post', //请求方式（*）
                contentType : "application/x-www-form-urlencoded",
                toolbar: '#toolbar', //工具按钮用哪个容器
                striped: true, //是否显示行间隔色
                cache: false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true, //是否显示分页（*）
                queryParams: oTableInit.queryParams,//传递参数（*）
                sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
                pageNumber: 1, //初始化加载第一页，默认第一页
                pageSize: 10, //每页的记录行数（*）
                pageList: [10, 25, 50, 100], //可供选择的每页的行数（*）
                strictSearch: true,
                showColumns: false, //是否显示所有的列
                showRefresh: true, //是否显示刷新按钮
                minimumCountColumns: 2, //最少允许的列数
                clickToSelect: true, //是否启用点击选中行
                height: $(window).height() - 35, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                uniqueId: "id", //每一行的唯一标识，一般为主键列
                showToggle: false, //是否显示详细视图和列表视图的切换按钮
                cardView: false, //是否显示详细视图
                detailView: false, //是否显示父子表
                showExport: false, //显示到处按钮
                sortName: 'createDate',
                sortOrder: 'desc',
                columns: [
                    // 复选框
                     {
                        radio: true,
                        width:20,
                        align: 'center'
                    }, 
                    {
                        field: 'id',
                        title: '订单编号',
                        valign: 'middle',
                        width: 180,
                        visible: true,
                        align: 'center',
                        switchable: true,
                        formatter : function(value, rec, index) {
                            return "<span title=" + value + ">" + value + "</span>"
                        }
                    },
                    // {
                    //     field: 'appId',
                    //     title: '应用id',
                    //     valign: 'middle',
                    //     width: 120,
                    //     visible: false,
                    //     align: 'center',
                    //     switchable: true,
                    // },

                    {
                        field: 'appName',
                        title: '应用名称',
                        valign: 'middle',
                        width: 100,
                        align: 'center',
                        switchable: true,
                        formatter : function(value, rec, index) {
                            return "<span title=" + value + ">" + value + "</span>"
                        }
                    },
                    {
                        field: 'money',
                        title: '订单金额',
                        valign: 'middle',
                        width: 60,
                        align: 'center',
                        switchable: true,
                    },
                    {
                        field: 'payStatus',
                        title: '支付状态',
                        valign: 'middle',
                        width: 60,
                        align: 'center',
                        switchable: true,
                        formatter : function(value, rec, index) {
                            if(value == 0){
                                return "未支付";
                            }else if(value == 1){
                                return "已支付";
                            }
                            return value;
                        }
                    },
//                    {
//                        field: 'payTime',
//                        title: '支付时间',
//                        valign: 'middle',
//                        width: 120,
//                        align: 'center',
//                        switchable: true,
//                    },
                    {
                        field: 'createDate',
                        title: '下单时间',
                        valign: 'middle',
                        width:100,
                        align: 'center',
                        switchable: true,
                        formatter : function(value, rec, index) {
                            if(value == null || value==''){
                                return value;
                            }else{
                                value = value.substring(0,value.lastIndexOf("."));
                            }
                            return value;
                        }
                    },
                    {
                        field: 'auditStatus',
                        title: '审核状态',
                        valign: 'middle',
                        width: 60,
                        align: 'center',
                        switchable: true,
                        formatter : function(value, rec, index) {
                            if(value == 0){
                                return "暂存";
                            }else if(value == 1){
                                return "待审核";
                            }else if(value == 2){
                                return "通过";
                            }else if(value == 3){
                                return "不通过";
                            }
                            return value;
                        }
                    },
                    {
                        field: 'orderType',
                        title: '订单类型',
                        valign: 'middle',
                        width: 60,
                        align: 'center',
                        switchable: true,
                        formatter : function(value, rec, index) {
                            if(value == 'api'){
                                return "能力订单";
                            }else if(value == 'scene'){
                                return "场景订单";
                            }
                            return value;
                        }
                    },
                    {
                        title: "操作",
                        align: 'left',
                        valign: 'middle',
                        width: 120,
                        formatter: function (value, row, index) {
                            if (!row.id) {
                                return '';
                            }
                            var href = '';
                            if(row.orderType == 'api'){
                                /*0409*/
                                href += "<button class='btn btn-xs btn-warning'  onclick='lookDetail(\"" + row.id + "\")'>" +
                                    "<span>查看能力</span></button>&nbsp";
                            }
                            if(row.orderType == 'scene'){
                                href += "<button class='btn btn-xs btn-info'   onclick='lookDetail(\"" + row.id + "\")'>" +
                                    "<span>查看场景</span></button>&nbsp";
                            }
                            if(row.auditStatus == '0' || row.auditStatus == '3'){
                                if(row.orderType == 'api'){
                                    href += "<button class='btn btn-xs btn-success'  onclick='orderApi(\"" + row.id + "\")'>" +
                                        "<span>配置能力</span></button>&nbsp";
                                }
                                if(row.orderType == 'scene'){
                                    href += "<button class='btn btn-xs btn-success'  onclick='orderScene(\"" + row.id + "\")'>" +
                                        "<span>配置场景</span></button>&nbsp";
                                }
                                href += "<button class='btn btn-xs btn-primary' onclick='orderSubmit(\"" + row.id + "\")'>" +
                                    "<span>提交</span></button>";
                            }
                            if(row.payStatus == '0' && row.auditStatus == '2'){
                                href += "<button class='btn btn-xs btn-success'  onclick='orderPay(\"" + row.id + "\")'>" +
                                    "<span>支付</span></button>&nbsp";
                            }


                            return href;
                        }
                    }],
                onLoadSuccess: function () { //加载成功时执行
                },
                onLoadError: function () { //加载失败时执行
                }
            });
        };

        //得到查询的参数
        oTableInit.queryParams = function (params) {
            var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                pageSize: params.limit, // 每页要显示的数据条数
                offset: params.offset, // 每页显示数据的开始行号
                sort: params.sort, // 排序规则
                order: params.order,
                rows: params.limit, //页面大小
                page: (params.offset / params.limit) + 1, //页码
                pageIndex: params.pageNumber,//请求第几页
                field: 'id,appId,appName,money,payStatus,payTime,auditStatus,orderType,createDate'
            };

            var params = $("#apiOrderForm").serializeArray();
            for (x in params) {
                temp[params[x].name] = params[x].value;
            }
            return temp;
        };
        return oTableInit;
    };

    function searchList() {
        reloadAppTable();
    }

    function reloadAppTable() {
    	console.info($('#apiOrderList'))
        $('#apiOrderList').bootstrapTable('refresh');
    }

    function searchRest() {
        $('#apiOrderForm').find(':input').each(function () {
            if ("checkbox" == $(this).attr("type")) {
                $("input:checkbox[name='" + $(this).attr('name') + "']").attr('checked', false);
            } else if ("radio" == $(this).attr("type")) {
                $("input:radio[name='" + $(this).attr('name') + "']").attr('checked', false);
            } else {
                $(this).val("");
            }
        });
        $('#apiOrderForm').find("input[type='checkbox']").each(function () {
            $(this).attr('checked', false);
        });
        $('#apiOrderForm').find("input[type='radio']").each(function () {
            $(this).attr('checked', false);
        });
        reloadAppTable();
    }

    //订购服务
    function  orderApi(id) {
        var dialog = bootOpenNormal('订购能力', 'order.do?orderApiSelect&id=' + id, 'wide');
        dialog.options.buttons[0].action = function (dialog) {
            var array = [];
            var chargeModeId = [];
            var apiNames2 = "";
            var apiNames = "";
            var url="";
            //用来校验资源控制
            var apiResource = [];
            var apiNames3 = "";
            //用来校验tag
            var tag = [];
            var apiNames4 = "";

            //用来校验webService
            var webServiceInfo = [];
            var apiNames5 = "";
            apiTemps.forEach(function (item, key, mapObj) {
                if(key!=null && key!=''){
                    item.chargeModeId = $("#" + item.apiId).val();
                    // item.resourceIds = apiResourceMap.get(item.apiId);
                    if (item.chargeModeId == null) {
                        chargeModeId = null;
                        apiNames += item.apiName + ",";
                    }
                    /*//如果为主动推送能力，需要校验是否配置了url
                    if (item.apiInvokeType == 2) {
                        url = urlMap.get(item.apiId);
                        if (url == null || url == undefined || url == "") {
                            url = null;
                            apiNames2 += item.apiName + ",";
                        } else {
                            item.url = url;
                        }
                    }*/
                    if (item.resourceCtrl == 1) {
                        apiResource = apiResourceMap.get(item.apiId);
                        if (apiResource == null || apiResource == undefined || apiResource == "") {
                            apiResource = null
                            apiNames3 += item.apiName + ",";
                        } else {
                            item.apiResource = apiResource;
                        }
                    }
                    if (item.pubMode != 1 || item.apiInvokeType != 1) {
                        // tag = tagMap.get(item.apiId);
                        // if (tag == null || tag == undefined || tag == "") {
                        //     tag = null
                        //     apiNames4 += item.apiName + ",";
                        // } else {
                        //     item.tag = tag;
                        // }

                        webServiceInfo = webServiceInfoMap.get(item.apiId);
                        if (webServiceInfo == null || webServiceInfo == undefined || webServiceInfo == "") {
                            webServiceInfo = null
                            apiNames5 += item.apiName + ",";
                        } else {
                            item.webServiceInfo = webServiceInfo;

                        }
                    }
                    array.push(item);

                }
            });
            //至少选择一个服务
            if (array.length <= 0) {
                slowNotify("请至少订购一个能力", "danger");
            } else if (chargeModeId == null) {
                apiNames = apiNames.substring(0, apiNames.length - 1);
                slowNotify("[" + apiNames + "]尚未选择计费方式", "danger");
            } else if (url == null) {
                apiNames2 = apiNames2.substring(0, apiNames2.length - 1);
                slowNotify("[" + apiNames2 + "]尚未配置URL", "danger");
            } else if (apiResource == null) {
                slowNotify("[" + apiNames3 + "]尚未配置资源控制", "danger");
            }  else if (webServiceInfo == null) {
                slowNotify("[" + apiNames5 + "]尚未配置接收信息", "danger");
            }
            // else if (tag == null) {
            //     slowNotify("[" + apiNames4 + "]尚未配置tag", "danger");
            // }
            else{
                $.ajax({
                    type: "post",
                    dataType: "json",
                    data: {
                        id: id,
                        orderType:'api',
                        apiData: JSON.stringify(array)
                    },
                    url: "order.do?saveOrder",
                    success: function (data) {
                        if (data.success) {
                            dialog.close()
                            quickNotify(data.msg, "success");
                        } else {
                            slowNotify(data.msg, "danger");
                        }
                    }
                })
            }
        }
    }

    //订购场景
    function orderScene(id) {
        var dialog = bootOpenNormal('订购场景', 'order.do?orderSceneSelect&id=' + id, 'wide');
        dialog.options.buttons[0].action = function (dialog) {
            var array = [];
            var chargeModeId = [];
            var sceneNames = "";
            secensTemps.forEach(function (item, key, mapObj) {
                if (key != null && key != '') {
                    item.chargeModeId = $("#" + item.sceneId).val();
                    item.resourceIds = apiResourceMap.get(item.apiId);
                    if (item.chargeModeId == null) {
                        chargeModeId = null;
                        sceneNames += item.sceneName + ",";
                    }
                    array.push(item);
                }
            });
            //至少选择一个场景
            if(array.length<=0){
                slowNotify("请订购一个场景", "danger");
            }else if(chargeModeId == null) {
                sceneNames = sceneNames.substring(0,sceneNames.length - 1);
                slowNotify("[" + sceneNames + "]尚未选择计费方式", "danger");
            }else{
            $.ajax({
                type: "post",
                dataType: "json",
                data: {
                    id: id,
                    orderType: 'scene',
                    apiData: JSON.stringify(array)
                },
                url: "order.do?saveOrder",
                success: function (data) {
                    if (data.success) {
                        dialog.close()
                        quickNotify(data.msg, "success");
                    } else {
                        slowNotify(data.msg, "danger");
                    }
                }
            })
        }
        }
    }

    //提交审核
    //    function orderSubmit(id) {
    //        BootstrapDialog.confirm({
    //            title: '操作提示',
    //            message: '确定要提交审核吗?',
    //            type: BootstrapDialog.TYPE_WARNING,
    //            closable: true,
    //            size:"size-small",
    //            draggable: true,
    //            btnCancelLabel: '取消',
    //            btnOKLabel: '确定', // <-- Default value is 'OK',
    //            btnOKClass: 'btn-warning',
    //            callback: function (result) {
    //                if(result) {
    //                    $.ajax({
    //                        type:"post",
    //                        dataType:"json",
    //                        url:"order.do?orderSubmit",
    //                        data:{id:id},
    //                        success:function(data){
    //                            if(data.success){
    //                                quickNotify(data.msg,"success");
    //                                $('#apiOrderList').bootstrapTable('refresh');
    //                            }else{
    //                                slowNotify(data.msg,"danger");
    //                            }
    //                        }
    //                    })
    //                }
    //            }
    //        });
    //    }


    function orderSubmit(id) {
        var dialog = bootOpenNormal('审核员列表', 'order.do?goCheckUserList&id=' + id, 'normal');
        dialog.options.buttons[0].action = function (dialog) {
            var array = [];
            //用来校验审核员
            var checkUserId = "";
            apiTemps.forEach(function (item, key, mapObj) {
                if (key != null && key != '') {
                    item.checkUserId = $("#" + item.id).val();
                    array.push(item);
                }
            });
            //选择一个审核员
            if (array.length <= 0) {
                slowNotify("请选择一个审核员", "danger");
            }else if(array.length>1){
                slowNotify("只能选择一个审核员", "danger");
            } else {
                $.ajax({
                    type: "post",
                    dataType: "json",
                    data: {
                        id: id,
                        apiData: JSON.stringify(array)
                    },
                    url: "order.do?orderSubmitToCheck",
                    success: function (data) {
                        if (data.success) {
                            dialog.close()
                            quickNotify(data.msg, "success");
                            $('#apiOrderList').bootstrapTable('refresh');
                        } else {
                            slowNotify(data.msg, "danger");
                        }
                    }
                })
            }
        }
    }

    //支付
    function orderPay(id) {
        BootstrapDialog.confirm({
            title: '操作提示',
            message: '确定要提交支付吗?',
            type: BootstrapDialog.TYPE_WARNING,
            closable: true,
            size:"size-small",
            draggable: true,
            btnCancelLabel: '取消',
            btnOKLabel: '确定', // <-- Default value is 'OK',
            btnOKClass: 'btn-warning',
            callback: function (result) {
                if(result) {
                    $.ajax({
                        type:"post",
                        dataType:"json",
                        url:"order.do?orderPay",
                        data:{id:id},
                        success:function(data){
                            if(data.success){
                                quickNotify(data.msg,"success");
                                $('#apiOrderList').bootstrapTable('refresh');
                            }else{
                                slowNotify(data.msg,"danger");
                            }
                        }
                    })
                }
            }
        });
    }

    //查看订单信息
    function goOrderDetailPage() {
        var selects = $('#apiOrderList').bootstrapTable('getSelections');
        if (selects == null || selects.length == 0) {
            quickNotify("请先选中一行", "warning");
        }else{
            var id = selects[0].id;
            var dialog = bootOpenLook('订单详情', 'order.do?goOrderDetailPage&id=' + id, 'wide');
        }
    }

    //查看关联
    function lookDetail(id) {

        var dialog = bootOpenLook('订单详情', 'order.do?lookDetail&id=' + id, 'wide');
    }
</script>


</body>
</html>