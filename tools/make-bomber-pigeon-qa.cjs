// Separate QA movie: replace only Day 1's embedded XML, leaving release intact.
const fs=require('fs'),zlib=require('zlib');
const input=fs.readFileSync('build/get-my-roof-remaster.swf');
const body=input.toString('ascii',0,3)==='CWS'?zlib.inflateSync(input.subarray(8)):input.subarray(8);
const start=Math.ceil((5+4*(body[0]>>3))/8)+4;
const xml=Buffer.from('<?xml version="1.0" encoding="utf-8"?><level><name>Bomber animation QA</name><description>Isolated art test</description><sky>sky1</sky><house>house1</house><groups><group id="1"><spawner type="PigeonSpawner" entity="BomberPigeon" num="2"/><spawner type="PigeonSpawner" entity="BlackBomberPigeon" num="2"/><spawner type="PigeonSpawner" entity="BrownBomberPigeon" num="2"/></group></groups></level>');
const parts=[body.subarray(0,start)];let pos=start,changed=0;
while(pos<body.length){const h=body.readUInt16LE(pos);pos+=2;const code=h>>6;let len=h&63;if(len===63){len=body.readUInt32LE(pos);pos+=4;}let data=body.subarray(pos,pos+len);pos+=len;
 if(code===87&&data.readUInt16LE(0)===754){data=Buffer.concat([data.subarray(0,6),xml]);changed++;}
 const header=Buffer.alloc(data.length<63?2:6);header.writeUInt16LE((code<<6)|Math.min(data.length,63));if(data.length>=63)header.writeUInt32LE(data.length,2);parts.push(header,data);
}
if(changed!==1)throw Error('Expected exactly one Day 1 XML resource');
const out=Buffer.concat(parts),header=Buffer.from(input.subarray(0,8));header.write('CWS');header.writeUInt32LE(out.length+8,4);
fs.writeFileSync('build/bomber-pigeon-qa.swf',Buffer.concat([header,zlib.deflateSync(out)]));
console.log('Created isolated bomber-pigeon-qa.swf; release movie unchanged.');
