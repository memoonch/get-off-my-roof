package com.whatthefawk.rendering
{
   import com.whatthefawk.entity.GameWorld;
   import com.whatthefawk.utils.Input;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class GameWorldRenderer extends ARenderer
   {
      
      protected static var ZERO_POINT:Point = new Point();
      
      private var m_canvasBitmapData:BitmapData;
      
      private var m_renderSurface:DisplayObjectContainer;
      
      private var m_gameWorld:GameWorld;
      
      private var m_canvasBitmap:Bitmap;
      
      private var m_blankBitmapData:BitmapData;
      private var m_environment:BitmapData;
      
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
         this.m_blankBitmapData = new BitmapData(854,480,true,0);
         this.m_canvasBitmapData = new BitmapData(854,480,true,0);
         this.m_environment = new BitmapData(640,480,true,0);
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
         this.m_canvasBitmapData.draw(_canvas,new Matrix(1,0,0,1,106.6666667,0));
         // Extend only scenery, never mirror enemies, projectiles, or the HUD.
         var left:Rectangle = new Rectangle(0,0,106.6666667,480);
         var right:Rectangle = new Rectangle(631.6666667,0,106.6666667,480);
         this.m_canvasBitmapData.draw(getLayer(1),new Matrix(-1,0,0,1,106.6666667,0),null,null,left,true);
         this.m_canvasBitmapData.draw(getLayer(1),new Matrix(-1,0,0,1,1156.6666667,0),null,null,right,true);
         this.m_environment.fillRect(this.m_environment.rect,0);
         this.m_environment.draw(getLayer(4));
         for(var row:int = 0; row < 480; row++)
         {
            var leftColor:uint = this.m_environment.getPixel32(1,row);
            var rightColor:uint = this.m_environment.getPixel32(524,row);
            if((leftColor >>> 24) != 0)
            {
               this.m_canvasBitmapData.fillRect(new Rectangle(0,row,107,1),leftColor);
            }
            if((rightColor >>> 24) != 0)
            {
               this.m_canvasBitmapData.fillRect(new Rectangle(631,row,108,1),rightColor);
            }
         }
      }
      
      public function moveCanvas(param1:int, param2:int) : void
      {
         this.m_canvasBitmap.x = param1;
         this.m_canvasBitmap.y = param2;
         Input.instance.activateWorldMouse(this.m_gameWorld,param1,param2);
      }
      
      override public function dispose() : void
      {
         this.m_environment.dispose();
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


