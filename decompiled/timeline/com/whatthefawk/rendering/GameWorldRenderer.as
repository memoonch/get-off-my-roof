package com.whatthefawk.rendering
{
   import com.whatthefawk.entity.GameWorld;
   import com.whatthefawk.utils.Input;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class GameWorldRenderer extends ARenderer
   {
      
      protected static var ZERO_POINT:Point = new Point();
      
      private var m_canvasBitmapData:BitmapData;
      
      private var m_renderSurface:DisplayObjectContainer;
      
      private var m_gameWorld:GameWorld;
      
      private var m_canvasBitmap:Bitmap;
      
      private var m_blankBitmapData:BitmapData;
      
      private const MAX_LAYERS:int = 16;
      
      public function GameWorldRenderer(param1:GameWorld, param2:DisplayObjectContainer)
      {
         var _loc4_:Sprite = null;
         var _loc3_:Sprite = new Sprite();
         var _loc5_:int = 0;
         while(_loc5_ < this.MAX_LAYERS)
         {
            _loc4_ = new Sprite();
            _loc3_.addChild(_loc4_);
            _loc5_++;
         }
         super(param1,param1.camera,_loc3_);
         this.m_gameWorld = param1;
         this.m_blankBitmapData = new BitmapData(param1.camera.bounds.width,param1.camera.bounds.height,true,16711680);
         this.m_canvasBitmapData = new BitmapData(param1.camera.bounds.width,param1.camera.bounds.height,true,0);
         this.m_canvasBitmap = new Bitmap(this.m_canvasBitmapData);
         this.m_renderSurface = param2;
         this.m_renderSurface.addChild(this.m_canvasBitmap);
      }
      
      public function getLayer(param1:int) : Sprite
      {
         if(param1 < 1 || param1 > this.MAX_LAYERS)
         {
            throw new Error("<GameWorldRenderer::getLayer()> Value must be between 1 and " + this.MAX_LAYERS);
         }
         return Sprite(_canvas.getChildAt(param1 - 1));
      }
      
      override public function update(param1:int) : void
      {
         this.m_canvasBitmapData.copyPixels(this.m_blankBitmapData,this.m_blankBitmapData.rect,GameWorldRenderer.ZERO_POINT);
         this.m_canvasBitmapData.draw(_canvas);
      }
      
      public function moveCanvas(param1:int, param2:int) : void
      {
         this.m_canvasBitmap.x = param1;
         this.m_canvasBitmap.y = param2;
         Input.instance.activateWorldMouse(this.m_gameWorld,param1,param2);
      }
      
      override public function dispose() : void
      {
         this.m_canvasBitmapData.dispose();
         this.m_renderSurface.removeChild(this.m_canvasBitmap);
         this.m_blankBitmapData = null;
         this.m_canvasBitmap = null;
         this.m_canvasBitmapData = null;
         this.m_renderSurface = null;
         super.dispose();
      }
   }
}

