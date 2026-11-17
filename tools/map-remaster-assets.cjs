const fs=require('fs');
const names=['PLAYER_ANIMATIONS','PIGEON_ANIMATIONS','HOUSE_BACKGROUND_1','BACKGROUND_SKY_1','NEWSPAPER_ANIMATIONS','NEWSPAPER_ICON','ROCK_ICON'];
const csv=fs.readFileSync('decompiled/symbolClass/symbols.csv','utf8').split(/\r?\n/);
let report='# First playable slice — asset map\n\nFrame numbers below are one-based XFL timeline positions. Preserve exact labels, frame timing, linkage, pivots, and animation capture bounds.\n\n';
const aliases={HOUSE_BACKGROUND_1:'house_background',NEWSPAPER_ICON:'NewspaperIcon',ROCK_ICON:'RockIcon'};
const manifest=[];
for(const name of names){const row=csv.find(r=>r.endsWith(';'+String.fromCharCode(34)+(aliases[name]||'com.getoffmyroof.assets.Assets_'+name)+'"'));if(!row){manifest.push({name,note:'Resolve via Assets.as before production'});continue;}const id=Number(row.split(';')[0]);const file=`decompiled/timeline/get-my-roof/LIBRARY/Symbol ${id}.xml`;const labels=[];if(fs.existsSync(file)){const xml=fs.readFileSync(file,'utf8');for(const tag of xml.matchAll(/<DOMFrame\b[^>]*>/g)){const label=tag[0].match(/\bname="([^"]+)"/),index=tag[0].match(/\bindex="(\d+)"/);if(label&&index)labels.push({label:label[1],frame:Number(index[1])+1});}}manifest.push({name,id,file:fs.existsSync(file)?file:null,labels});report+=`## ${name} · symbol ${id}\n\n`;if(labels.length)report+='| Label | Frame |\n| --- | ---: |\n'+labels.map(x=>`| ${x.label} | ${x.frame} |`).join('\n')+'\n\n';else report+='Static asset or nested composition; inspect its linked symbol before replacement.\n\n';}
fs.mkdirSync('remaster/design',{recursive:true});fs.writeFileSync('remaster/design/asset-map.json',JSON.stringify(manifest,null,2)+'\n');fs.writeFileSync('remaster/design/asset-map.md',report);
console.log(manifest.map(x=>({name:x.name,id:x.id,labels:x.labels?.length,note:x.note})));


