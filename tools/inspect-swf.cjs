const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const crypto = require('crypto');
const original = fs.readFileSync('source/get-my-roof.swf');
const body = original.toString('ascii',0,3)==='CWS' ? zlib.inflateSync(original.subarray(8)) : original.subarray(8);
let bit=0;
function read(n,signed=false){let v=0;for(let i=0;i<n;i++,bit++)v=v*2+((body[bit>>3]>>(7-(bit%8)))&1);return signed&&v>=2**(n-1)?v-2**n:v;}
const n=read(5), rect=Array.from({length:4},()=>read(n,true));
let offset=Math.ceil(bit/8);
const header={signature:original.toString('ascii',0,3),version:original[3],bytes:original.length,uncompressedBytes:original.readUInt32LE(4),width:(rect[1]-rect[0])/20,height:(rect[3]-rect[2])/20,fps:body.readUInt16LE(offset)/256,frames:body.readUInt16LE(offset+2),sha256:crypto.createHash('sha256').update(original).digest('hex')};
function walk(dir){return fs.readdirSync(dir,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(dir,e.name)):[path.join(dir,e.name).replaceAll('\\','/')]);}
const assets=walk('decompiled').filter(p=>!p.startsWith('decompiled/timeline/')).map(p=>({path:p,bytes:fs.statSync(p).size}));
const counts={};for(const a of assets){const type=a.path.split('/')[1];counts[type]=(counts[type]||0)+1;}
fs.mkdirSync('docs/data',{recursive:true});
const data=[];
for(const p of walk('decompiled/binaryData')){const text=fs.readFileSync(p,'utf8');if(text.trimStart().startsWith('<?xml')||text.trimStart().startsWith('<')){const name=path.basename(p).replace(/^\d+_com\.getoffmyroof\.assets\.Assets_/,'').replace(/\.bin$/,'.xml');fs.writeFileSync('docs/data/'+name,text);data.push(name);}}
fs.writeFileSync('docs/asset-manifest.json',JSON.stringify({header,counts,xmlData:data,assets},null,2)+'\n');
console.log(JSON.stringify({header,counts,xmlData:data},null,2));
