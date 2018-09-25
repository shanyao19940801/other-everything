<%@ page import="java.util.List" %>
<%@ page import="com.sinitek.sirm.busin.investpool.entity.IInvestPoolAdjustLog" %>
<%--<%@ page import="com.sinitek.sirm.workflow.entity.IWorkflowApproveInfo" %>--%>
<%--<%@ page import="com.sinitek.sirm.workflow.service.WorkflowServiceFactory" %>--%>
<%--
 * File Desc:      
 * Product Name: SIRM
 * Module Name: InvestPool
 * Author:      陈松
 * History:     11-5-18 created by 陈松
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/includes/investpoolincludes.jsp" %>
<%--<%@ taglib uri="http://www.sinitek.com/sirm/org/tag" prefix="org" %>--%>

<html>
<head><title>投资池工作流</title>
    <script type="text/javascript" src="${contextPath}/common/attachment/downattachmentwindow.js" charset="UTF-8"></script>
</head>
<sirm:body>
<%
//    List<IWorkflowApproveInfo> _approveList = null;
//    try {
//        _approveList = WorkflowServiceFactory.getWorkflowService().findApproveInfosBySourceEntitySourceId(IInvestPoolAdjustLog.ENTITY_NAME, Integer.parseInt(request.getParameter("id")));
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//    request.setAttribute("approveList", _approveList);
%>

<form action="investpooladjustmanageaction!inquestInvestPool.action" id="inquestInvestPoolForm" method="post">
<input type="hidden" name="id" value="${param.id}">
<input type="hidden" name="stepid" value="${param.stepid}">
<input type="hidden" value="${m.hmktcode}" name="mktcode" id="hmktcode">
<input type="hidden" value="${m.hstype}" name="stype" id="hstype">
<input type="hidden" value="${m.hscode}" name="scode" id="hscode">
<input type="hidden" name="poolIdsAndpoolSeq" value="${m.poolIdsAndpoolSeq}">
<input type="hidden" name="succeedOutPoolId" value="${succeedOutPoolId}">
<input type="hidden" name="succeedInPoolId" value="${succeedInPoolId}">
<input type="hidden" name="exampleownerid" value="${exampleownerid}">
<input type="hidden" name="examplestepid" value="${examplestepid}">
<input type="hidden" name="exampleid" value="${exampleid}">
<jsp:include page="/includes/includebond.jsp"/>
<script type="text/javascript">
    function gotobaogao(id,type) {
        if(id!=null && id!='' && type == 1){
            $(document).stk_go("/rschreport/innerreport/viewinnerreport.action?reportId="+id+"", "查看报告");
        }else{
            $(document).stk_go("/rschreport/outerreport/viewouterreport.action?reportId=" + id + "", "查看外部报告");
        }
    }

</script>

<div class="pool-info-box">
    <div class="hd stk-ui-bar">
        <span class="tit"><span>详细信息</span></span>
    </div>
    <div class="bd">
            <div class="pl10 pt10 pr10 pb10 zoom">
                <table class="stk-table stk-table-st1" width="100%" >
                <thead>
                <tr>
                    <th class="stk-table-th alignL" style="white-space:nowrap;">投资池名称</th>
                    <th class="stk-table-th alignL" style="white-space:nowrap;">调整类型</th>
                    <th class="stk-table-th alignL" style="white-space:nowrap;">结果</th>
                    <th class="stk-table-th alignL" style="white-space:nowrap;">报告名称</th>
                    <th class="stk-table-th alignL" style="white-space:nowrap;">附件名称</th>
                    <th class="stk-table-th alignL" style="white-space:nowrap;">审批状态</th>
                </tr>

                </thead>
                <tbody>
                <c:forEach items="${allAdjustCheckResults}" var="i" varStatus="s">
                        <tr class="stk-table-tr-odd">
                            <td class="stk-table-td alignL" style="text-align:center;">${i.poolName}</td>
                            <td class="stk-table-td alignL" style="text-align:center;">${i.adjustTypeName}</td>
                            <c:if test="${i.code==1|| i.code ==2}">
                                <td class="stk-table-td alignL">${i.description}</td>
                            </c:if>
                            <c:if test="${i.code==0}">
                                <td class="stk-table-td alignL" style="text-align:center;"><font color="#dc143c">${i.description}</font></td>
                            </c:if>

                            <td class="stk-table-td alignL" style="text-align:center;">
                                <c:forEach items="${i.ireports}" var="r" varStatus="s">
                                    <a href="#" onclick="gotobaogao(${r.id}+'',${r.type})"> ${r.title} </a>
                                    <c:if test="${!s.last}">
                                            <br/>
                                        </c:if>
                                </c:forEach>
                            </td>
                            <td class="stk-table-td alignL" style="text-align:center;">
                                <c:forEach items="${i.attachments}" var="t" varStatus="s">
                                    <a href="${contextPath}/investpool/downloadattachment.action?objid=${t.id}" target="_blank"> ${t.name}</a>
                                    <c:if test="${!s.last}">
                                        <br/>
                                    </c:if>

                                </c:forEach>
                            </td>
                            <td class="stk-table-td alignL" style="text-align:center;">
                                <c:if test="${i.iInvestPoolAdjustLog.ApproveStatus ==-1}">
                                    无效调整
                                </c:if>
                                <c:if test="${i.iInvestPoolAdjustLog.ApproveStatus == 10}">
                                    待审批
                                </c:if>
                                <c:if test="${i.iInvestPoolAdjustLog.ApproveStatus == 50}">
                                    审批驳回
                                </c:if>
                                <c:if test="${i.iInvestPoolAdjustLog.ApproveStatus == 100}">
                                    审批通过
                                </c:if>
                                <c:if test="${i.iInvestPoolAdjustLog.ApproveStatus == 150}">
                                                审批终止
                                            </c:if>
                            </td>
                        </tr>

                </c:forEach>
                </tbody>
            </table>
            </div>
    </div>
