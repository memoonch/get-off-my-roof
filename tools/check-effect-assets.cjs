// Protect the original particle artwork while its display path is enhanced.
const fs=require('node:fs'),zlib=require('node:zlib'),assert=require('node:assert/strict');
function graphics(file){
 const input=fs.readFileSync(file),body=input.toString('ascii',0,3)==='CWS'?zlib.inflateSync(input.subarray(8)):input.subarray(8);
 let pos=Math.ceil((5+4*(body[0]>>3))/8)+4;
 const result=new Map();
 while(pos<body.length){
  const header=body.readUInt16LE(pos);pos+=2;let size=header&63;
  if(size===63){size=body.readUInt32LE(pos);pos+=4;}
  if([2,22,32,83,39].includes(header>>6)){const data=body.subarray(pos,pos+size);result.set(data.readUInt16LE(0),data);}
  pos+=size;
 }
 return result;
}
const original=graphics('source/get-my-roof.swf'),release=graphics('build/get-my-roof-remaster.swf');
for(const id of [152,153,842,843,746,747,961,962,605,606]){
 assert(original.has(id),'Missing original symbol '+id);
 assert.deepEqual(release.get(id),original.get(id),'Original effect artwork changed: '+id);
}
assert.equal(fs.readFileSync('remaster/scripts/com/getoffmyroof/particleEffects/FeatherBlastEffect.as','utf8'),fs.readFileSync('decompiled/scripts/com/getoffmyroof/particleEffects/FeatherBlastEffect.as','utf8'));
console.log('Original feather, water, explosion, record and sparkle artwork is unchanged; original feather emitter retained.');
