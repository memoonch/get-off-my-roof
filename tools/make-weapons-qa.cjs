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
if(process.env.EFFECTS_QA){
 const mode=process.env.EFFECTS_QA;
 const definitions={
  feather:['FeatherBlastEffect','FeatherBlastEffectParams','particle_pigeon_feather_1'],
  water:['WaterExplosionEffect','WaterExplosionEffectParams','com.getoffmyroof.assets::Assets_WATER_PARTICLE'],
  explosion:['ExplosionEffect','ExplosionEffectParams','com.getoffmyroof.assets::Assets_EXPLOSION_PARTICLE'],
  vinyl:['VinylRecordExplosionEffect','VinylRecordExplosionEffectParams','com.getoffmyroof.assets::Assets_VINYL_RECORD_PARTICLE'],
  splat:['PooSplatterEffect','PooSplatterEffectParams','org.flintparticles.common.displayObjects::RadialDot'],
  wipe:['WipeFaceEffect','WipeFaceEffectParams','particle_sparkle_1']
 };
 const selected=mode==='remaining'?['vinyl','splat','wipe']:[definitions[mode]?mode:'feather'];
 const predicate=selected.map(key=>'qaKind == '+JSON.stringify(definitions[key][2])).join(' || ');
 const rendererPath=folder+'/com/whatthefawk/particleEffects/ParticleRenderer.as';
 let renderer=fs.readFileSync(rendererPath,'utf8');
 renderer=renderer.replace('private var m_vectorLayer:Sprite;', 'private static var s_qaLabel:flash.text.TextField;\n      private var m_vectorLayer:Sprite;');
 renderer=renderer.replace('if(isVector)', 'if(isVector && int(com.whatthefawk.screens.Root.root.loaderInfo.parameters.qaWeapon) != 1)');
 renderer=renderer.replace('         _bitmapData.unlock();', `         var count:int = 0;
         var records:int = 0;
         var splats:int = 0;
         var sparkles:int = 0;
         var minX:Number = 10000;
         var maxX:Number = -10000;
         for each(var particle:Particle2D in param1)
         {
            var qaKind:String = getQualifiedClassName(particle.image);
            if(${predicate})
            {
               count++;
               if(qaKind == "com.getoffmyroof.assets::Assets_VINYL_RECORD_PARTICLE")records++;
               if(qaKind == "org.flintparticles.common.displayObjects::RadialDot")splats++;
               if(qaKind == "particle_sparkle_1")sparkles++;
               minX = Math.min(minX,particle.x);
               maxX = Math.max(maxX,particle.x);
            }
         }
         if(count > 0)
         {
            if(s_qaLabel == null)
            {
               s_qaLabel = new flash.text.TextField();
               s_qaLabel.defaultTextFormat = new flash.text.TextFormat("_sans",12,0xA5F3B4,true);
               s_qaLabel.width = 730;
               s_qaLabel.height = 22;
               s_qaLabel.x = 8;
               s_qaLabel.y = 34;
               s_qaLabel.background = true;
               s_qaLabel.backgroundColor = 0x161B22;
               com.whatthefawk.screens.Root.stage.addChild(s_qaLabel);
            }
            s_qaLabel.text = (int(com.whatthefawk.screens.Root.root.loaderInfo.parameters.qaWeapon) == 1 ? "ORIGINAL bitmap" : "SHARPER original vectors") + " | live " + count + " | record " + records + " splat " + splats + " wipe " + sparkles;
         }
         _bitmapData.unlock();`);
 fs.writeFileSync(rendererPath,renderer);
 let game=fs.readFileSync(folder+name,'utf8');
 const bursts=selected.map((key,index)=>{
  const def=definitions[key],x=selected.length===1?320:[200,320,440][index],y=key==='wipe'?320:260;
  return '               var burst'+index+':com.getoffmyroof.particleEffects.'+def[0]+' = new com.getoffmyroof.particleEffects.'+def[0]+'(new com.getoffmyroof.particleEffects.'+def[1]+'());\n               burst'+index+'.setPosition('+x+','+y+');\n               this.m_displayManager.addParticleEffect("ParticleEffectDisplayTop",burst'+index+');';
 }).join('\n');
 game=game.replace(/            var qaOld:int[\s\S]*?TweenMax.delayedCall\(0.12,this.m_player.deactivateSecondaryWeapon\);\s*}/,`            var qaOld:int = int(this.qaTime / 2500);
            this.qaTime += param1;
            if(int(this.qaTime / 2500) != qaOld)
            {
${bursts}
            }`);
 fs.writeFileSync(folder+name,game);
}
const result=spawnSync('java',['-jar',process.env.FFDEC_JAR||'C:/Program Files (x86)/FFDec/ffdec.jar','-onerror','abort','-importScript','build/weapons-qa-input.swf','build/weapons-qa.swf',folder],{encoding:'utf8'});
fs.writeFileSync('docs/weapons-qa-build.log',(result.stdout||'')+(result.stderr||''));
if(result.error||result.status!==0)throw result.error||Error('Weapon QA compilation failed');
console.log('Built isolated weapons QA; release progress and equipment unchanged.');