</div>
<div class="stk-box-s2">
    <div class="stk-hd stk-ui-bar"><span class="stk-tit"><label><input type="checkbox" class="verMiddle">调整投资评级</label></span></div>
    <div class="stk-bd zoom">
        <table  class="stk-form-ui-st1" id="table_jack_pj"  >
            <tr>
                   <td width="10%" class="hd">&nbsp;&nbsp;债项评级</td><td class="bd" width="20%">
                   ${indicatorCodeMap.j0019}&nbsp;
               </td>
                   <td  width="10%" class="hd">展望评级</td><td class="bd" width="20%">
                   ${indicatorCodeMap.j0020}&nbsp;
               </td>
                   <td  width="10%" class="hd"></td><td class="bd" width="20%">
               </td>
               </tr>
               <tr>
                   <td width="10%" class="hd">&nbsp;&nbsp;主体长期评级</td><td class="bd" width="20%">
                   ${indicatorCodeMap.j0014}&nbsp;
               </td>
                   <td  width="10%" class="hd">主体短期评级</td><td class="bd" width="20%">
                   ${indicatorCodeMap.j0015}&nbsp;
               </td>
                   <td  width="10%" class="hd">主体展望评级</td><td class="bd" width="20%">
                  ${indicatorCodeMap.j0016}&nbsp;
               </td>
               </tr>
           </table>
        <script type="text/javascript">
            if(${indicatorCodeMap.j0019}+'' == '' && ${indicatorCodeMap.j0020}+''=='' && ${indicatorCodeMap.j0014}+''==''&&${indicatorCodeMap.j0015}+''==''&& ${indicatorCodeMap.j0016}+''== ''){
                $("#table_jack_pj").hide(true);
            }
        </script>
       </div>
    </div>
<div class="stk-box-s2">
    <div class="stk-hd stk-ui-bar"><span class="stk-tit"><label><input type="checkbox" class="verMiddle">原因和建议</label></span></div>
    <div class="stk-bd zoom">
     <table class="stk-form-ui-st1">
    <tr>
        <td class="hd" width="10%"><label>原因</label></td>
        <td class="bd" align="left">
            ${Reason}
        </td>
    </tr>
    <tr>
        <td class="hd" width="10%"><label>建议</label></td>
        <td class="bd" align="left">
            ${Suggest}
        </td>
    </tr>
</table>
    </div>
</div>


<%--<table class="stk-form-ui-st1">--%>

