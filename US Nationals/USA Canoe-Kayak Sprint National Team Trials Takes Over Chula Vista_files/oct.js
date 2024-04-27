twttr=window.twttr||{},twttr.conversion=function(){var t="&tpx_cb=twttr.conversion.loadPixels",e="//web.archive.org/web/20160516000921/http://t.co/i/adsct?p_id=Twitter&p_user_id=0",n="https://web.archive.org/web/20160516000921/https://analytics.twitter.com/i/adsct?p_id=Twitter&p_user_id=0";return{trackBase:function(t,e,n,i){if(e&&n){var r=t+"&merch_id="+encodeURIComponent(e);r+="&event="+encodeURIComponent(n),i&&(r+="&value="+encodeURIComponent(i)),this.buildPixel(r)}},trackPidBase:function(e,n,i,r){if(n){var o="";if("object"==typeof i){"tw_sale_amount"in i||(i.tw_sale_amount=0),"tw_order_quantity"in i||(i.tw_order_quantity=0);for(var a in i)i.hasOwnProperty(a)&&(o+="&"+(encodeURIComponent(a)+"="+encodeURIComponent(i[a])))}else o="&tw_sale_amount=0&tw_order_quantity=0";var d=e+"&txn_id="+encodeURIComponent(n)+o,s=this.getIframeStatus();if(d+="&tw_iframe_status="+encodeURIComponent(s.value),s===this.IframeStatusCodes.IN_IFRAME&&""!=document.referrer){var c=encodeURIComponent(document.referrer);d+="&tw_document_referrer="+c}var u=this.buildPixel;r&&(d+=t,u=this.buildScript);var f=this.getHiddenProp();this.isDocumentHidden()?this.buildPixelWhenVizChange(d,f,u):u(d)}},track:function(t,i,r){this.trackBase(n,t,i,r),this.trackBase(e,t,i,r)},trackPid:function(t,i){var r=this.isEligibleForJsonp(t);this.trackPidBase(n,t,i,r),this.trackPidBase(e,t,i)},isEligibleForJsonp:function(t){var e=["nusxj"],n=["nu5b3","l5tzj","l5d1a"],i=.01;return e.indexOf(t)>-1||this.randomDecision(i)&&n.indexOf(t)>-1},randomDecision:function(t){return Math.random<t},buildScript:function(t){var e=document.createElement("script");e.src=t,document.body.appendChild(e)},cs:!0,buildIframe:function(t){if(twttr.conversion.cs){twttr.conversion.cs=!1;var e=document.createElement("iframe");e.src=t,e.hidden=!0,document.body.appendChild(e)}},buildPixel:function(t){var e=new Image;e.src=t},isDocumentHidden:function(){var t=this.getHiddenProp();return t&&document[t]},getHiddenProp:function(){var t=["webkit","moz","ms","o"];if("hidden"in document)return"hidden";for(var e=0;e<t.length;e++)if(t[e]+"Hidden"in document)return t[e]+"Hidden";return null},buildPixelWhenVizChange:function(t,e,n){var i=e.replace(/[H|h]idden/,"")+"visibilitychange",r=function(){n(t),document.removeEventListener(i,r,!1)}.bind(this);document.addEventListener(i,r,!1)},getIframeStatus:function(){try{return this.isIframed()?this.IframeStatusCodes.NOT_IN_IFRAME:this.IframeStatusCodes.IN_IFRAME}catch(t){return this.IframeStatusCodes.ERROR}},isIframed:function(){return window.self===window.top},IframeStatusCodes:{NOT_IN_IFRAME:{value:0},IN_IFRAME:{value:1},ERROR:{value:2}},loadPixels:function(t){var e,n;"hif"in t&&(e=t.hif,e.forEach(twttr.conversion.buildIframe)),"tags"in t&&(n=t.tags,n.forEach(twttr.conversion.buildPixel))}}}();
/*
     FILE ARCHIVED ON 00:09:21 May 16, 2016 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 00:04:10 May 11, 2018.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  LoadShardBlock: 1354.63 (18)
  esindex: 0.051 (5)
  CDXLines.iter: 414.191 (12)
  PetaboxLoader3.datanode: 859.318 (19)
  exclusion.robots: 1.337 (5)
  exclusion.robots.policy: 1.152 (5)
  RedisCDXSource: 32.971 (5)
  PetaboxLoader3.resolve: 118.92
  load_resource: 132.598
*/