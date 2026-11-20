const fs=require('fs'),zlib=require('zlib');
const targets=[
 [612,'newspaper','icon'],[647,'broom','icon'],[623,'golf-club','icon'],[643,'mop','icon'],[636,'rake','icon'],[618,'baseball-bat','icon'],[616,'pool-cue','icon'],[641,'nunchucks','icon'],[640,'shovel','icon'],
 [608,'rock','icon'],[609,'handful-of-rocks','icon'],[649,'tennis-ball','icon'],[657,'water-balloon','icon'],[654,'yo-yo','icon'],[650,'vinyl-record','icon'],[629,'firecracker','icon'],[648,'baseball','icon'],[619,'boomerang','icon'],
 [858,'newspaper','melee'],[947,'broom','melee'],[1013,'golf-club','melee'],[1009,'mop','melee'],[784,'rake','melee'],[848,'baseball-bat','melee'],[741,'pool-cue','melee'],[838,'nunchucks','melee'],[950,'shovel','melee'],
 [891,'rock','projectile'],[953,'tennis-ball','projectile'],[757,'water-balloon','projectile'],[789,'yo-yo','projectile'],[943,'vinyl-record','projectile'],[979,'firecracker','projectile'],[1040,'baseball','projectile'],[751,'boomerang','projectile']
];
class Reader{
 constructor(b,p=0){this.b=b;this.p=p*8;}
 read(n,signed=false){let v=0;for(let i=0;i<n;i++,this.p++)v=v*2+((this.b[this.p>>3]>>(7-this.p%8))&1);return signed&&v>=2**(n-1)?v-2**n:v;}
 align(){this.p=Math.ceil(this.p/8)*8;} get pos(){return Math.ceil(this.p/8);}
 rect(){const n=this.read(5),r=Array.from({length:4},()=>this.read(n,true));this.align();return r;}
 matrix(){let a=1,d=1,b=0,c=0;if(this.read(1)){const n=this.read(5);a=this.read(n,true)/65536;d=this.read(n,true)/65536;}if(this.read(1)){const n=this.read(5);b=this.read(n,true)/65536;c=this.read(n,true)/65536;}const n=this.read(5),tx=this.read(n,true),ty=this.read(n,true);this.align();return {a,b,c,d,tx,ty};}
}
function tags(b,p=0){const out=[];while(p<b.length){const start=p,h=b.readUInt16LE(p);p+=2;let n=h&63;if(n===63){n=b.readUInt32LE(p);p+=4;}out.push({code:h>>6,data:b.subarray(p,p+n),raw:b.subarray(start,p+n)});p+=n;}return out;}
function decode(input){const body=input.toString('ascii',0,3)==='CWS'?zlib.inflateSync(input.subarray(8)):input.subarray(8);const r=new Reader(body);r.rect();const start=r.pos+4;return {input,body,start,list:tags(body,start)};}
function boundsOf(list){const defs=new Map();for(const t of list)if([2,22,32,83,39].includes(t.code))defs.set(t.data.readUInt16LE(0),t);
 function bounds(id,stack=[]){if(stack.includes(id))throw Error('Recursive sprite '+id);const t=defs.get(id);if(!t)throw Error('No graphic '+id);if(t.code!==39)return new Reader(t.data,2).rect();
  const depths=new Map();for(const child of tags(t.data,4)){
   if(child.code===1)break;
   if(child.code===28){depths.delete(child.data.readUInt16LE(0));continue;}
   if(child.code!==26&&child.code!==70&&child.code!==4)continue;
   const b=child.data;let p=0,flags=6,flags2=0,depth,id2,m;
   if(child.code===4){id2=b.readUInt16LE(0);depth=b.readUInt16LE(2);p=4;}
   else {flags=b[p++];if(child.code===70)flags2=b[p++];depth=b.readUInt16LE(p);p+=2;if((flags2&8)||((flags2&16)&&(flags&2)))while(b[p++]!==0){}if(flags&2){id2=b.readUInt16LE(p);p+=2;}}
   if(flags&4)m=new Reader(b,p).matrix();const old=depths.get(depth)||{};depths.set(depth,{id:id2===undefined?old.id:id2,m:m||old.m||{a:1,b:0,c:0,d:1,tx:0,ty:0}});
  }
  const points=[];for(const item of depths.values()){if(item.id===undefined)continue;const r=bounds(item.id,[...stack,id]),m=item.m;for(const x of [r[0],r[1]])for(const y of [r[2],r[3]])points.push([m.a*x+m.c*y+m.tx,m.b*x+m.d*y+m.ty]);}
  if(!points.length)throw Error('Empty sprite '+id);return [Math.floor(Math.min(...points.map(p=>p[0]))),Math.ceil(Math.max(...points.map(p=>p[0]))),Math.floor(Math.min(...points.map(p=>p[1]))),Math.ceil(Math.max(...points.map(p=>p[1])))];
 }return bounds;}
