// Keep linked button objects alive for existing scripts, but collapse their
// placements to zero scale so they have no visible art or clickable area.
const fs = require('fs');
const zlib = require('zlib');
const {spawnSync} = require('child_process');
const input = fs.readFileSync('source/get-my-roof.swf');
const body = zlib.inflateSync(input.subarray(8));
const hidden = new Set([353,347,349,335]);
const changes=[];
function matrixEnd(b,start){let bit=start*8;const read=n=>{let v=0;while(n--) {v=v*2+((b[bit>>3]>>(7-bit%8))&1);bit++;}return v;};if(read(1)){const n=read(5);read(n);read(n);}if(read(1)){const n=read(5);read(n);read(n);}const n=read(5);read(n);read(n);return Math.ceil(bit/8);}
function bits(s){while(s.length%8)s+='0';return Buffer.from(s.match(/.{8}/g).map(x=>parseInt(x,2)));}
const zeroMatrix=bits('1'+'00001'+'0'+'0'+'0'+'00001'+'0'+'0');
function tag(code,data){const h=Buffer.alloc(data.length<63?2:6);h.writeUInt16LE((code<<6)|Math.min(63,data.length));if(data.length>=63)h.writeUInt32LE(data.length,2);return Buffer.concat([h,data]);}
function patchTags(b,start=0,parent=0){const parts=[b.subarray(0,start)];let p=start;while(p<b.length){const h=b.readUInt16LE(p);p+=2;const code=h>>6;let len=h&63;if(len===63){len=b.readUInt32LE(p);p+=4;}let data=b.subarray(p,p+len);p+=len;
 if(code===39)data=patchTags(data,4,data.readUInt16LE(0));
 if(code===26&&(data[0]&2)&&(data[0]&4)){const id=data.readUInt16LE(3);if(hidden.has(id)){const end=matrixEnd(data,5);changes.push({parent,characterId:id,depth:data.readUInt16LE(1)});data=Buffer.concat([data.subarray(0,5),zeroMatrix,data.subarray(end)]);}}
 parts.push(tag(code,data));}return Buffer.concat(parts);}
const rectBits=5+4*(body[0]>>3),start=Math.ceil(rectBits/8)+4;
const patched=patchTags(body,start);
// SWF stage RECT: 960 x 540 pixels, in twips; preserve FPS and frame count.
const stageRect=bits('10000'+[0,19200,0,10800].map(v=>v.toString(2).padStart(16,'0')).join(''));
const result=Buffer.concat([stageRect,patched.subarray(Math.ceil(rectBits/8))]);
for(const id of hidden)if(!changes.some(x=>x.characterId===id))throw Error('No placement patched for '+id);
const header=Buffer.from(input.subarray(0,8));header.writeUInt32LE(result.length+8,4);
fs.mkdirSync('build',{recursive:true});
fs.writeFileSync('build/get-my-roof-remaster.swf',Buffer.concat([header,zlib.deflateSync(result)]));
fs.writeFileSync('build/menu-changes.json',JSON.stringify({hiddenButtons:{353:'Credits',347:'Add This Game to Your Website',349:'Play More Games',335:'Play More Games (pause/results)'},placements:changes},null,2)+'\n');
console.log('Built remaster; collapsed '+changes.length+' button placements.');
const jar = process.env.FFDEC_JAR || 'C:/Program Files (x86)/FFDec/ffdec.jar';
if(!fs.existsSync(jar))throw Error('Set FFDEC_JAR to the installed JPEXS ffdec.jar path.');
if(fs.existsSync('build/get-my-roof-fixed.swf'))fs.unlinkSync('build/get-my-roof-fixed.swf');
const compiled=spawnSync('java',['-jar',jar,'-onerror','abort','-importScript','build/get-my-roof-remaster.swf','build/get-my-roof-fixed.swf','remaster/scripts'],{encoding:'utf8'});
fs.writeFileSync('docs/runtime-fix-build.log',(compiled.stdout||'')+(compiled.stderr||''));
if(compiled.error||compiled.status!==0||!fs.existsSync('build/get-my-roof-fixed.swf'))throw compiled.error||Error('Runtime patch compilation failed; see docs/runtime-fix-build.log');
fs.copyFileSync('build/get-my-roof-fixed.swf','build/get-my-roof-remaster.swf');
console.log('Applied direct-to-menu startup with duplicate initialization guard.');
