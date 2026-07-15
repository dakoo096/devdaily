System.register(["./index-legacy-C6__gWzU.js"],function(e,t){"use strict";var n,r,s,o,a;return{setters:[e=>{n=e.aO,r=e.aP,s=e.aQ,o=e.aR,a=e.aS}],execute:function(){
/*!
			 * (C) Ionic http://ionicframework.com - MIT License
			 */
e("startStatusTap",()=>{const e=window;e.addEventListener("statusTap",()=>{n(()=>{const t=document.elementFromPoint(e.innerWidth/2,e.innerHeight/2);if(!t)return;const n=r(t);n&&new Promise(e=>s(n,e)).then(()=>{o(async()=>{n.style.setProperty("--overflow","hidden"),await a(n,300),n.style.removeProperty("--overflow")})})})})})}}});
