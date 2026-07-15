import{aO as o,aP as s,aQ as r,aR as i,aS as m}from"./index-CT6dKE6N.js";/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */const d=()=>{const e=window;e.addEventListener("statusTap",()=>{o(()=>{const a=document.elementFromPoint(e.innerWidth/2,e.innerHeight/2);if(!a)return;const t=s(a);t&&new Promise(n=>r(t,n)).then(()=>{i(async()=>{t.style.setProperty("--overflow","hidden"),await m(t,300),t.style.removeProperty("--overflow")})})})})};export{d as startStatusTap};