function inspect(file='source/get-my-roof.swf'){const swf=decode(fs.readFileSync(file)),bounds=boundsOf(swf.list);return targets.map(([id,name,kind])=>{const sprite=swf.list.find(t=>t.code===39&&t.data.readUInt16LE(0)===id);return {id,name,kind,bounds:bounds(id),frames:sprite.data.readUInt16LE(2),labels:tags(sprite.data,4).filter(t=>t.code===43).map(t=>t.data.toString('utf8').split('\0')[0])};});}
class Writer{
 constructor(){this.bits='';}put(v,n){if(v<0)v+=2**n;this.bits+=v.toString(2).padStart(n,'0');return this;}
 end(){return Buffer.from(this.bits.padEnd(Math.ceil(this.bits.length/8)*8,'0').match(/.{8}/g).map(v=>parseInt(v,2)));}
}
const signedBits=values=>Math.max(2,...values.map(v=>{let n=2;while(v<-(2**(n-1))||v>=2**(n-1))n++;return n;}));
function rect(r){const n=signedBits(r),w=new Writer().put(n,5);for(const v of r)w.put(v,n);return w.end();}
function matrix(a,d,tx,ty){const v=[Math.round(a*65536),Math.round(d*65536)],n=signedBits(v),m=signedBits([tx,ty]);return new Writer().put(1,1).put(n,5).put(v[0],n).put(v[1],n).put(0,1).put(m,5).put(tx,m).put(ty,m).end();}
function tag(code,data){const b=Buffer.alloc(data.length<63?2:6);b.writeUInt16LE((code<<6)|Math.min(63,data.length));if(data.length>=63)b.writeUInt32LE(data.length,2);return Buffer.concat([b,data]);}
const u16=v=>{const b=Buffer.alloc(2);b.writeUInt16LE(v);return b;};
function bitmapShape(id,bitmapId,r,width,height){const w=new Writer(),move=signedBits([r[0],r[2]]);w.put(1,4).put(0,4).put(0,1).put(5,5).put(move,5).put(r[0],move).put(r[2],move).put(1,1);
 for(const [v,vertical]of[[r[1]-r[0],0],[r[3]-r[2],1],[r[0]-r[1],0],[r[2]-r[3],1]]){const n=signedBits([v]);w.put(1,1).put(1,1).put(n-2,4).put(0,1).put(vertical,1).put(v,n);}w.put(0,6);
 return tag(32,Buffer.concat([u16(id),rect(r),Buffer.from([1,0x41]),u16(bitmapId),matrix((r[1]-r[0])/width,(r[3]-r[2])/height,r[0],r[2]),Buffer.from([0]),w.end()]));}
function patchFile(file){const manifest=JSON.parse(fs.readFileSync('remaster/assets/weapons/integration-manifest.json')),map=new Map(manifest.assets.map(v=>[v.id,v])),swf=decode(fs.readFileSync(file)),parts=[swf.body.subarray(0,swf.start)];let nextId=20000,changed=0;
 for(const t of swf.list){const asset=t.code===39?map.get(t.data.readUInt16LE(0)):null;if(!asset){parts.push(t.raw);continue;}const bitmapId=nextId++,shapeId=nextId++;
  const raw=fs.readFileSync('remaster/assets/weapons/'+asset.raw);if(raw.length!==asset.width*asset.height*4)throw Error('Invalid ARGB length '+asset.name);
  parts.push(tag(36,Buffer.concat([u16(bitmapId),Buffer.from([5]),u16(asset.width),u16(asset.height),zlib.deflateSync(raw)])),bitmapShape(shapeId,bitmapId,asset.bounds,asset.width,asset.height));
  const control=tags(t.data,4).filter(v=>![4,26,70,5,28,0].includes(v.code)).map(v=>v.raw);
  parts.push(tag(39,Buffer.concat([t.data.subarray(0,4),tag(26,Buffer.concat([Buffer.from([6]),u16(1),u16(shapeId),Buffer.from([0])])),...control,tag(0,Buffer.alloc(0))])));changed++;
 }
 if(changed!==map.size)throw Error('Weapon replacements missing: '+changed+'/'+map.size);
 const body=Buffer.concat(parts),header=Buffer.from(swf.input.subarray(0,8));header.write('CWS');header.writeUInt32LE(body.length+8,4);fs.writeFileSync(file,Buffer.concat([header,zlib.deflateSync(body)]));console.log('Replaced '+changed+' weapon symbols; original bounds, frame counts and labels retained.');
}
module.exports={inspect,patchFile};
if(require.main===module){fs.writeFileSync('remaster/assets/weapons/original-registrations.json',JSON.stringify({assets:inspect()},null,2));console.log('Wrote original weapon registrations.');}
