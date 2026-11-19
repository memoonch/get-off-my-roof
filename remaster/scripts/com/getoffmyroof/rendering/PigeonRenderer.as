package com.getoffmyroof.rendering
{
   import com.getoffmyroof.entity.Pigeon;
   import com.getoffmyroof.entity.PigeonEvent;
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.rendering.AnimationRenderer;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.filters.BevelFilter;
   
   import flash.display.Sprite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.IOErrorEvent;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   import flash.geom.ColorTransform;
   import flash.utils.ByteArray;
   import com.getoffmyroof.engine.GameComponents;
   
   public class PigeonRenderer extends AnimationRenderer
   {
      
      private static const PIGEON_WET_FILTER:BevelFilter = new BevelFilter(10,1,3302911,1,3302911,1,10,10,0.5);
      
      private var m_pigeon:Pigeon;
      private static var s_frames:Array;
      private static var s_bossFrames:Array;
      private static var s_wideBossFrames:Array;
      private static var s_wideBossLoader:Loader;
      private static var s_wideBossStarted:Boolean = false;
      private static var s_bossLoader:Loader;
      private static var s_bossStarted:Boolean = false;
      private static var s_loader:Loader;
      private static var s_started:Boolean = false;
      private var m_sprite:Sprite;
      private var m_spriteBitmap:Bitmap;
      private var m_spriteAnimation:String = "";
      private var m_spriteTime:int = 0;
      private var m_pose:int = -1;
      private var m_useRemaster:Boolean = false;
      private var m_isFat:Boolean = false;
      private var m_isSoldier:Boolean = false;
      private var m_isCrazy:Boolean = false;
      private var m_isBomber:Boolean = false;
      private var m_isRocky:Boolean = false;
      private var m_isBossFat:Boolean = false;
      private var m_isBossSoldier:Boolean = false;
      private var m_isBossCrazy:Boolean = false;
      private var m_isBossBomber:Boolean = false;
      
      public function PigeonRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object = null)
      {
         super(param1,param2,param3,param4);
         this.m_pigeon = param1 as Pigeon;
         this.m_isFat = param1.type == "FatPigeon" || param1.type == "BlackFatPigeon" || param1.type == "BrownFatPigeon";
         this.m_isSoldier = param1.type == "SoldierPigeon" || param1.type == "BlackSoldierPigeon" || param1.type == "BrownSoldierPigeon";
         this.m_isCrazy = param1.type == "CrazyPigeon" || param1.type == "BlackCrazyPigeon" || param1.type == "BrownCrazyPigeon";
         this.m_isBomber = param1.type == "BomberPigeon" || param1.type == "BlackBomberPigeon" || param1.type == "BrownBomberPigeon";
         this.m_isRocky = param1.type == "BossRockyPigeon";
         this.m_isBossFat = param1.type == "BossFatPigeon";
         this.m_isBossSoldier = param1.type == "BossSoldierPigeon";
         this.m_isBossCrazy = param1.type == "BossCrazyPigeon";
         this.m_isBossBomber = param1.type == "BossBomberPigeon";
         this.m_useRemaster = this.m_isBossBomber || this.m_isBossCrazy || this.m_isBossSoldier || this.m_isBossFat || this.m_isRocky || this.m_isBomber || this.m_isFat || this.m_isSoldier || this.m_isCrazy || param1.type == "Pigeon" || param1.type == "BlackPigeon" || param1.type == "BrownPigeon";
         if(this.m_useRemaster)
         {
            this.m_sprite = new Sprite();
            this.m_sprite.mouseEnabled = false;
            this.m_sprite.mouseChildren = false;
            this.m_spriteBitmap = new Bitmap(null,"auto",true);
            this.m_spriteBitmap.scaleX = this.m_spriteBitmap.scaleY = 1.0/3;
            this.m_spriteBitmap.x = (this.m_isBossCrazy || this.m_isBossBomber) ? -55 : -45;
            this.m_spriteBitmap.y = (this.m_isBossCrazy || this.m_isBossBomber) ? -50 : (this.m_isRocky || this.m_isBossFat || this.m_isBossSoldier) ? -45 : -40;
            this.m_sprite.addChild(this.m_spriteBitmap);
            if(param1.type == "BlackPigeon" || param1.type == "BlackFatPigeon" || param1.type == "BlackSoldierPigeon" || param1.type == "BlackCrazyPigeon" || param1.type == "BlackBomberPigeon")this.m_sprite.transform.colorTransform = new ColorTransform(1,1,1,1,-50,-50,-50);
            if(param1.type == "BrownPigeon" || param1.type == "BrownFatPigeon" || param1.type == "BrownSoldierPigeon" || param1.type == "BrownCrazyPigeon" || param1.type == "BrownBomberPigeon")this.m_sprite.transform.colorTransform = new ColorTransform(1,1,1,1,-3,-19,-39);
            GameComponents.instance.getComponent("GameScreen").addChild(this.m_sprite);
            if(this.m_isBossCrazy || this.m_isBossBomber)loadWideBossSpriteAssets();
            else if(this.m_isRocky || this.m_isBossFat || this.m_isBossSoldier)loadBossSpriteAssets();
            else loadSpriteAssets();
         }
         this.m_pigeon.addEventListener(PigeonEvent.ATTACK,this.onPigeonAttack,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.DIE,this.onPigeonDie,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.FLY,this.onPigeonFly,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.HIT,this.onPigeonHit,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.JUMP,this.onPigeonJump,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.LAND,this.onPigeonLand,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.LANDING,this.onPigeonLanding,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.WET,this.onPigeonWet,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.DRY,this.onPigeonDry,false,0,true);
      }
      
      private static function loadSpriteAssets() : void
      {
         if(s_started)return;
         s_started = true;
         // Build injects the approved prepared PNG. No external requests.
         var encoded:String = "__PIGEON_ATLAS_BASE64__";
         var alphabet:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
         var bytes:ByteArray = new ByteArray();
         var value:uint = 0;
         var count:int = 0;
         for(var i:int = 0; i < encoded.length; i++)
         {
            var digit:int = alphabet.indexOf(encoded.charAt(i));
            if(digit < 0)continue;
            value = (value << 6) | digit;
            count += 6;
            if(count >= 8)
            {
               count -= 8;
               bytes.writeByte((value >> count) & 255);
            }
         }
         bytes.position = 0;
         s_loader = new Loader();
         s_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onSpriteAssetsLoaded);
         s_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onSpriteAssetsError);
         s_loader.loadBytes(bytes);
      }

      private static function onSpriteAssetsError(param1:IOErrorEvent) : void
      {
         trace("Pigeon sprite load failed: " + param1.text);
      }

      private static function onSpriteAssetsLoaded(param1:Event) : void
      {
         var atlas:BitmapData = Bitmap(s_loader.content).bitmapData;
         s_frames = [];
         for(var i:int=0; i<210; i++)
         {
            var frame:BitmapData = new BitmapData(270,240,true,0);
            frame.copyPixels(atlas,new Rectangle((i%14)*270,int(i/14)*240,270,240),new Point());
            s_frames.push(frame);
         }
         s_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onSpriteAssetsLoaded);
         s_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onSpriteAssetsError);
         s_loader.unload();
         s_loader = null;
      }


      private static function loadBossSpriteAssets() : void
      {
         if(s_bossStarted)return;
         s_bossStarted = true;
         // Build injects the approved prepared PNG. No external requests.
         var encoded:String = "__BOSS_ATLAS_BASE64__";
         var alphabet:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
         var bytes:ByteArray = new ByteArray();
         var value:uint = 0;
         var count:int = 0;
         for(var i:int = 0; i < encoded.length; i++)
         {
            var digit:int = alphabet.indexOf(encoded.charAt(i));
            if(digit < 0)continue;
            value = (value << 6) | digit;
            count += 6;
            if(count >= 8)
            {
               count -= 8;
               bytes.writeByte((value >> count) & 255);
            }
         }
         bytes.position = 0;
         s_bossLoader = new Loader();
         s_bossLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onBossSpriteAssetsLoaded);
         s_bossLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onBossSpriteAssetsError);
         s_bossLoader.loadBytes(bytes);
      }

      private static function onBossSpriteAssetsError(param1:IOErrorEvent) : void
      {
         trace("Boss sprite load failed: " + param1.text);
      }

      private static function onBossSpriteAssetsLoaded(param1:Event) : void
      {
         var atlas:BitmapData = Bitmap(s_bossLoader.content).bitmapData;
         s_bossFrames = [];
         for(var i:int=0; i<132; i++)
         {
            var frame:BitmapData = new BitmapData(270,270,true,0);
            frame.copyPixels(atlas,new Rectangle((i%12)*270,int(i/12)*270,270,270),new Point());
            s_bossFrames.push(frame);
         }
         s_bossLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onBossSpriteAssetsLoaded);
         s_bossLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onBossSpriteAssetsError);
         s_bossLoader.unload();
         s_bossLoader = null;
      }

      private static function loadWideBossSpriteAssets() : void
      {
         if(s_wideBossStarted)return;
         s_wideBossStarted = true;
         // Build injects the approved prepared PNG. No external requests.
         var encoded:String = "__WIDE_BOSS_ATLAS_BASE64__";
         var alphabet:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
         var bytes:ByteArray = new ByteArray();
         var value:uint = 0;
         var count:int = 0;
         for(var i:int = 0; i < encoded.length; i++)
         {
            var digit:int = alphabet.indexOf(encoded.charAt(i));
            if(digit < 0)continue;
            value = (value << 6) | digit;
            count += 6;
            if(count >= 8)
            {
               count -= 8;
               bytes.writeByte((value >> count) & 255);
            }
         }
         bytes.position = 0;
         s_wideBossLoader = new Loader();
         s_wideBossLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onWideBossSpriteAssetsLoaded);
         s_wideBossLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onWideBossSpriteAssetsError);
         s_wideBossLoader.loadBytes(bytes);
      }

      private static function onWideBossSpriteAssetsError(param1:IOErrorEvent) : void
      {
         trace("Wide boss sprite load failed: " + param1.text);
      }

      private static function onWideBossSpriteAssetsLoaded(param1:Event) : void
      {
         var atlas:BitmapData = Bitmap(s_wideBossLoader.content).bitmapData;
         s_wideBossFrames = [];
         for(var i:int=0; i<84; i++)
         {
            var frame:BitmapData = new BitmapData(330,300,true,0);
            frame.copyPixels(atlas,new Rectangle((i%7)*330,int(i/7)*300,330,300),new Point());
            s_wideBossFrames.push(frame);
         }
         s_wideBossLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onWideBossSpriteAssetsLoaded);
         s_wideBossLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onWideBossSpriteAssetsError);
         s_wideBossLoader.unload();
         s_wideBossLoader = null;
      }

      override public function update(param1:int) : void
      {
         super.update(param1);
         if(!this.m_useRemaster)return;
         var id:String = _animationPlayer.currentAnimationID;
         if(id != this.m_spriteAnimation)
         {
            this.m_spriteAnimation = id;
            this.m_spriteTime = 0;
         }
         else this.m_spriteTime += param1;
         var row:int = -1;
         var map:Array;
         var looping:Boolean = false;
         switch(id)
         {
            case "PigeonIdle": row=0; map=[0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,3,4,5,5,0,0,0]; looping=true; break;
            case "PigeonFly": row=1; map=[0,1,2,3,4,5,2,1]; looping=true; break;
            case "PigeonHop": row=2; map=[0,1,2,3,3,4,4,5,5]; break;
            case "PigeonLanding": row=3; map=[0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,5,5,5,5]; looping=true; break;
            case "PigeonPoo": row=4; map=[0,1,1,2,2,3,3,4,4,5,5,0]; break;
            case "PigeonHit": row=5; map=[0,1,1,2,2,2,3,3,3,4,4,5,5]; break;
            case "PigeonDeath": row=6; map=[0,1,1,2,2,3,3,4,4,5]; looping=true; break;
         }
         var ready:Boolean = s_frames != null && row >= 0;
         if(this.m_isFat && row >= 0)
         {
            if(id == "PigeonIdle")map = [0,0];
            if(id == "PigeonHit")map = [0,1,1,2,2,2,3,3,3,4,4,4,5,5];
            row += 7;
         }
         if(this.m_isSoldier && row >= 0)
         {
            if(id == "PigeonIdle")map = [0,0];
            if(id == "PigeonHop")map = [0,1,1,2,3,3,4,4,5,5];
            if(id == "PigeonLanding")map = [0,0,1,1,2,2,2,3,3,3,4,4,4,5,5,5,5,5,5];
            if(id == "PigeonHit")map = [0,1,1,2,2,2,3,3,3,4,4,4,5,5];
            if(id == "PigeonDeath")map = [0,1,1,2,2,3,3,4,4,0,0];
            row += 14;
         }
         if(this.m_isCrazy && row >= 0)
         {
            if(id == "PigeonIdle")map = [0,0,0,1,1,1,2,2,2,1,1,0,0,0,3,3,3,4,4,4,3,3,3,5,5,5,0,0,0,0];
            if(id == "PigeonDeath")map = [0,1,1,2,2,3,3,4,4,5,5];
            row += 21;
         }
         if(this.m_isBomber && row >= 0)
         {
            if(id == "PigeonIdle")map = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,0,0,0,0];
            if(id == "PigeonHit")map = [0,1,1,2,2,2,3,3,3,4,4,4,5,5];
            if(id == "PigeonDeath")map = [0,1,1,2,2,3,3,3,4,4,5,5,0];
            row += 28;
         }
         if(this.m_isRocky)
         {
            if(id == "PigeonThrowRock"){row=7;map=[0,1,1,2,2,3,3,4,4,5,5];}
            if(id == "PigeonIdle")map=[0,0];
            if(id == "PigeonLanding")map=[0,0,1,1,2,2,3,3,4,4,5,5,5,5,5,5];
            if(id == "PigeonPoo")map=[0,1,2,2,3,3,4,5,0];
            if(id == "PigeonDeath")map=[0,1,1,2,2,3,3,4,4,5,5];
         }
         if(this.m_isBossFat && row >= 0)
         {
            if(id == "PigeonIdle")map=[0,0];
            if(id == "PigeonFly")map=[0,1,1,2,3,4,5,2,1];
            if(id == "PigeonLanding")map=[0,0,1,1,2,2,2,3,3,3,4,4,4,5,5,5,5,5,5];
            if(id == "PigeonDeath")map=[0,1,1,1,2,2,2,3,3,3,4,4,4,5,5];
            row += 8;
         }
         if(this.m_isBossSoldier && row >= 0)
         {
            if(id == "PigeonIdle")map=[0,0];
            if(id == "PigeonFly")map=[0,1,1,2,3,4,5,2,1];
            if(id == "PigeonDeath")map=[0,1,1,1,2,2,2,3,3,3,4,4,4,5,5];
            row += 15;
         }
         if(this.m_isBossCrazy && row >= 0)
         {
            if(id == "PigeonIdle")map=[0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,0,0,0,0];
            if(id == "PigeonFly")map=[0,1,1,2,3,4,5,2,1];
            if(id == "PigeonLanding")map=[0,0,1,1,2,2,2,3,3,3,4,4,4,5,5,5,5,5,5];
            if(id == "PigeonDeath")map=[0,0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5];
         }
         if(this.m_isBossBomber && row >= 0)
         {
            if(id == "PigeonIdle")map=[0,0];
            if(id == "PigeonFly")map=[0,1,1,2,3,4,5,2,1];
            if(id == "PigeonDeath")map=[0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5];
            row += 7;
         }
         var spriteFrames:Array = (this.m_isBossCrazy || this.m_isBossBomber) ? s_wideBossFrames : (this.m_isRocky || this.m_isBossFat || this.m_isBossSoldier) ? s_bossFrames : s_frames;
         ready = spriteFrames != null && row >= 0;
         this.m_sprite.visible = ready && _container.visible && this.isAnimationPlayerVisible;
         _animationPlayer.visible = !ready && this.isAnimationPlayerVisible;
         if(ready)
         {
            var frame:int = int(this.m_spriteTime*30/1000);
            frame = looping ? frame%map.length : Math.min(frame,map.length-1);
            var pose:int = row*6+map[frame];
            if(pose != this.m_pose)
            {
               this.m_spriteBitmap.bitmapData = spriteFrames[pose];
               if(this.m_isRocky || this.m_isBossFat || this.m_isBossSoldier)this.m_spriteBitmap.y = (id == "PigeonThrowRock" || id == "PigeonDeath") ? -51 : -45;
               if(this.m_isBossCrazy || this.m_isBossBomber)this.m_spriteBitmap.y = id == "PigeonDeath" ? -56 : -50;
               this.m_pose = pose;
            }
            this.m_sprite.x = _container.x+106.6666667;
            this.m_sprite.y = _container.y;
            this.m_sprite.scaleX = _container.scaleX;
            this.m_sprite.scaleY = _container.scaleY;
            this.m_sprite.alpha = _container.alpha;
         }
      }

      protected function onPigeonLand(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonIdle")
         {
            _animationPlayer.play("PigeonIdle");
         }
      }
      
      protected function onPigeonLanding(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonLanding" && _animationPlayer.currentAnimationID != "PigeonHit")
         {
            _animationPlayer.play("PigeonLanding");
         }
      }
      
      protected function onPigeonJump(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonHop")
         {
            _animationPlayer.play("PigeonHop");
         }
      }
      
      protected function onPigeonFly(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonFly" && _animationPlayer.currentAnimationID != "PigeonHit")
         {
            _animationPlayer.play("PigeonFly");
         }
      }
      
      protected function onPigeonDie(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonDeath")
         {
            _animationPlayer.play("PigeonDeath");
         }
      }
      
      protected function onPigeonWet(param1:Event) : void
      {
         var _loc2_:BevelFilter = PIGEON_WET_FILTER;
         _loc2_.angle = Math.random() * 360;
         _animationPlayer.filters = [_loc2_];
         if(this.m_sprite != null)this.m_sprite.filters = [_loc2_];
      }
      
      protected function onPigeonDry(param1:Event) : void
      {
         _animationPlayer.filters = null;
         if(this.m_sprite != null)this.m_sprite.filters = null;
      }
      
      protected function onPigeonAttack(param1:PigeonEvent) : void
      {
         var _loc2_:String = "PigeonPoo";
         if(param1.data.animationID == "PigeonThrowRockWeapon")
         {
            _loc2_ = "PigeonThrowRock";
         }
         if(_animationPlayer.currentAnimationID != _loc2_)
         {
            _animationPlayer.play(_loc2_);
         }
         if(this.m_pigeon.isFlying)
         {
            _animationPlayer.queue("PigeonFly");
         }
      }
      
      protected function onPigeonHit(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonHit")
         {
            _animationPlayer.play("PigeonHit");
         }
         _animationPlayer.queue("PigeonFly");
      }
      
      override public function dispose() : void
      {
         if(this.m_sprite != null)
         {
            if(this.m_sprite.parent != null)this.m_sprite.parent.removeChild(this.m_sprite);
            this.m_spriteBitmap.bitmapData = null;
            this.m_spriteBitmap = null;
            this.m_sprite = null;
         }
         this.m_pigeon.removeEventListener(PigeonEvent.ATTACK,this.onPigeonAttack);
         this.m_pigeon.removeEventListener(PigeonEvent.DIE,this.onPigeonDie);
         this.m_pigeon.removeEventListener(PigeonEvent.FLY,this.onPigeonFly);
         this.m_pigeon.removeEventListener(PigeonEvent.HIT,this.onPigeonHit);
         this.m_pigeon.removeEventListener(PigeonEvent.JUMP,this.onPigeonJump);
         this.m_pigeon.removeEventListener(PigeonEvent.LAND,this.onPigeonLand);
         this.m_pigeon.removeEventListener(PigeonEvent.LANDING,this.onPigeonLanding);
         this.m_pigeon.removeEventListener(PigeonEvent.WET,this.onPigeonWet);
         this.m_pigeon.removeEventListener(PigeonEvent.DRY,this.onPigeonDry);
         this.m_pigeon = null;
         super.dispose();
      }
   }
}
