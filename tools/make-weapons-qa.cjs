// Isolated runtime test: parameter-selectable equipment, auto attacks, no saves.
const fs=require('fs'),zlib=require('zlib'),{spawnSync}=require('child_process');
const folder='build/weapons-test-scripts';
fs.cpSync('build/import-scripts',folder,{recursive:true});
const name='/com/getoffmyroof/screens/GameScreen.as';
let source=fs.readFileSync(folder+name,'utf8');
source=source.replace('private var m_player:Player;','private var m_player:Player;\n      private var qaTime:int = 0;');
source=source.replace('         this.loadPlayer();',`         var qaIndex:int = int(Root.root.loaderInfo.parameters.qaWeapon);
         qaIndex = Math.max(0,Math.min(8,qaIndex));
         this.m_playerController.equipment.equip(["Newspaper","Broom","GolfClub","Mop","Rake","BaseballBat","PoolStick","Numchucks","Shovel"][qaIndex],"melee");
         this.m_playerController.equipment.equip(["Rock","HandFullOfRocks","TennisBall","WaterBalloon","YoYo","VinylRecord","Firecracker","Baseball","Boomerang"][qaIndex],"projectile_1");
         for(var qaSlot:int=2;qaSlot<=6;qaSlot++)this.m_playerController.equipment.unequip("projectile_"+qaSlot);
         this.m_playerController.hasSeenTutorial = true;
         this.loadPlayer();
         this.m_player.lifeSystem.toggleGodMode();`);
source=source.replace('            this.m_displayManager.update(param1);',`            this.m_displayManager.update(param1);
            var qaOld:int = int(this.qaTime / 1000);
            this.qaTime += param1;
            if(int(this.qaTime / 1000) != qaOld)
            {
               Input.instance.worldMousePos.x = 320;
               Input.instance.worldMousePos.y = 100;
               this.m_player.activatePrimaryWeapon();
               this.m_player.activateSecondaryWeapon();
               TweenMax.delayedCall(0.12,this.m_player.deactivatePrimaryWeapon);
               TweenMax.delayedCall(0.12,this.m_player.deactivateSecondaryWeapon);
            }`);
fs.writeFileSync(folder+name,source);
const saveName='/com/getoffmyroof/save/SaveLoadManager.as';
let saveSource=fs.readFileSync('decompiled/scripts'+saveName,'utf8');
saveSource=saveSource.replace('ISaveLoad(this._saveLoadMap[param1]).save(param2);','// QA cannot write player progress.');
fs.mkdirSync(folder+'/com/getoffmyroof/save',{recursive:true});fs.writeFileSync(folder+saveName,saveSource);
const input=fs.readFileSync('build/get-my-roof-remaster.swf'),body=zlib.inflateSync(input.subarray(8));
const start=Math.ceil((5+4*(body[0]>>3))/8)+4;
const xml=Buffer.from('<level><name>Weapon art QA</name><description>Isolated art test</description><sky>sky1</sky><house>house1</house><groups><group id="1"><spawner type="PigeonSpawner" entity="Pigeon" num="50"/></group></groups></level>');
const parts=[body.subarray(0,start)];let pos=start,changed=0;
while(pos<body.length){const h=body.readUInt16LE(pos);pos+=2;const code=h>>6;let len=h&63;if(len===63){len=body.readUInt32LE(pos);pos+=4;}let data=body.subarray(pos,pos+len);pos+=len;if(code===87&&data.readUInt16LE(0)===754){data=Buffer.concat([data.subarray(0,6),xml]);changed++;}const head=Buffer.alloc(data.length<63?2:6);head.writeUInt16LE((code<<6)|Math.min(data.length,63));if(data.length>=63)head.writeUInt32LE(data.length,2);parts.push(head,data);}
if(changed!==1)throw Error('Missing Day 1 XML');
const out=Buffer.concat(parts),header=Buffer.from(input.subarray(0,8));header.writeUInt32LE(out.length+8,4);
fs.writeFileSync('build/weapons-qa-input.swf',Buffer.concat([header,zlib.deflateSync(out)]));
const result=spawnSync('java',['-jar',process.env.FFDEC_JAR||'C:/Program Files (x86)/FFDec/ffdec.jar','-onerror','abort','-importScript','build/weapons-qa-input.swf','build/weapons-qa.swf',folder],{encoding:'utf8'});
fs.writeFileSync('docs/weapons-qa-build.log',(result.stdout||'')+(result.stderr||''));
if(result.error||result.status!==0)throw result.error||Error('Weapon QA compilation failed');
console.log('Built isolated weapons QA; release progress and equipment unchanged.');
