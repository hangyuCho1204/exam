<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<!-- ������ Calendar ���� -->
											<input type="hidden" name="DOM_RT_departureDate" id="DOM_RT_departureDate" value="2016-07-24">
											<input type="hidden" name="DOM_RT_arrivalDate" id="DOM_RT_arrivalDate" value="2016-07-24">
											<div class="each-positype-1" style="top:110px;min-height:36px;">
												<!-- ���� �� - �޷� -->
												<div class="btnAR-calendar"  id="divDOM_RT_DepCalendar">
													<a class="btn_calendar CalendarBtn" href="#none" id="nextCalendarFocusA"><img alt="���� �� �޷� ����" src="/CW/images/btn/btn_calendar3.gif"></a>
													<input type="text" readonly="" class="text01 inputFocusin01" id="viewDate1" title="���� ��" value="2016-07-24">
												</div>
                                                <div class="CalendarBox" id="CalendarBox1" style="top:6px;" tabindex="-1"><!--KWCAG���� -->
                                                    <div class="CalendarInner bg_start" id="sCalArea1"></div>
                                                    <a href="javascript:_cal_close('nextCalendarFocusA');" class="btn_close2"><img src="/CW/images/btn/btn_close2.gif" alt="���³� �޷� ���̾� �˾� �ݱ�"></a>
                                                </div>

                                                <!-- ���� �� - �޷� -->
												<div class="btnAR-calendar" style="margin-left:0;margin-right:0;width:139px;" id="divDOM_RT_ArrCalendar">
													<a class="btn_calendar CalendarBtn" href="#none" id="nextCalendarFocusB"><img alt="���� �� �޷� ����" src="/CW/images/btn/btn_calendar3.gif"></a>
													<input type="text" readonly="" class="text01 inputFocusin01" id="viewDate2" title="���� ��" style="width:99px;"  value="2016-07-24">
												</div>
                                                <div class="CalendarBox" id="CalendarBox2" style="left:144px;" tabindex="-1"><!--KWCAG���� -->
                                                    <div class="CalendarInner bg_arrival" id="sCalArea2"></div>
                                                    <a href="javascript:_cal_close('nextCalendarFocusB');" class="btn_close2"><img src="/CW/images/btn/btn_close2.gif" alt="���³� �޷� ���̾� �˾� �ݱ�"></a>
                                                </div>
											</div>

											<!-- ������ Calendar �� -->


</body>
</html>