<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp =	request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SampleToggle.jsp</title>

<style type="text/css">

/* 기본 스타일 */
input[type="checkbox"] {
  display: none;
}

input[type="checkbox"] + label {
  display: inline-block;
  width: 40px;
  height: 20px;
  position: relative;
  transition: 0.3s;
  margin: 0 20px;
  box-sizing: border-box;
}

input[type="checkbox"] + label:after,
input[type="checkbox"] + label:before {
  content: '';
  display: block;
  position: absolute;
  left: 0;
  top: 0;
  width: 20px;
  height: 20px;
  transition: 0.3s;
  cursor: pointer;
}

/* Simple 토글 */
#simple-1:checked + label.red,
#simple-2:checked + label.red,
#simple-3:checked + label.red {
  background: #ECA9A7;
}
#simple-1:checked + label.red:after,
#simple-2:checked + label.red:after,
#simple-3:checked + label.red:after {
  background: #D9534F;
}

#simple-1:checked + label.green,
#simple-2:checked + label.green,
#simple-3:checked + label.green {
  background: #AEDCAE;
}
#simple-1:checked + label.green:after,
#simple-2:checked + label.green:after,
#simple-3:checked + label.green:after {
  background: #5CB85C;
}

#simple-1:checked + label:after,
#simple-2:checked + label:after,
#simple-3:checked + label:after {
  left: calc(100% - 20px);
}

#simple-1 + label,
#simple-2 + label,
#simple-3 + label {
  background: #ddd;
  border-radius: 20px;
  box-shadow: 1px 1px 3px #aaa;
}
#simple-1 + label:after,
#simple-2 + label:after,
#simple-3 + label:after {
  background: #fff;
  border-radius: 50%;
  box-shadow: 1px 1px 3px #aaa;
}

/* Material design 토글 */
#md-1:checked + label.red,
#md-2:checked + label.red,
#md-3:checked + label.red {
  background: #ECA9A7;
}
#md-1:checked + label.red:after,
#md-2:checked + label.red:after,
#md-3:checked + label.red:after {
  background: #D9534F;
}

#md-1:checked + label.green,
#md-2:checked + label.green,
#md-3:checked + label.green {
  background: #AEDCAE;
}
#md-1:checked + label.green:after,
#md-2:checked + label.green:after,
#md-3:checked + label.green:after {
  background: #5CB85C;
}

#md-1:checked + label:after,
#md-2:checked + label:after,
#md-3:checked + label:after {
  left: calc(100% - 20px);
}

#md-1 + label,
#md-2 + label,
#md-3 + label {
  background: #ddd;
  border-radius: 20px;
  height: 10px;
}
#md-1 + label:after,
#md-2 + label:after,
#md-3 + label:after {
  background: #fff;
  border-radius: 50%;
  top: -5px;
  box-shadow: 0px 0px 3px #aaa;
}

/* Material design small 토글 */
#mds-1:checked + label.red,
#mds-2:checked + label.red,
#mds-3:checked + label.red {
  background: #ECA9A7;
}
#mds-1:checked + label.red:after,
#mds-2:checked + label.red:after,
#mds-3:checked + label.red:after {
  background: #D9534F;
}

#mds-1:checked + label.green,
#mds-2:checked + label.green,
#mds-3:checked + label.green {
  background: #AEDCAE;
}
#mds-1:checked + label.green:after,
#mds-2:checked + label.green:after,
#mds-3:checked + label.green:after {
  background: #5CB85C;
}

#mds-1:checked + label:after,
#mds-2:checked + label:after,
#mds-3:checked + label:after {
  left: calc(100% - 20px);
}

#mds-1 + label,
#mds-2 + label,
#mds-3 + label {
  background: #ddd;
  height: 3px;
}
#mds-1 + label:after,
#mds-2 + label:after,
#mds-3 + label:after {
  background: #fff;
  border-radius: 50%;
  top: -9px;
  box-shadow: 0px 0px 3px #aaa;
}

