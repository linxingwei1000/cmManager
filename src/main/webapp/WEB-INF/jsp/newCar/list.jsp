<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<head>
    <title>新车业务</title>
    <script type="text/javascript" src="js/nimble.js"></script>
    <script type="text/javascript" src="js/nimble_editable.js"></script>
</head>

<ul class="breadcrumb">
    <li><a href="main">首页</a> <span class="divider"></span></li>
    <li class="active">新车业务</li>
</ul>

<c:if test="${not empty tip }">
    <c:choose>
        <c:when test="${fn:startsWith(requestScope.tip,'ok') }">
            <div class="alert alert-success">${fn:substringAfter(requestScope.tip, 'ok') }</div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-error">${requestScope.tip }</div>
        </c:otherwise>
    </c:choose>
</c:if>

<hr/>
<div class="container">
    <form class="form-inline" action="newCarSearch" method="get">
        <div class="col-sm-2">
            <div class="form-group">
                <select class="form-control" name="searchKey" id="searchKey" onchange="show(this)">
                    <option value="">未选择中</option>
                    <option value="salePerson">销售员</option>
                    <option value="carModel">车型</option>
                    <option value="saleDate">销售日期</option>
                </select>
            </div>
        </div>
        <div class="col-sm-2" id="dsv" style="display: none">
            <input class="form-control" type="text" name="searchValue" id="searchValue" value="${searchValue }" placeholder="请输入" autocomplete="off"/>
        </div>
        <div class="col-sm-2" id="dbt" style="display: none">
            <input class="form-control" type="text" name="btime" id="btime" value="${btime }" onclick="new Calendar().show(this);" placeholder="开始日期（必填)" autocomplete="off"/>
        </div>
        <div class="col-sm-2" id="det" style="display: none">
            <input class="form-control" type="text" name="etime" id="etime" value="${etime }" onclick="new Calendar().show(this);" placeholder="结束日期" autocomplete="off"/>
        </div>
        <div class="col-sm-2" id="dsOne" style="display: block"></div>
        <div class="col-sm-2" id="dsTwo" style="display: block"></div>
        <div class="col-sm-2">
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    <i class="icon-search icon-white"></i> 查询
                </button>
                <a class="btn btn-small" href="newCarAction?action=1">业务录入</a>
            </div>
        </div>
    </form>