<%--<%--%>
    <%--Object object = request.getAttribute("approveList");--%>
    <%--if (!"[]".equals(object.toString())) {--%>
<%--%>--%>
<%--<tr>--%>
    <%--<td class="bd" colspan="2">--%>
        <%--<layout:panel title="已有的审批意见" >--%>

            <%--<layout:box width="100%" layout="column" >--%>
                <%--<layout:boxcell label="审批人" width="25%"></layout:boxcell>--%>
                <%--<layout:boxcell label="审批时间" width="25%"></layout:boxcell>--%>
                <%--<layout:boxcell label="审批内容" width="50%"></layout:boxcell>--%>
            <%--</layout:box>--%>
            <%--<c:forEach items="${approveList}" var="approve">--%>
                <%--<layout:box width="100%" layout="column" >--%>
                    <%--<org:employeeTag var="employee" orgid="${approve.approverId}"/>--%>
                    <%--<layout:boxcell width="25%"><ui:label>${employee.empName}</ui:label></layout:boxcell>--%>
                    <%--<layout:boxcell width="25%"><ui:label>--%>
                        <%--<fmt:formatDate value="${approve.approveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>--%>
                    <%--</ui:label></layout:boxcell>--%>
                    <%--<layout:boxcell width="50%"><ui:label>${approve.opinion}</ui:label></layout:boxcell>--%>
                <%--</layout:box>--%>
            <%--</c:forEach>--%>
        <%--</layout:panel>--%>
    <%--</td>--%>
<%--</tr>--%>
<%--<%--%>
    <%--}--%>
<%--%>--%>

<%--<c:if test="${param.isend == 0}">--%>
    <%--<tr>--%>
        <%--<td class="hd">审批人</td>--%>
        <%--<td class="bd">--%>
            <%--<jsp:include page="/org/searchorg/searchuserinclude.jsp">--%>
                <%--<jsp:param name="prefix" value="assignStatus"/>--%>
                <%--<jsp:param name="showdiv" value="false"/>--%>
                <%--<jsp:param name="relationDiv" value="indusryRelationDiv"/>--%>
            <%--</jsp:include>--%>
        <%--</td>--%>
    <%--</tr>--%>

<%--</c:if>--%>
<%--<tr>--%>
    <%--<td class="hd">审批意见</td>--%>
    <%--<td class="bd">--%>
        <%--<ui:textarea rows="8" width="500px" id="opinion" name="opinion"></ui:textarea>--%>
        <%--<input type="hidden" name="approve" id="approve">--%>
        <input type="hidden" name="ownerId" id="ownerId">
    <%--</td>--%>
<%--</tr>--%>
<%--</table>--%>
<div class="stk-box-s2">
    <div class="stk-hd stk-ui-bar"><span class="stk-tit"><label><input type="checkbox" class="verMiddle">审批</label></span></div>
    <div class="stk-bd zoom">
        <table width="100%"  class="stk-form-ui-st1">
            <c:if test="${param.isvote == null || param.isvote == 0}">
                <tr align="left">
                    <td class="hd">
                        是否审批通过
                    </td>
                    <td class="bd" colspan="5">
                        <ui:radiobox name="approve" id="yes" value="1" checked="true">
                        </ui:radiobox>是 &nbsp;&nbsp;
                        <ui:radiobox name="approve" id="no" value="2">
                        </ui:radiobox>否（驳回）
                    </td>
                </tr>
                <tr>
                    <td class="hd">
                        审批意见
                    </td>
                    <td class="bd" colspan="5">
                        <ui:textarea rows="8" width="500px" id="opinion" name="opinion"></ui:textarea>
                    </td>
                </tr>
            </c:if>
            <c:if test="${param.isvote == 1}">
                <tr align="left">
                    <td class="hd">
                        选择投票结果
                    </td>
                    <td class="bd" colspan="5">
                        <ui:radiobox name="approve" id="yes" value="1">
                        </ui:radiobox>同意 &nbsp;&nbsp;
                        <ui:radiobox name="approve" id="no" value="2">
                        </ui:radiobox>反对 &nbsp;&nbsp;
                            <%--<ui:radiobox name="approve" id="waiver" value="2" checked="true">--%>
                            <%--</ui:radiobox>弃权--%>
                    </td>
                </tr>
                <tr>
                    <td class="hd">
                        投票意见
                    </td>
                    <td class="bd" colspan="5">
                        <ui:textarea rows="8" width="500px" id="opinion" name="opinion"></ui:textarea>
                    </td>
                </tr>
            </c:if>



        </table>
    </div>