/* Border 토글 */
#border-1:checked + label.red,
#border-2:checked + label.red,
#border-3:checked + label.red {
  border-color: #ECA9A7;
}
#border-1:checked + label.red:after,
#border-2:checked + label.red:after,
#border-3:checked + label.red:after {
  background: #D9534F;
}

#border-1:checked + label.green,
#border-2:checked + label.green,
#border-3:checked + label.green {
  border-color: #AEDCAE;
}
#border-1:checked + label.green:after,
#border-2:checked + label.green:after,
#border-3:checked + label.green:after {
  background: #5CB85C;
}

#border-1:checked + label:after,
#border-2:checked + label:after,
#border-3:checked + label:after {
  left: calc(100% - 14px);
}

#border-1 + label,
#border-2 + label,
#border-3 + label {
  border: 2px solid #ddd;
  border-radius: 20px;
}
#border-1 + label:after,
#border-2 + label:after,
#border-3 + label:after {
  background: #ddd;
  border-radius: 50%;
  width: 12px;
  height: 12px;
  top: 2px;
  left: 2px;
}

/* Inset 토글 */
#inset-1:checked + label.red,
#inset-2:checked + label.red,
#inset-3:checked + label.red {
  background: #ECA9A7;
}
#inset-1:checked + label.red:after,
#inset-2:checked + label.red:after,
#inset-3:checked + label.red:after {
  background: #D9534F;
}

#inset-1:checked + label.green,
#inset-2:checked + label.green,
#inset-3:checked + label.green {
  background: #AEDCAE;
}
#inset-1:checked + label.green:after,
#inset-2:checked + label.green:after,
#inset-3:checked + label.green:after {
  background: #5CB85C;
}

#inset-1:checked + label:after,
#inset-2:checked + label:after,
#inset-3:checked + label:after {
  left: calc(100% - 18px);
}

#inset-1 + label,
#inset-2 + label,
#inset-3 + label {
  background: #ddd;
  border-radius: 20px;
}
#inset-1 + label:after,
#inset-2 + label:after,
#inset-3 + label:after {
  background: #fff;
  border-radius: 50%;
  width: 16px;
  height: 16px;
  top: 2px;
  left: 2px;
}

/* Box 토글 */
#box-1:checked + label.red,
#box-2:checked + label.red,
#box-3:checked + label.red {
  background: #ECA9A7;
}
#box-1:checked + label.red:after,
#box-2:checked + label.red:after,
#box-3:checked + label.red:after {
  background: #D9534F;
}

#box-1:checked + label.green,
#box-2:checked + label.green,
#box-3:checked + label.green {
  background: #AEDCAE;
}
#box-1:checked + label.green:after,
#box-2:checked + label.green:after,
#box-3:checked + label.green:after {
  background: #5CB85C;
}

#box-1:checked + label:after,
#box-2:checked + label:after,
#box-3:checked + label:after {
  left: calc(100% - 18px);
}

#box-1 + label,
#box-2 + label,
#box-3 + label {
  background: #ddd;
}
#box-1 + label:after,
#box-2 + label:after,
#box-3 + label:after {
  background: #fff;
  width: 16px;
  height: 16px;
  top: 2px;
  left: 2px;
}

/* Flex 토글 */
#flex-1:checked + label.red,
#flex-2:checked + label.red,
#flex-3:checked + label.red {
  background: #ECA9A7;
}
#flex-1:checked + label.red:after,
#flex-2:checked + label.red:after,
#flex-3:checked + label.red:after {
  background: #D9534F;
}

#flex-1:checked + label.green,
#flex-2:checked + label.green,
#flex-3:checked + label.green {
  background: #AEDCAE;
}
#flex-1:checked + label.green:after,
#flex-2:checked + label.green:after,
#flex-3:checked + label.green:after {
  background: #5CB85C;
}

#flex-1:checked + label:active:after,
#flex-2:checked + label:active:after,
#flex-3:checked + label:active:after {
  left: calc(100% - 28px);
}