</div>
<hr/>
<div>
    <c:choose>
        <c:when test="${empty dataList }">
            <div class="container">
                <div class="alert alert-block">
                    <a href="#" class="close" data-dismiss="alert">x</a>
                    未找到匹配的记录
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:if test="${export == 1 }">
                <p><a href="newCarExport" class="btn btn-primary"><i class="icon-plus icon-white"></i> 导出</a></p>
            </c:if>
            <table id="traceTable" class="table table-striped table-bordered table-condensed table-hover">
                <colgroup>
                    <col width="8%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="7%"/>
                    <col width="7%"/>
                    <col width="8%"/>
                    <col width="10%"/>
                    <col width="20%"/>
                </colgroup>
                <tr>
                    <th>车辆品牌</th>
                    <th>车型</th>
                    <th>车配置</th>
                    <th>厂家指导价</th>
                    <th>业务信息</th>
                    <th>客户信息</th>
                    <th>其他成本</th>
                    <th>其他收入</th>
                    <th>已付/应付</th>
                    <th>已放款/总放款金额</th>
                    <th>操作</th>
                </tr>
                <c:forEach var="cp" items="${dataList}" varStatus="status">
                    <tr>
                        <td>${cp.carBrand}</td>
                        <td>${cp.carModel}</td>
                        <td>${cp.carConfig}</td>
                        <td>${cp.guidancePrice}</td>
                        <td><a href="#business-${cp.id}" data-toggle="modal"><i class="icon-trash"></i> 查看详情</a>
                            <div id="business-${cp.id}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">业务信息</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group row">
                                                <label class="col-sm-3 control-label">采购员：${cp.purchasePerson}</label>
                                                <div class="col-sm-1"></div>
                                                <label class="col-sm-3 control-label">采购价格：${cp.purchaseMoney}</label>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 control-label">销售员：${cp.salePerson}</label>
                                                <div class="col-sm-1"></div>
                                                <label class="col-sm-3 control-label">销售日期：${cp.strSaleDate}</label>
                                                <div class="col-sm-1"></div>
                                                <label class="col-sm-3 control-label">销售价格：${cp.saleMoney}</label>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 control-label">保险公司：${cp.expenseCompany}</label>
                                                <div class="col-sm-1"></div>
                                                <label class="col-sm-3 control-label">保险返点：${cp.expenseRebate}</label>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 control-label">商业保险费：${cp.businessExpenseFee}</label>
                                                <div class="col-sm-1"></div>
                                                <label class="col-sm-3 control-label">强制保险费：${cp.forceExpenseFee}</label>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 control-label">中介费：${cp.agencyFee}</label>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-4 control-label">付款方式：<c:if test="${cp.saleType == 1}">全款</c:if><c:if test="${cp.saleType == 2}">按揭</c:if></label>
                                            </div>
                                            <c:if test="${cp.saleType == 2}">
                                                <div class="form-group row">
                                                    <label class="col-sm-4 control-label">对接按揭专员：${cp.mortgageRecord.mortgageCommissioner}</label>
                                                    <div class="col-sm-1"></div>
                                                    <label class="col-sm-4 control-label">按揭公司：${cp.mortgageRecord.mortgageCompany}</label>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-sm-4 control-label">贷款金额：${cp.mortgageRecord.loanFee}</label>
                                                    <div class="col-sm-1"></div>
                                                    <label class="col-sm-4 control-label">利率：${cp.mortgageRecord.interestRate}</label>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-sm-4 control-label">按揭返点：${cp.mortgageRecord.mortgageRebate}</label>
                                                    <div class="col-sm-1"></div>
                                                    <label class="col-sm-4 control-label">返还金额：${cp.mortgageRecord.backFee}</label>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-sm-4 control-label">评估费：${cp.mortgageRecord.assessmentFee}</label>
                                                    <div class="col-sm-1"></div>
                                                    <label class="col-sm-4 control-label">风险金：${cp.mortgageRecord.riskFee}</label>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-sm-4 control-label">续保押金：${cp.mortgageRecord.renewalFee}</label>
                                                    <div class="col-sm-1"></div>
                                                    <label class="col-sm-4 control-label">垫资费：${cp.mortgageRecord.padFee}</label>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-sm-4 control-label">上门费：${cp.mortgageRecord.doorFee}</label>
                                                    <div class="col-sm-1"></div>
                                                    <label class="col-sm-4 control-label">印花税：${cp.mortgageRecord.stampDuty}</label>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-sm-4 control-label">其它费用：${cp.mortgageRecord.otherFee}</label>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="modal-footer">
                                            <label>版权所有© 2018 车猫</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td><a href="#consumer-${cp.id}" data-toggle="modal"><i class="icon-trash"></i> 查看详情</a>
                            <div id="consumer-${cp.id}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myConsumerLabel">客户信息</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group row">
                                                <label class="col-sm-3 control-label">客户姓名：${cp.consumerName}</label>
                                                <div class="col-sm-1"></div>
                                                <label class="col-sm-3 control-label">客户性别：<c:if test="${cp.consumerSex == 1 }">男</c:if><c:if test="${cp.consumerSex == 2 }">女</c:if></label>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 control-label">客户居住地：${cp.consumerAddress}</label>
                                                <div class="col-sm-1"></div>
                                                <label class="col-sm-3 control-label">电话号码：${cp.consumerPhone}</label>
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-sm-3 control-label">客户属性：${cp.strConsumerProperty}</label>
                                                <div class="col-sm-1"></div>
                                                <label class="col-sm-3 control-label">获客渠道：${cp.strConsumerResource}</label>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 control-label">购车用途：${cp.strPurchaseUse}</label>
                                                <div class="col-sm-1"></div>
                                                <label class="col-sm-3 control-label">客户年龄段：${cp.strConsumerAge}</label>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 control-label">中介费：${cp.agencyFee}</label>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <label>版权所有© 2018 车猫</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>${cp.otherCost}，<a href="#CarCost-${cp.id}" data-toggle="modal"><i class="icon-trash"></i> 明细</a>
                            <div id="CarCost-${cp.id}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="CarCostLabel">其他成本明细</h4>
                                        </div>
                                        <div class="modal-body">
                                            <c:forEach var="pl" items="${cp.otherCostList}" varStatus="status">
                                                <div class="form-group row">
                                                    <label class="col-sm-4 control-label">项目：${pl.setupName}</label>
                                                    <div class="col-sm-1"></div>
                                                    <label class="col-sm-4 control-label">金额：${pl.setupFee}</label>
                                                    <!--<a href="carSaleSetupAction?id=${pl.id}&action=2&carCostId=${pl.carCostId}&setupType=5"><i class="icon-lock"></i> 修改</a>-->
                                                    <a href="#confirmDialog" data-toggle="modal" data-url="carSaleSetupDelete?id=${pl.id}&carCostId=${pl.carCostId}&setupType=5" data-title="删除记录"
                                                       data-tip="确认要删除记录嘛？" class="confirm-trigger"><i class="icon-trash"></i> 删除</a>
                                                </div>
                                            </c:forEach>
                                            <div class="form-group row">
                                                <div class="col-sm-2"></div>
                                                <div class="col-sm-4">
                                                    <a href="carSaleSetupAction?carCostId=${cp.id }&action=1&setupType=5"><i class="icon-trash"></i> 添加其他成本</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <label>版权所有© 2018 车猫</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>${cp.otherIncome}，<a href="#CarIncome-${cp.id}" data-toggle="modal"><i class="icon-trash"></i> 明细</a>
                            <div id="CarIncome-${cp.id}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="CarIncomeLabel">其他收入明细</h4>
                                        </div>
                                        <div class="modal-body">
                                            <c:forEach var="pl" items="${cp.otherIncomeList}" varStatus="status">
                                                <div class="form-group row">
                                                    <label class="col-sm-4 control-label">项目：${pl.setupName}</label>
                                                    <div class="col-sm-1"></div>
                                                    <label class="col-sm-4 control-label">金额：${pl.setupFee}</label>
                                                    <!--<a href="carSaleSetupAction?id=${pl.id}&action=2&carCostId=${pl.carCostId}&setupType=6"><i class="icon-lock"></i> 修改</a>-->
                                                    <a href="#confirmDialog" data-toggle="modal" data-url="carSaleSetupDelete?id=${pl.id}&carCostId=${pl.carCostId}&setupType=6" data-title="删除记录"
                                                       data-tip="确认要删除记录嘛？" class="confirm-trigger"><i class="icon-trash"></i> 删除</a>
                                                </div>
                                            </c:forEach>
                                            <div class="form-group row">
                                                <div class="col-sm-2"></div>
                                                <div class="col-sm-4">
                                                    <a href="carSaleSetupAction?carCostId=${cp.id }&action=1&setupType=6"><i class="icon-trash"></i> 添加其他收入</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <label>版权所有© 2018 车猫</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>${cp.paidMoney}/${cp.payMoney}</td>
                        <td><c:if test="${cp.saleType == 1}">    -</c:if><c:if test="${cp.saleType == 2}">${cp.mortgageRecord.mortgageMoney}/${cp.mortgageRecord.aMortgageMoney}</c:if></td>
                        <td>
                            <a href="#paidDialog" data-toggle="modal" data-url="newCarPaid?id=${cp.id }" data-title="收账" data-need="${cp.payMoney - cp.paidMoney}" class="paid-trigger"><i class="icon-trash"></i> 付款</a>
                            <c:if test="${cp.saleType == 2}">
                                <a href="#paidDialog" data-toggle="modal" data-url="mortgageNewCarPaid?id=${cp.mortgageRecord.id }" data-title="放款" data-need="${cp.mortgageRecord.aMortgageMoney - cp.mortgageRecord.mortgageMoney }" class="paid-trigger"><i class="icon-trash"></i> 放款</a>
                            </c:if>
                            <a href="newCarAction?id=${cp.id }&action=2"><i class="icon-lock"></i> 编辑</a>
                            <a href="#confirmDialog" data-toggle="modal" data-url="newCarDelete?id=${cp.id }" data-title="删除记录"
                               data-tip="确认要删除记录嘛？" class="confirm-trigger"><i class="icon-trash"></i> 删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<%-- 付款 --%>
