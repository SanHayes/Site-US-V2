(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["pages-fund-assets_all_record"],{1834:function(t,e,a){t.exports=a.p+"static/img/card.d87c16dc.svg"},"3f5f":function(t,e,a){t.exports=a.p+"static/img/empty.d67f5618.svg"},"598d":function(t,e,a){"use strict";a.d(e,"b",(function(){return i})),a.d(e,"c",(function(){return s})),a.d(e,"a",(function(){return n}));var n={uNavbar:a("ab21").default,defaultPage:a("8516").default},i=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("v-uni-view",{staticClass:"pb-50"},[a("u-navbar",{attrs:{title:t.i18n.financialRecords}}),a("v-uni-view",{staticClass:"m-30"},[a("v-uni-view",{staticClass:"mt-30"},[t.list.length?t._l(t.list,(function(e){return a("v-uni-view",{staticClass:"p-30 box-shadow border-radius-20 mb-30 bg-black text-white"},[a("v-uni-view",{staticClass:"d-flex-between-center py-10"},[a("v-uni-text",{staticClass:"opacity-50"},[t._v(t._s(t.i18n.number))]),a("v-uni-text",{staticClass:"font-weight-bold font-size-32",style:{color:t.$utils.getColor(e.value)}},[t._v(t._s(Number(e.value)+" "+e.currency_name))])],1),a("v-uni-view",{staticClass:"d-flex-between-center py-10"},[a("v-uni-text",{staticClass:"opacity-50"},[t._v(t._s(t.i18n.time))]),a("v-uni-text",{staticClass:"font-weight-bold"},[t._v(t._s(e.created_time))])],1),a("v-uni-view",{staticClass:"py-10 font-size-30"},[t._v(t._s(e.info))])],1)})):a("default-page")],2)],1)],1)},s=[]},6250:function(t,e,a){"use strict";a.d(e,"b",(function(){return n})),a.d(e,"c",(function(){return i})),a.d(e,"a",(function(){}));var n=function(){var t=this.$createElement,e=this._self._c||t;return e("v-uni-view",{},[e("v-uni-view",[this.total?e("v-uni-text",{staticClass:"text-center opacity-50 font-size-22 py-20 d-block"},[this._v(this._s(this.$t("common.hasNoData")))]):e("v-uni-image",{staticClass:"mx-auto d-block my-30",staticStyle:{width:"320rpx",height:"240rpx"},attrs:{src:this.data}})],1),this._t("default")],2)},i=[]},"66eb":function(t,e,a){t.exports=a.p+"static/img/message.654f52a9.svg"},"6a02":function(t,e,a){"use strict";a("7a82");var n=a("4ea4").default;Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0,a("99af");var i=n(a("2909")),s={data:function(){return{currency:0,type_id:0,type_name:"",balance:{},page:1,list:[],canGet:!0,assetsType:{}}},onShow:function(){this.getLegalLog()},methods:{getLegalLog:function(){var t=this;if(this.canGet){var e=this.currency,a=this.type_id,n=this.page;this.$u.api.wallet.getLegalLog(e,a,n).then((function(e){var a=e.message.list;a.length?(t.list=[].concat((0,i.default)(t.list),(0,i.default)(a)),t.page++):t.canGet=!1}))}}},computed:{i18n:function(){return this.$t("fund")}},onReachBottom:function(){this.getLegalLog()}};e.default=s},"6a4a":function(t,e,a){"use strict";a.r(e);var n=a("6a02"),i=a.n(n);for(var s in n)["default"].indexOf(s)<0&&function(t){a.d(e,t,(function(){return n[t]}))}(s);e["default"]=i.a},7557:function(t,e,a){t.exports=a.p+"static/img/coupon.9fe7727e.svg"},"7db3":function(t,e,a){"use strict";a.r(e);var n=a("598d"),i=a("6a4a");for(var s in i)["default"].indexOf(s)<0&&function(t){a.d(e,t,(function(){return i[t]}))}(s);var c=a("f0c5"),u=Object(c["a"])(i["default"],n["b"],n["c"],!1,null,"458fa229",null,!1,n["a"],void 0);e["default"]=u.exports},"7f73":function(t,e,a){"use strict";a.r(e);var n=a("f2d7"),i=a.n(n);for(var s in n)["default"].indexOf(s)<0&&function(t){a.d(e,t,(function(){return n[t]}))}(s);e["default"]=i.a},8516:function(t,e,a){"use strict";a.r(e);var n=a("6250"),i=a("7f73");for(var s in i)["default"].indexOf(s)<0&&function(t){a.d(e,t,(function(){return i[t]}))}(s);var c=a("f0c5"),u=Object(c["a"])(i["default"],n["b"],n["c"],!1,null,"63a6c9d6",null,!1,n["a"],void 0);e["default"]=u.exports},"959f":function(t,e,a){t.exports=a.p+"static/img/collect.e5625625.svg"},"9aae":function(t,e,a){t.exports=a.p+"static/img/net.0f9f721f.svg"},a29d:function(t,e,a){t.exports=a.p+"static/img/content.7f19abd8.svg"},a82d:function(t,e,a){t.exports=a.p+"static/img/bill.fb3e16d2.svg"},b5eb:function(t,e,a){t.exports=a.p+"static/img/data.1439158f.svg"},bf4a:function(t,e,a){t.exports=a.p+"static/img/update.5a19e0e2.svg"},c43d:function(t,e,a){t.exports=a.p+"static/img/comment.60b356bc.svg"},e9ef:function(t,e,a){t.exports=a.p+"static/img/order.8f3af2d1.svg"},eb15:function(t,e,a){t.exports=a.p+"static/img/address.94a4030c.svg"},f2d7:function(t,e,a){"use strict";a("7a82"),Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0,a("a9e3");var n={name:"default-page",props:{name:{type:String,default:"empty"},length:{type:Number,default:0},total:{type:Number,default:0}},data:function(){return{list:{address:a("eb15"),bill:a("a82d"),card:a("1834"),collect:a("959f"),comment:a("c43d"),content:a("a29d"),coupon:a("7557"),data:a("b5eb"),message:a("66eb"),net:a("9aae"),order:a("e9ef"),empty:a("3f5f"),update:a("bf4a")}}},computed:{data:function(){var t=this.list[this.name];return t||(t?void 0:this.list["empty"])}}};e.default=n}}]);