#flex-1:checked + label:after,
#flex-2:checked + label:after,
#flex-3:checked + label:after {
  left: calc(100% - 18px);
}

#flex-1 + label,
#flex-2 + label,
#flex-3 + label {
  background: #ddd;
  border-radius: 20px;
}
#flex-1 + label:active:after,
#flex-2 + label:active:after,
#flex-3 + label:active:after {
  width: 26px;
}
#flex-1 + label:after,
#flex-2 + label:after,
#flex-3 + label:after {
  background: #fff;
  border-radius: 10px;
  width: 16px;
  height: 16px;
  top: 2px;
  left: 2px;
}

/* Full Flex 토글 */
#fullFlex-1:checked + label.red,
#fullFlex-2:checked + label.red,
#fullFlex-3:checked + label.red {
  background: #D9534F;
}
#fullFlex-1:checked + label.red:after,
#fullFlex-2:checked + label.red:after,
#fullFlex-3:checked + label.red:after {
  background: #ECA9A7;
}

#fullFlex-1:checked + label.green,
#fullFlex-2:checked + label.green,
#fullFlex-3:checked + label.green {
  background: #5CB85C;
}
#fullFlex-1:checked + label.green:after,
#fullFlex-2:checked + label.green:after,
#fullFlex-3:checked + label.green:after {
  background: #AEDCAE;
}

#fullFlex-1:checked + label:after,
#fullFlex-2:checked + label:after,
#fullFlex-3:checked + label:after {
  width: 36px;
}

#fullFlex-1 + label,
#fullFlex-2 + label,
#fullFlex-3 + label {
  background: #ddd;
  border-radius: 20px;
}
#fullFlex-1 + label:after,
#fullFlex-2 + label:after,
#fullFlex-3 + label:after {
  background: #fff;
  border-radius: 10px;
  width: 16px;
  height: 16px;
  top: 2px;
  left: 2px;
}

/* Bubble 토글 */
#bubble-1:checked + label.red,
#bubble-2:checked + label.red,
#bubble-3:checked + label.red {
  background: #ECA9A7;
}
#bubble-1:checked + label.red:after,
#bubble-2:checked + label.red:after,
#bubble-3:checked + label.red:after {
  background: #D9534F;
}

#bubble-1:checked + label.green,
#bubble-2:checked + label.green,
#bubble-3:checked + label.green {
  background: #AEDCAE;
}
#bubble-1:checked + label.green:after,
#bubble-2:checked + label.green:after,
#bubble-3:checked + label.green:after {
  background: #5CB85C;
}

#bubble-1:checked + label.red:before,
#bubble-2:checked + label.red:before,
#bubble-3:checked + label.red:before {
  background: #D9534F;
}
#bubble-1:checked + label.green:before,
#bubble-2:checked + label.green:before,
#bubble-3:checked + label.green:before {
  background: #5CB85C;
}

#bubble-1:checked + label:active:before,
#bubble-2:checked + label:active:before,
#bubble-3:checked + label:active:before {
  left: calc(100% - 30px);
}

#bubble-1:checked + label:after,
#bubble-2:checked + label:after,
#bubble-3:checked + label:after,
#bubble-1:checked + label:before,
#bubble-2:checked + label:before,
#bubble-3:checked + label:before {
  left: calc(100% - 20px);
}

#bubble-1 + label,
#bubble-2 + label,
#bubble-3 + label {
  background: #ddd;
  border-radius: 20px;
  height: 10px;
}
#bubble-1 + label:active:before,
#bubble-2 + label:active:before,
#bubble-3 + label:active:before {
  width: 40px;
  height: 40px;
  left: -10px;
  top: -15px;
}
#bubble-1 + label:after,
#bubble-2 + label:after,
#bubble-3 + label:after {
  background: #fff;
  border-radius: 50%;
  top: -5px;
  box-shadow: 0px 0px 3px #aaa;
}
#bubble-1 + label:before,
#bubble-2 + label:before,
#bubble-3 + label:before {
  top: -5px;
  border-radius: 50%;
  background: #ddd;
  opacity: 0.5;
  transition: width height 0.01s;
}