<div id="paidDialog" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h5 class="modal-title">提示</h5>
            </div>
            <div class="modal-body">
                <div class="form-group form-inline row">
                    <label class="control-label col-xs-2 " for="goonPaid">金额：</label>
                    <input class="form-control  col-xs-4" type="text" name="goonPaid" id="goonPaid" placeholder="请输入金额" autocomplete="off"/>
                    <div class="col-xs-2 modal-body-need"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary paid-do-trigger">确定</button>
                <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
            </div>
        </div>
    </div>
</div>

<%-- 删除确认 --%>
<div id="confirmDialog" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h5 class="modal-title">提示</h5>
            </div>
            <div class="modal-body">
                <div class=" modal-body-inner"></div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary confirm-do-trigger">确定</button>
                <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function show(obj) {
        var id = obj.id;
        if (id == "searchKey") {
            if (obj.value == "saleDate" ) {
                document.getElementById("dsv").style.display = "none";
                document.getElementById("dbt").style.display = "block";
                document.getElementById("det").style.display = "block";
                document.getElementById("dsOne").style.display = "none";
                document.getElementById("dsTwo").style.display = "none";
            } else if (obj.value == "salePerson" || obj.value == "carModel") {
                document.getElementById("dsv").style.display = "block";
                document.getElementById("dbt").style.display = "none";
                document.getElementById("det").style.display = "none";
                document.getElementById("dsOne").style.display = "block";
                document.getElementById("dsTwo").style.display = "none";
            } else {
                document.getElementById("dsv").style.display = "none";
                document.getElementById("dbt").style.display = "none";
                document.getElementById("det").style.display = "none";
                document.getElementById("dsOne").style.display = "block";
                document.getElementById("dsTwo").style.display = "block";
            }
        }
    }

    $(function () {
        /*确认*/
        $('.paid-trigger').click(function () {
            var self = $(this);
            var title = self.attr('data-title');
            var url = self.attr('data-url');
            var need = self.attr('data-need');
            $('.modal-title').html(title);
            if(need != null){
                $('.modal-body-need').html('还需付款'+ need + '元');
            }
            $('.paid-do-trigger').click(function () {
                document.location.href = url + '&goonPaid=' + document.getElementById('goonPaid').value;
            });
        });
    });

    $(function () {
        /*确认*/
        $('.confirm-trigger').click(function () {
            var self = $(this);
            var tip = self.attr('data-tip');
            var title = self.attr('data-title');
            var url = self.attr('data-url');
            $('.modal-title').html(title);
            $('.modal-body-inner').html(tip);
            $('.confirm-do-trigger').click(function () {
                document.location.href = url;
            });
        });
    });

    var searchKey = document.getElementById('searchKey');
    for (var i = 0; i < searchKey.options.length; i++) {
        if (searchKey.options[i].value == '${searchKey}') {
            searchKey.options[i].selected = true;

            if (searchKey.options[i].value == "saleDate" ) {
                document.getElementById("dsv").style.display = "none";
                document.getElementById("dbt").style.display = "block";
                document.getElementById("det").style.display = "block";
                document.getElementById("dsOne").style.display = "none";
                document.getElementById("dsTwo").style.display = "none";
            } else if (searchKey.options[i].value == "salePerson" || searchKey.options[i].value == "carModel") {
                document.getElementById("dsv").style.display = "block";
                document.getElementById("dbt").style.display = "none";
                document.getElementById("det").style.display = "none";
                document.getElementById("dsOne").style.display = "block";
                document.getElementById("dsTwo").style.display = "none";
            } else {
                document.getElementById("dsv").style.display = "none";
                document.getElementById("dbt").style.display = "none";
                document.getElementById("det").style.display = "none";
                document.getElementById("dsOne").style.display = "block";
                document.getElementById("dsTwo").style.display = "block";
            }
        }
    }
</script>