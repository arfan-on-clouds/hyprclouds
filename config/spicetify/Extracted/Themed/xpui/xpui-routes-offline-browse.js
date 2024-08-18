"use strict";(("undefined"!=typeof self?self:global).webpackChunkclient_web=("undefined"!=typeof self?self:global).webpackChunkclient_web||[]).push([[3569],{56799:(e,a,n)=>{n.d(a,{e:()=>r});var t=n(74831);const i="k270skPbT7JOaSidSA2a";var s=n(13274);const r=({iconSize:e=64,...a})=>(0,s.jsx)("div",{className:i,children:(0,s.jsx)(t.E,{iconSize:e,...a,semanticColor:"textBrightAccent","aria-hidden":!0})})},88301:(e,a,n)=>{n.r(a),n.d(a,{default:()=>z});var t=n(97500),i=n.n(t),s=n(14056),r=n(88080),l=n(47376),u=n(11620),c=n(99426),o=n(72412),d=n(9440),m=n(66774),g=n(13274);function f(e,a){switch(e.type){case d.c.ALBUM:return(0,g.jsx)(r.a,{uri:e.uri,name:e.name,images:e.images,sharingInfo:null,artists:e.artists,index:a},e.uri);case d.c.ARTIST:return(0,g.jsx)(l.a,{uri:e.uri,name:e.name,images:e.images,index:a},e.uri);case d.c.SHOW:return(0,g.jsx)(o.o,{uri:e.uri,name:e.name,images:e.images,publisher:e.publisher,sharingInfo:null,mediaType:m.Q.UNKNOWN,index:a},e.uri);case d.c.AUDIOBOOK:return(0,g.jsx)(u.M,{uri:e.uri,name:e.name,images:e.images,authorName:e.authorName,index:a},e.uri);case d.c.PLAYLIST:return(0,g.jsx)(c.B,{uri:e.uri,name:e.name,images:e.images,description:"",authorName:e.creatorName,index:a},e.uri);default:return null}}var x=n(96642),h=n(79474),p=n(98678),b=n(36575),j=n(66956),y=n(53886),v=n(73956),S=n(75653),w=n(76922),I=n(46113),P=n(12464),k=n(26271),C=n(73604),A=n(93207),E=n(56799);const N=function({uri:e,name:a,images:n,index:t}){const i=(0,P.o)(),r=(0,h.useRef)(null),l=(0,h.useRef)(!0),u=(0,h.useContext)(w._),{isPlaying:c}=(0,C.l_)(S.bV),{togglePlay:o}=(0,k.P)({uri:S.bV,pages:[{items:r.current?.map((e=>({...e,provider:null})))||[]}]},{featureIdentifier:"local_files"});(0,h.useEffect)((()=>(l.current=!0,()=>{l.current=!1})),[]);const d=(0,I.P)(),m=(0,p.YQ)((async(e,a)=>{if(!r.current){const e=await u.getTracks();r.current=e}l&&o({loggingParams:a},{uri:S.bV,pages:[{items:r.current?.map((e=>({...e,provider:null})))||[]}]})}),v.d,{leading:!0,trailing:!1});return i.canFetchAllTracks&&d?(0,g.jsx)(b.Z,{index:t,delegatePlayback:!0,delegateLogging:!0,isPlaying:c,onPlay:m,headerText:a,featureIdentifier:"local_files",uri:e,renderCardImage:()=>(0,g.jsx)(j.M,{images:n,FallbackComponent:E.e}),renderSubHeaderContent:()=>(0,g.jsx)(A.c,{children:s.Ru.get("local-files.description")})}):null},L=({index:e})=>{const a=(0,y.Iu)();return(0,g.jsx)(h.Suspense,{fallback:null,children:(0,g.jsx)(N,{index:e,name:a.name,uri:a.uri,images:a.images})})};var R=n(80245),_=n(98764);const T="tpweADmlLll_vhLLKgu2",O="e9Wimf8ZtOrZpvPbfWtg",B="zCM7ss2KtS5tWRItxyls",M=()=>(0,g.jsxs)("div",{className:O,children:[(0,g.jsx)(R.i,{size:"xxlarge",className:B}),(0,g.jsx)(_.E,{as:"h1",variant:"titleLarge",semanticColor:"textBase",dir:"auto",children:s.Ru.get("web-player.offline.empty-state.title")}),(0,g.jsx)(_.E,{as:"h2",variant:"bodyMedium",semanticColor:"textSubdued",dir:"auto",children:s.Ru.get("web-player.offline.empty-state.subtitle")})]});var W=n(95999),Z=n(85961);const z=function(){const{hasError:e,items:a}=function(){const e=(0,Z.Q)(),[a,n]=(0,h.useState)(!0),[t,i]=(0,h.useState)(!1),[s,r]=(0,h.useState)([]);return(0,h.useEffect)((()=>{(async()=>{try{const a=await e.getDownloads();r(a)}catch(e){i(!0)}finally{n(!1)}})()}),[e]),{isLoading:a,hasError:t,items:s}}(),n=(0,I.P)();return e?null:(0,g.jsx)("div",{className:i()(T,"contentSpacing"),children:a.length>0||n?(0,g.jsxs)(W.pZ,{value:"headered-grid",children:[(0,g.jsx)(x.$,{title:s.Ru.get("music_downloads"),total:a.length,seeAllUri:"/collection/music-downloads",alwaysShowSeeAll:!0,children:a.map(((e,a)=>(0,g.jsx)(W.pZ,{value:"card",index:a,children:f(e,a)},e.uri)))}),n&&(0,g.jsx)(x.$,{title:s.Ru.get("local-files"),total:1,showAll:!0,children:(0,g.jsx)(L,{index:0})})]}):(0,g.jsx)(M,{})})}},46113:(e,a,n)=>{n.d(a,{P:()=>i});var t=n(38732);function i(){return(0,t.y)()[0]}},38732:(e,a,n)=>{n.d(a,{y:()=>s});var t=n(79474),i=n(76922);function s(){const e=(0,t.useContext)(i._),[a,n]=(0,t.useState)(e.getIsEnabled());(0,t.useEffect)((()=>{const a=e.subscribeIsEnabled(n);return()=>a()}),[e]);return[a,(0,t.useCallback)((a=>e.setIsEnabled(a)),[e])]}}}]);
//# sourceMappingURL=xpui-routes-offline-browse.js.map