/* Teleport 토글 */
#teleport-1:checked + label.red,
#teleport-2:checked + label.red,
#teleport-3:checked + label.red {
  border-color: #ECA9A7;
}
#teleport-1:checked + label.red:before,
#teleport-2:checked + label.red:before,
#teleport-3:checked + label.red:before {
  background: #D9534F;
}

#teleport-1:checked + label.green,
#teleport-2:checked + label.green,
#teleport-3:checked + label.green {
  border-color: #AEDCAE;
}
#teleport-1:checked + label.green:before,
#teleport-2:checked + label.green:before,
#teleport-3:checked + label.green:before {
  background: #5CB85C;
}

#teleport-1:checked + label:after,
#teleport-2:checked + label:after,
#teleport-3:checked + label:after {
  left: -13px;
}

#teleport-1:checked + label:before,
#teleport-2:checked + label:before,
#teleport-3:checked + label:before {
  width: 12px;
  height: 12px;
  left: calc(100% - 15px);
}

#teleport-1 + label,
#teleport-2 + label,
#teleport-3 + label {
  border: 2px solid #ddd;
  border-radius: 20px;
  overflow: hidden;
}
#teleport-1 + label:after,
#teleport-2 + label:after,
#teleport-3 + label:after {
  background: #ddd;
  border-radius: 10px;
  width: 12px;
  height: 12px;
  top: 2px;
  left: 2px;
}
#teleport-1 + label:before,
#teleport-2 + label:before,
#teleport-3 + label:before {
  background: #ddd;
  border-radius: 10px;
  left: 100%;
  width: 12px;
  height: 12px;
  top: 2px;
}

/* UnderLine 토글 */
#uLine-1:checked + label.red,
#uLine-2:checked + label.red,
#uLine-3:checked + label.red {
  border-color: #ECA9A7;
}
#uLine-1:checked + label.red:after,
#uLine-2:checked + label.red:after,
#uLine-3:checked + label.red:after,
#uLine-1:checked + label.red:before,
#uLine-2:checked + label.red:before,
#uLine-3:checked + label.red:before {
  background: #D9534F;
}

#uLine-1:checked + label.green,
#uLine-2:checked + label.green,
#uLine-3:checked + label.green {
  border-color: #AEDCAE;
}
#uLine-1:checked + label.green:after,
#uLine-2:checked + label.green:after,
#uLine-3:checked + label.green:after,
#uLine-1:checked + label.green:before,
#uLine-2:checked + label.green:before,
#uLine-3:checked + label.green:before {
  background: #5CB85C;
}

#uLine-1:checked + label:before,
#uLine-2:checked + label:before,
#uLine-3:checked + label:before {
  left: calc(100% + 8px);
}

#uLine-1:checked + label:active:before,
#uLine-2:checked + label:active:before,
#uLine-3:checked + label:active:before {
  left: calc(100% - 2px);
}

#uLine-1 + label,
#uLine-2 + label,
#uLine-3 + label {
  background: #ddd;
  border-radius: 20px;
  width: 16px;
  height: 16px;
  cursor: pointer;
}
#uLine-1 + label:after,
#uLine-2 + label:after,
#uLine-3 + label:after {
  background: #ddd;
  border-radius: 10px;
  width: 16px;
  height: 16px;
  left: 26px;
}
#uLine-1 + label:active:before,
#uLine-2 + label:active:before,
#uLine-3 + label:active:before {
  width: 30px;
}
#uLine-1 + label:before,
#uLine-2 + label:before,
#uLine-3 + label:before {
  background: #ddd;
  border-radius: 10px;
  left: -2px;
  width: 20px;
  height: 2px;
  top: auto;
  bottom: -6px;
}

