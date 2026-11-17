package fog.as3.assets
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import fog.as3.FogDevAPI;
   
   public dynamic class LogoFly extends MovieClip
   {
      
      private var speed:Number;
      
      private var targetY:Number;
      
      private var LogoFlySprite:Class = LogoFly_LogoFlySprite;
      
      private var grow:Number;
      
      private var targetX:Number;
      
      private var fade:Boolean;
      
      private var Core:FogDevAPI;
      
      public function LogoFly(param1:FogDevAPI, param2:Number, param3:Number)
      {
         super();
         this.Core = param1;
         this.x = param2;
         this.y = param3;
         this.scaleX = 0;
         this.scaleY = 0;
         this.alpha = 0;
         this.speed = 100;
         this.grow = Math.random() / 100;
         this.fade = false;
         this.cacheAsBitmap = true;
         this.gotoAndStop(Math.random() * 10 + 1);
         this.targetX = Math.random() * 10;
         this.targetY = 0;
         if(this.targetX < 5)
         {
            this.targetX = Math.random() * 10;
            if(this.targetX < 5)
            {
               this.targetX = -100;
            }
            else
            {
               this.targetX = param1.Width + 100;
            }
            this.targetY = Math.random() * param1.Height;
         }
         else
         {
            this.targetY = Math.random() * 10;
            if(this.targetY < 5)
            {
               this.targetY = -100;
            }
            else
            {
               this.targetY = param1.Height + 100;
            }
         }
         this.targetX = Math.random() * param1.Width;
         var _loc4_:MovieClip = new this.LogoFlySprite() as MovieClip;
         _loc4_.x = -(_loc4_.width / 2);
         _loc4_.y = -(_loc4_.height / 2);
         _loc4_.cacheAsBitmap = true;
         addChild(_loc4_);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.x += (this.targetX - this.x) / this.speed * 0.5;
         this.y += (this.targetY - this.y) / this.speed * 0.5;
         this.speed *= 0.99;
         this.scaleX = this.scaleY = this.scaleY + this.grow * 2;
         if(this.alpha < 1 && !this.fade)
         {
            this.alpha += 0.01;
         }
         if(this.x < -50 || this.y < -50 || this.x > this.Core.Width + 50 || this.y > this.Core.Height + 50 || this.scaleX > 2)
         {
            this.fade = true;
         }
         if(this.fade)
         {
            this.alpha -= 0.05;
            if(this.alpha <= 0)
            {
               this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               this.parent.removeChild(this);
            }
         }
      }
   }
}

