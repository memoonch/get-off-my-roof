package com.whatthefawk.rendering
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class BitmapRenderer extends ARenderer
   {
      
      private var m_bmp:Bitmap;
      
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
            _loc6_.draw(_loc5_);
            this.m_bmp = new Bitmap(_loc6_);
         }
         this.m_bmp.x = -this.m_bmp.width * 0.5;
         this.m_bmp.y = -this.m_bmp.height * 0.5;
         _viewBoxWidth = this.m_bmp.width;
         _viewBoxHeight = this.m_bmp.height;
         _container.addChild(this.m_bmp);
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
         this.m_bmp = null;
         super.dispose();
      }
   }
}

