package com.getoffmyroof.rendering
{
   import com.getoffmyroof.entity.Player;
   import com.getoffmyroof.entity.PlayerEvent;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.rendering.AnimationRenderer;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import com.getoffmyroof.engine.GameComponents;
   
   public class PlayerRenderer extends AnimationRenderer
   {
      
      private var m_invincibleAnimationTime:int = 0;
      
      private var m_currentUseItemAnimation:String = "";
      
      private var m_player:Player;
      
      private var m_invincibleAnimationSpeed:int = 1;
      
      private var m_currentAttackAnimation:String = "";
      private static var s_frames:Array;
      private static var s_loader:Loader;
      private static var s_started:Boolean = false;
      private var m_sprite:Sprite;
      private var m_spriteBitmap:Bitmap;
      private var m_spriteTime:int = 0;
      private var m_spriteAnimation:String = "";
      private var m_pose:int = -1;
      
      public function PlayerRenderer(param1:Player, param2:GameCamera, param3:DisplayObjectContainer, param4:Object)
      {
         super(param1,param2,param3,param4);
         this.m_player = param1;
         this.m_sprite = new Sprite();
         this.m_sprite.mouseEnabled = false;
         this.m_sprite.mouseChildren = false;
         this.m_spriteBitmap = new Bitmap(null,"auto",true);
         // Original idle alpha bounds: 50x76 logical pixels. The prepared
         // illustrated idle is 205 source pixels tall; match its height
         // uniformly and keep the same foot anchor at local y=20.
         var spriteScale:Number = 76.0/205;
         this.m_spriteBitmap.scaleX = this.m_spriteBitmap.scaleY = spriteScale;
         this.m_spriteBitmap.x = -135*spriteScale;
         this.m_spriteBitmap.y = 20-240*spriteScale;
         this.m_sprite.addChild(this.m_spriteBitmap);
         GameComponents.instance.getComponent("GameScreen").addChild(this.m_sprite);
         PlayerRenderer.loadSpriteAssets();
         this.m_player.addEventListener(PlayerEvent.ATTACK,this.onPlayerAttack,false,0,true);
         this.m_player.addEventListener(PlayerEvent.DIE,this.onPlayerDie,false,0,true);
         this.m_player.addEventListener(PlayerEvent.HIT,this.onPlayerHit,false,0,true);
         this.m_player.addEventListener(PlayerEvent.IDLE,this.onPlayerIdle,false,0,true);
         this.m_player.addEventListener(PlayerEvent.JUMP,this.onPlayerJump,false,0,true);
         this.m_player.addEventListener(PlayerEvent.LAND,this.onPlayerLand,false,0,true);
         this.m_player.addEventListener(PlayerEvent.USE_WETNAP,this.onPlayerUseWetnap,false,0,true);
         this.m_player.addEventListener(PlayerEvent.WALK,this.onPlayerWalk,false,0,true);
      }
      
      private static function loadSpriteAssets() : void
      {
         if(s_started)return;
         s_started = true;
         // Build injects the approved prepared PNG. No external requests.
         var encoded:String = "__PLAYER_ATLAS_BASE64__";
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
         trace("Player sprite load failed: " + param1.text);
      }

      private static function onSpriteAssetsLoaded(param1:Event) : void
      {
         var atlas:BitmapData = Bitmap(s_loader.content).bitmapData;
         s_frames = [];
         for(var i:int=0; i<42; i++)
         {
            var frame:BitmapData = new BitmapData(270,300,true,0);
            frame.copyPixels(atlas,new Rectangle((i%6)*270,int(i/6)*300,270,300),new Point());
            s_frames.push(frame);
         }
         s_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onSpriteAssetsLoaded);
         s_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onSpriteAssetsError);
         s_loader.unload();
         s_loader = null;
      }

      override public function update(param1:int) : void
      {
         super.update(param1);
         var id:String = _animationPlayer.currentAnimationID;
         if(id != this.m_spriteAnimation)
         {
            this.m_spriteAnimation=id;
            this.m_spriteTime=0;
         }
         else this.m_spriteTime+=param1;
         var useSprites:Boolean = s_frames != null && (id == "PlayerIdle" || id == "PlayerThrow" || id == "PlayerWalk" || id == "PlayerJump" || id == "PlayerSwing" || id == "PlayerHit" || id == "PlayerWipeFace" || id == "PlayerDeath");
         this.m_sprite.visible = useSprites && _container.visible;
         _animationPlayer.visible = !useSprites && this.isAnimationPlayerVisible;
         if(useSprites)
         {
            var pose:int = 0;
            if(id == "PlayerThrow")
            {
               var map:Array = [0,1,1,2,2,3,3,4,4,4,5,5,5,0];
               pose = map[Math.min(13,int(this.m_spriteTime*30/1000))];
            }
            else if(id == "PlayerWalk")
            {
               var walkMap:Array = [0,0,1,1,2,2,3,3,4,4,5,5,0];
               pose = 6+walkMap[int(this.m_spriteTime*30/1000)%13];
            }
            else if(id == "PlayerJump")
            {
               var jumpMap:Array = [0,0,1,1,2,2,3,3,3,4,4,5,5];
               pose = 12+jumpMap[Math.min(12,int(this.m_spriteTime*30/1000))];
            }
            else if(id == "PlayerSwing")
            {
               var swingMap:Array = [0,1,1,2,2,3,3,4,4,5,5,0];
               pose = 18+swingMap[Math.min(11,int(this.m_spriteTime*30/1000))];
            }
            else if(id == "PlayerHit")
            {
               var hitMap:Array = [0,1,2,3,3,4,4,5,5];
               pose = 24+hitMap[Math.min(8,int(this.m_spriteTime*30/1000))];
            }
            else if(id == "PlayerWipeFace")
            {
               var wipeMap:Array = [0,1,1,1,2,2,2,3,3,3,3,3,3,4,4,4,5,5,0];
               pose = 30+wipeMap[Math.min(18,int(this.m_spriteTime*30/1000))];
            }
            else if(id == "PlayerDeath")
            {
               var deathMap:Array = [0,1,1,2,2,3,4,5,5];
               pose = 36+deathMap[Math.min(8,int(this.m_spriteTime*30/1000))];
            }
            if(pose != this.m_pose)
            {
               this.m_spriteBitmap.bitmapData = s_frames[pose];
               this.m_pose = pose;
            }
            this.m_sprite.x = _container.x + 106.6666667;
            this.m_sprite.y = _container.y;
            this.m_sprite.scaleX = _container.scaleX;
            this.m_sprite.scaleY = _container.scaleY;
            this.m_sprite.alpha = _container.alpha;
         }
      }

      override protected function draw() : void
      {
         super.draw();
         if(this.m_player.statSystem.hasStatEffect("invincibility"))
         {
            this.m_invincibleAnimationTime += this.m_invincibleAnimationSpeed;
            _container.alpha = Math.sin(this.m_invincibleAnimationTime);
         }
         else
         {
            this.m_invincibleAnimationTime = 0;
            this.fadeTo(1,0.3);
         }
      }
      
      protected function onPlayerWalk(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerWalk" && _animationPlayer.currentAnimationID != "PlayerJump" && _animationPlayer.currentAnimationID != "PlayerHit" && _animationPlayer.currentAnimationID != this.m_currentAttackAnimation)
         {
            _animationPlayer.play("PlayerWalk");
         }
      }
      
      protected function onPlayerHit(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerHit")
         {
            _animationPlayer.play("PlayerHit");
         }
      }
      
      protected function onPlayerAttack(param1:PlayerEvent) : void
      {
         if(!param1.data || !param1.data.animationID)
         {
            return;
         }
         var _loc2_:String = param1.data.animationID;
         if(_animationPlayer.currentAnimationID != _loc2_)
         {
            this.m_currentAttackAnimation = _loc2_;
            _animationPlayer.play(_loc2_);
         }
      }
      
      protected function onPlayerLand(param1:PlayerEvent) : void
      {
      }
      
      protected function fadeTo(param1:Number, param2:Number = 0.1, param3:Number = 0.1) : void
      {
         if(_container.alpha == param1)
         {
            return;
         }
         if(_container.alpha < param1 + param3 && _container.alpha > param1 - param3)
         {
            param2 = param1;
            return;
         }
         if(_container.alpha < param1 + param2 && _container.alpha > param1 - param2)
         {
            param2 = param3;
         }
         if(_container.alpha > param1)
         {
            _container.alpha -= param2;
         }
         if(_container.alpha < param1)
         {
            _container.alpha += param2;
         }
      }
      
      protected function onPlayerDie(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerDeath")
         {
            _animationPlayer.play("PlayerDeath");
         }
      }
      
      protected function onPlayerIdle(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerIdle" && _animationPlayer.currentAnimationID != "PlayerHit" && _animationPlayer.currentAnimationID != "PlayerWipeFace" && _animationPlayer.currentAnimationID != this.m_currentAttackAnimation && _animationPlayer.currentAnimationID != this.m_currentUseItemAnimation)
         {
            _animationPlayer.play("PlayerIdle");
         }
      }
      
      protected function onPlayerJump(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerJump")
         {
            _animationPlayer.play("PlayerJump");
         }
      }
      
      protected function onPlayerUseWetnap(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerWipeFace")
         {
            _animationPlayer.play("PlayerWipeFace");
         }
      }
      
      override public function dispose() : void
      {
         if(this.m_sprite.parent != null)this.m_sprite.parent.removeChild(this.m_sprite);
         this.m_spriteBitmap.bitmapData = null;
         this.m_spriteBitmap = null;
         this.m_sprite = null;
         this.m_player.removeEventListener(PlayerEvent.ATTACK,this.onPlayerAttack);
         this.m_player.removeEventListener(PlayerEvent.DIE,this.onPlayerDie);
         this.m_player.removeEventListener(PlayerEvent.HIT,this.onPlayerHit);
         this.m_player.removeEventListener(PlayerEvent.IDLE,this.onPlayerIdle);
         this.m_player.removeEventListener(PlayerEvent.JUMP,this.onPlayerJump);
         this.m_player.removeEventListener(PlayerEvent.LAND,this.onPlayerLand);
         this.m_player.removeEventListener(PlayerEvent.USE_WETNAP,this.onPlayerUseWetnap);
         this.m_player.removeEventListener(PlayerEvent.WALK,this.onPlayerWalk);
         this.m_player = null;
         super.dispose();
      }
   }
}

