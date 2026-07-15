System.register(["./index-legacy-BxsGBTT8.js"],function(t,e){"use strict";var n,r,a;return{setters:[t=>{n=t.aH,r=t.aI,a=t.aJ}],execute:function(){
/*!
			 * (C) Ionic http://ionicframework.com - MIT License
			 */
t("createSwipeBackGesture",(t,e,i,s,o)=>{const c=t.ownerDocument.defaultView;let u=n(t);const l=t=>u?-t.deltaX:t.deltaX;return r({el:t,gestureName:"goback-swipe",gesturePriority:101,threshold:10,canStart:r=>(u=n(t),(t=>{const{startX:e}=t;return u?e>=c.innerWidth-50:e<=50})(r)&&e()),onStart:i,onMove:t=>{const e=l(t);s(e/c.innerWidth)},onEnd:t=>{const e=l(t),n=c.innerWidth,r=e/n,i=(h=t,u?-h.velocityX:h.velocityX),s=i>=0&&(i>.2||e>n/2),d=(s?1-r:r)*n;var h;let g=0;if(d>5){const t=d/Math.abs(i);g=Math.min(t,540)}o(s,r<=0?.01:a(0,r,.9999),g)}})})}}});