/* ---------------------- */
h3 {
  font-family: verdana;
}

.row {
  width: 50%;
  display: block;
  line-height: 60px;
  text-align: center;
  float: left;
}

@media screen and (max-width: 600px) {
  .row {
    width: 100%;
    float: none;
  }
}


</style>

</head>
<body>
<div class="row">
  <h3>Simple</h3>
  <input type="checkbox" id="simple-1">
  <label for="simple-1"></label>
  <input type="checkbox" id="simple-2">
  <label for="simple-2" class="red"></label>
  <input type="checkbox" id="simple-3">
  <label for="simple-3" class="green"></label>
</div>

<div class="row">
  <h3>Material design</h3>
  <input type="checkbox" id="md-1">
  <label for="md-1"></label>
  <input type="checkbox" id="md-2">
  <label for="md-2" class="red"></label>
  <input type="checkbox" id="md-3">
  <label for="md-3" class="green"></label>
</div>

<div class="row">
  <h3>Material design small</h3>
  <input type="checkbox" id="mds-1">
  <label for="mds-1"></label>
  <input type="checkbox" id="mds-2">
  <label for="mds-2" class="red"></label>
  <input type="checkbox" id="mds-3">
  <label for="mds-3" class="green"></label>
</div>

<div class="row">
  <h3>Border</h3>
  <input type="checkbox" id="border-1">
  <label for="border-1"></label>
  <input type="checkbox" id="border-2">
  <label for="border-2" class="red"></label>
  <input type="checkbox" id="border-3">
  <label for="border-3" class="green"></label>
</div>

<div class="row">
  <h3>Inset</h3>
  <input type="checkbox" id="inset-1">
  <label for="inset-1"></label>
  <input type="checkbox" id="inset-2">
  <label for="inset-2" class="red"></label>
  <input type="checkbox" id="inset-3">
  <label for="inset-3" class="green"></label>
</div>

<div class="row">
  <h3>Box</h3>
  <input type="checkbox" id="box-1">
  <label for="box-1"></label>
  <input type="checkbox" id="box-2">
  <label for="box-2" class="red"></label>
  <input type="checkbox" id="box-3">
  <label for="box-3" class="green"></label>
</div>

<div class="row">
  <h3>Flex</h3>
  <input type="checkbox" id="flex-1">
  <label for="flex-1"></label>
  <input type="checkbox" id="flex-2">
  <label for="flex-2" class="red"></label>
  <input type="checkbox" id="flex-3">
  <label for="flex-3" class="green"></label>
</div>

<div class="row">
  <h3>Full Flex</h3>
  <input type="checkbox" id="fullFlex-1">
  <label for="fullFlex-1"></label>
  <input type="checkbox" id="fullFlex-2">
  <label for="fullFlex-2" class="red"></label>
  <input type="checkbox" id="fullFlex-3">
  <label for="fullFlex-3" class="green"></label>
</div>

<div class="row">
  <h3>Bubble</h3>
  <input type="checkbox" id="bubble-1">
  <label for="bubble-1"></label>
  <input type="checkbox" id="bubble-2">
  <label for="bubble-2" class="red"></label>
  <input type="checkbox" id="bubble-3">
  <label for="bubble-3" class="green"></label>
</div>

<div class="row">
  <h3>Teleport</h3>
  <input type="checkbox" id="teleport-1">
  <label for="teleport-1"></label>
  <input type="checkbox" id="teleport-2">
  <label for="teleport-2" class="red"></label>
  <input type="checkbox" id="teleport-3">
  <label for="teleport-3" class="green"></label>
</div>

<div class="row">
  <h3>UnderLine</h3>
  <input type="checkbox" id="uLine-1">
  <label for="uLine-1"></label>
  <input type="checkbox" id="uLine-2">
  <label for="uLine-2" class="red"></label>
  <input type="checkbox" id="uLine-3">
  <label for="uLine-3" class="green"></label>
</div>
</body>
</html>