</div>
<div class="submit-btn-bar">
    <c:if test="${isok == 'ok'}">
        <ui:button text="提交审批" id="approveButton">
            <event:onclick>
                <%--var approve = $("#yes").attr("checked");--%>
                <%--if(approve == 0){--%>
                var approve = $("#no").attr("checked");
                if(approve == 1){
                stk.confirm("确认驳回么？", function() {
                if (${maillink eq "true"} || ${maillink eq true}) {
                $('#approveButton').attr('disabled','disabled');
                ajaxSubmit();
                } else {
                $("#inquestInvestPoolForm").submit();
                $('#approveButton').attr('disabled','disabled');
                <%--jumpIntegration();--%>
                }
                });
                }else{
                if (${maillink eq "true"} || ${maillink eq true}) {
                $('#approveButton').attr('disabled','disabled');
                ajaxSubmit();
                } else {
                $("#inquestInvestPoolForm").submit();
                $('#approveButton').attr('disabled','disabled');
                <%--jumpIntegration();--%>
                }
                }
                <%--}else if(approve == 1){--%>
                <%--$("#checkInquestInvestPoolForm").stk_submit(function(result){--%>
                <%--if(result== ''){--%>
                <%--$("#inquestInvestPoolForm").submit();--%>
                <%--$('#approveButton').attr('disabled','disabled');--%>
                <%--}else{--%>
                <%--stk.info(result);--%>
                <%--}--%>
                <%--});--%>
                <%--}--%>
            </event:onclick>
        </ui:button>
    </c:if>
    <c:if test="${isok == 'err'}">
        <ui:button text="提交审批" id="approveButton">
            <event:onclick>
                stk.info("你没有权限审批");
            </event:onclick>
        </ui:button>
    </c:if>
</div>

</form>
<c:if test="${exampleid != null}">
    <jsp:include page="${path}/workflow/include/showworkflowhistory.jsp" flush="true">
        <jsp:param name="exampleid" value="${exampleid}"></jsp:param>
    </jsp:include>
</c:if>
<ui:form id="checkInquestInvestPoolForm" clazz="com.sinitek.sirm.web.investpool.InvestPoolAdjustManageAction" method="checkInquestInvestPool">
    <input name="checkLogId" value="${param.id}" type="hidden" id="checkLogId">
</ui:form>
<script type="text/javascript">
    $(document).ready(function() {
        sirm.form.checker.checkInputContent('#opinion', 250);
    });

    function jumpIntegration() {
        if (${maillink eq "true"} || ${maillink eq true}) {
            if (${havetodo eq "true"} || ${havetodo eq true}) {
                if (${not empty ythUrl}) {
                    var explorer = window.navigator.userAgent.toLowerCase();
                    if (explorer.indexOf("msie") >= 0) {
                        window.opener = null;
                        window.open("", "_self");
                    }
                    window.open("${ythUrl}", "_blank");
                }
            }
            window.close();
        }
    }

    function ajaxSubmit() {
        var approve = $("#no").attr("checked");
        var opinion = $("#opinion").stk_val();
        var newWindow = window.open();  //新开一个，避免ajax里面弹窗拦截
        $.ajax({
            url: "${contextPath}/investpool/investpooladjustmanageaction!inquestInvestPool.action",
            type: "post",
            dataType: "json",
            data: {
                "id": "${param.id}",
                "stepid": "${param.stepid}",
                "mktcode": "${m.hmktcode}",
                "stype": "${m.hstype}",
                "scode": "${m.hscode}",
                "poolIdsAndpoolSeq": "${m.poolIdsAndpoolSeq}",
                "succeedOutPoolId": "${succeedOutPoolId}",
                "succeedInPoolId": "${succeedInPoolId}",
                "exampleownerid": "${exampleownerid}",
                "examplestepid": "${examplestepid}",
                "exampleid": "${exampleid}",
                "approve": approve,
                "opinion": opinion
            },
            success: function (data) {
                if (${havetodo eq "true"} || ${havetodo eq true}) {
                    if (${not empty ythUrl}) {
                        var explorer = window.navigator.userAgent.toLowerCase();
                        if (explorer.indexOf("msie") >= 0) {
                            window.opener = null;
                            window.open("", "_self");
                        }
                        newWindow.location.href = "${ythUrl}";
                    }
                } else {
                    newWindow.close();
                }
                window.close();
            },
            error: function (e) {
                if (${havetodo eq "true"} || ${havetodo eq true}) {
                    if (${not empty ythUrl}) {
                        var explorer = window.navigator.userAgent.toLowerCase();
                        if (explorer.indexOf("msie") >= 0) {
                            window.opener = null;
                            window.open("", "_self");
                        }
                        newWindow.location.href = "${ythUrl}";
                    }
                } else {
                    newWindow.close();
                }
                window.close();
            }
        });
    }
</script>
</sirm:body>
</html>