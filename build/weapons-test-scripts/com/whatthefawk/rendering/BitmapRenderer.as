package com.whatthefawk.rendering
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import com.getoffmyroof.engine.GameComponents;
   
   public class BitmapRenderer extends ARenderer
   {
      
      private var m_bmp:Bitmap;
      private var m_remaster:Sprite;
      private var m_ownsBitmap:Boolean = false;
      
      public function BitmapRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object)
      {
         var _loc5_:Sprite = null;
         var _loc6_:BitmapData = null;
         super(param1,param2,param3);
         if(param4.bitmapData)
         {
            this.m_bmp = new Bitmap(param4.bitmapData);
         }
         else if(param4.sprite)
         {
            _loc5_ = param4.sprite;
            _loc6_ = new BitmapData(_loc5_.width,_loc5_.height,true,0);
            this.m_ownsBitmap = true;
            _loc6_.draw(_loc5_);
            this.m_bmp = new Bitmap(_loc6_);
         }
         this.m_bmp.x = -this.m_bmp.width * 0.5;
         this.m_bmp.y = -this.m_bmp.height * 0.5;
         _viewBoxWidth = this.m_bmp.width;
         _viewBoxHeight = this.m_bmp.height;
         _container.addChild(this.m_bmp);
         if(["RockProjectile","WaterBalloonProjectile","FirecrackerProjectile","VinylRecordProjectile","YoYoProjectile"].indexOf(param1.type) >= 0 && param4.sprite != null)
         {
            var artClass:Class = getDefinitionByName(getQualifiedClassName(param4.sprite)) as Class;
            var art:Sprite = new artClass() as Sprite;
            if(art is MovieClip)MovieClip(art).gotoAndStop(1);
            art.x = -this.m_bmp.width * 0.5;
            art.y = -this.m_bmp.height * 0.5;
            this.m_remaster = new Sprite();
            this.m_remaster.mouseEnabled = false;
            this.m_remaster.mouseChildren = false;
            this.m_remaster.addChild(art);
            this.m_remaster.visible = false;
            GameComponents.instance.getComponent("GameScreen").addChild(this.m_remaster);
            this.m_bmp.visible = false;
         }
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         if(this.m_remaster == null)return;
         this.m_remaster.visible = _container.visible;
         this.m_remaster.x = _container.x + 106.6666667;
         this.m_remaster.y = _container.y;
         this.m_remaster.rotation = _container.rotation;
         this.m_remaster.scaleX = _container.scaleX;
         this.m_remaster.scaleY = _container.scaleY;
         this.m_remaster.alpha = _container.alpha;
      }

      override protected function draw() : void
      {
      }
      
      override protected function updateViewBox() : void
      {
         _viewBoxX = _entity.currentPos.x - this.m_bmp.width * 0.5;
         _viewBoxY = _entity.currentPos.y - this.m_bmp.height * 0.5;
      }
      
      override public function dispose() : void
      {
         if(this.m_remaster != null && this.m_remaster.parent != null)this.m_remaster.parent.removeChild(this.m_remaster);
         this.m_remaster = null;
         if(this.m_ownsBitmap && this.m_bmp != null && this.m_bmp.bitmapData != null)this.m_bmp.bitmapData.dispose();
         this.m_bmp = null;
         super.dispose();
      }
   }
}

