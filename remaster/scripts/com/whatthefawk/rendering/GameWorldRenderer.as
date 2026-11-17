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
   import flash.display.Graphics;
   import flash.display.GradientType;
   
   public class GameWorldRenderer extends ARenderer
   {
      
      protected static var ZERO_POINT:Point = new Point();
      
      private var m_canvasBitmapData:BitmapData;
      
      private var m_renderSurface:DisplayObjectContainer;
      
      private var m_gameWorld:GameWorld;
      
      private var m_canvasBitmap:Bitmap;
      
      private var m_blankBitmapData:BitmapData;
      private var m_environment:Sprite;
      
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
         this.m_environment = this.createRemasterEnvironment();
         this.m_canvasBitmap = new Bitmap(this.m_canvasBitmapData);
         this.m_renderSurface = param2;
         // Keep environment geometry on the display list at native resolution.
         // Baking it into the 854x480 actor canvas aliases diagonal roof edges.
         this.m_renderSurface.addChild(this.m_environment);
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
         this.m_canvasBitmapData.fillRect(this.m_canvasBitmapData.rect,0);
         // Background art is independent of the unchanged world colliders.
         getLayer(1).visible = false;
         getLayer(4).visible = false;
         this.m_canvasBitmapData.draw(_canvas,new Matrix(1,0,0,1,106.6666667,0));
         getLayer(1).visible = true;
         getLayer(4).visible = true;
      }

      private function cloud(g:Graphics, x:Number, y:Number, s:Number) : void
      {
         g.lineStyle();
         g.beginFill(0xffffff,0.92);
         g.drawEllipse(x,y+12*s,100*s,25*s);
         g.endFill();g.beginFill(0xffffff,0.92);
         g.drawEllipse(x+14*s,y+3*s,35*s,32*s);
         g.endFill();g.beginFill(0xffffff,0.92);
         g.drawEllipse(x+39*s,y,39*s,35*s);
         g.endFill();g.beginFill(0xffffff,0.92);
         g.drawEllipse(x+64*s,y+10*s,29*s,24*s);
         g.endFill();
      }

      private function windowArt(g:Graphics, x:Number, y:Number) : void
      {
         // Frames and reflected glass replace the original blank panes.
         g.lineStyle();
         g.beginFill(0x683d2d,0.22);g.drawRoundRect(x+4,y+5,122,67,3);g.endFill();
         g.lineStyle(2,0x553e32);g.beginFill(0xf0d9aa);g.drawRect(x,y,120,64);g.endFill();
         g.lineStyle(1,0x806e54);g.beginFill(0x425766);g.drawRect(x+5,y+5,110,54);g.endFill();
         var m:Matrix = new Matrix();m.createGradientBox(104,48,Math.PI/2,x+8,y+8);
         g.lineStyle();g.beginGradientFill(GradientType.LINEAR,[0x2987ce,0x8ed7f4],[1,1],[0,255],m);
         g.drawRect(x+8,y+8,104,48);g.endFill();
         g.beginFill(0xffffff,0.3);
         g.moveTo(x+13,y+55);g.lineTo(x+48,y+8);g.lineTo(x+60,y+8);g.lineTo(x+25,y+55);g.lineTo(x+13,y+55);
         g.moveTo(x+70,y+55);g.lineTo(x+105,y+8);g.lineTo(x+112,y+8);g.lineTo(x+77,y+55);g.lineTo(x+70,y+55);g.endFill();
         g.lineStyle(1.5,0x776b52);g.beginFill(0xf2e1b9);g.drawRect(x+57,y+5,6,54);g.endFill();
         g.lineStyle(1.5,0x68503b);g.beginFill(0xf6dfb2);g.drawRoundRect(x-4,y+61,128,7,2);g.endFill();
      }

      private function createRemasterEnvironment() : Sprite
      {
         var root:Sprite = new Sprite();
         var g:Graphics = root.graphics;
         var m:Matrix = new Matrix();m.createGradientBox(854,480,Math.PI/2);
         g.beginGradientFill(GradientType.LINEAR,[0x2585d7,0xb8e5f4],[1,1],[0,255],m);
         g.drawRect(0,0,854,480);g.endFill();
         this.cloud(g,22,63,1.15);this.cloud(g,255,42,0.7);this.cloud(g,491,77,0.95);this.cloud(g,647,38,1.25);
         // Distant foliage stays below the combat silhouette.
         for(var shrub:int=0;shrub<28;shrub++)
         {
            var sx:Number=shrub*33;
            g.lineStyle(1.5,0x487744);g.beginFill(shrub%2==0?0x79a64d:0x88b656);
            g.drawCircle(sx,348,18+(shrub%3)*4);g.endFill();
            g.lineStyle();g.beginFill(0xb3cd69,0.45);g.drawCircle(sx-5,337,8);g.endFill();
         }
         // Continuous garden wall and lawn across the widescreen frame.
         g.lineStyle(1.5,0x74717a);g.beginFill(0xb4a9a0);g.drawRect(0,354,854,57);g.endFill();
         g.lineStyle(1,0x8c817b,0.65);
         for(var r:int=0;r<4;r++)
         {
            g.moveTo(0,359+r*14);g.lineTo(854,359+r*14);
            for(var col:int=0;col<25;col++)
            {
               var xx:Number=col*40+(r%2)*20;
               g.moveTo(xx,359+r*14);g.lineTo(xx,373+r*14);
            }
         }
         g.lineStyle(1,0x796e67);g.beginFill(0xd6ccc0);g.drawRect(0,349,854,7);g.endFill();
         m.createGradientBox(854,72,Math.PI/2,0,408);
         g.lineStyle();g.beginGradientFill(GradientType.LINEAR,[0x91b858,0x6d9c40],[1,1],[0,255],m);
         g.drawRect(0,408,854,72);g.endFill();
         // Ground path is aligned with the existing player's starting position.
         g.lineStyle(1.5,0x858576);g.beginFill(0xcec9b9);
         g.moveTo(345,415);g.lineTo(392,415);g.lineTo(424,480);g.lineTo(312,480);g.lineTo(345,415);g.endFill();
         g.lineStyle(1,0xaaa695);g.moveTo(328,454);g.lineTo(410,454);g.moveTo(339,433);g.lineTo(400,433);
         // House art uses original simulation-space roof coordinates.
         var house:Sprite = new Sprite();house.x=106.6666667;root.addChild(house);g=house.graphics;
         m.createGradientBox(450,234,Math.PI/2,38,194);
         g.lineStyle(2.5,0x593c30);g.beginGradientFill(GradientType.LINEAR,[0xf39b60,0xd17a43],[1,1],[0,255],m);
         g.drawRect(38,194,450,232);g.endFill();
         g.lineStyle();g.beginFill(0x713f28,0.2);g.drawRect(39,195,448,10);g.endFill();
         // Sparse brick accents, deliberately kept clear of characters.
         g.lineStyle(1,0xa95e38,0.7);g.beginFill(0xd57845);
         g.drawRoundRect(39,218,25,10,3);g.drawRoundRect(39,230,39,10,3);
         g.drawRoundRect(278,253,24,10,3);g.drawRoundRect(292,241,25,10,3);
         g.drawRoundRect(458,314,29,10,3);g.drawRoundRect(444,326,43,10,3);g.endFill();
         this.windowArt(g,70,228);this.windowArt(g,330,228);
         this.windowArt(g,70,330);this.windowArt(g,330,330);
         // Door and inset panels.
         g.lineStyle(2.5,0x5a3927);g.beginFill(0xb8733e);g.drawRect(233,337,59,89);g.endFill();
         g.lineStyle(2,0x62412a);g.beginFill(0x98592e);g.drawRect(239,343,47,83);g.endFill();
         g.lineStyle(1.2,0x6f4228);g.beginFill(0xa76735);g.drawRect(244,350,15,30);g.drawRect(266,350,15,30);g.drawRect(244,386,37,30);g.endFill();
         g.lineStyle(1,0x5d6061);g.beginFill(0xd9dbcf);g.drawCircle(279,386,3);g.endFill();
         // Roof top follows the two exact collision segments in HOUSE_1_XML.
         var roof:Sprite=new Sprite();house.addChild(roof);g=roof.graphics;
         m.createGradientBox(445,85,Math.PI/2,45,115);
         g.lineStyle(2.5,0x51362b);g.beginGradientFill(GradientType.LINEAR,[0xc97a4e,0x9b4d34],[1,1],[0,255],m);
         g.moveTo(45,188);g.lineTo(260,115);g.lineTo(490,190);g.lineTo(490,198);g.lineTo(45,196);g.lineTo(45,188);g.endFill();
         // Tile grid clipped to the roof, never extending above its silhouette.
         var tiles:Sprite=new Sprite();var maskShape:Sprite=new Sprite();house.addChild(tiles);house.addChild(maskShape);
         g=maskShape.graphics;g.beginFill(0);g.moveTo(47,188);g.lineTo(260,117);g.lineTo(488,190);g.lineTo(488,194);g.lineTo(47,192);g.lineTo(47,188);g.endFill();tiles.mask=maskShape;
         g=tiles.graphics;g.lineStyle(1.2,0x673b2b,0.65);
         for(r=0;r<5;r++)
         {
            var ry:Number=125+r*16;g.moveTo(40,ry);g.lineTo(495,ry+2);
            for(col=0;col<15;col++)
            {
               xx=40+col*36+(r%2)*18;g.moveTo(xx,ry);g.lineTo(xx-5,ry+16);
            }
         }
         g=roof.graphics;g.lineStyle(1.5,0xe7a475,0.85);g.moveTo(48,189);g.lineTo(260,118);g.lineTo(487,191);
         // Familiar antenna: decorative, same location as the original.
         g=house.graphics;g.lineStyle(2,0x35434a);g.moveTo(260,115);g.lineTo(260,57);g.moveTo(240,69);g.lineTo(281,69);g.moveTo(235,83);g.lineTo(286,83);
         g.lineStyle(1.3,0x3d4c54);
         for(var a:int=0;a<6;a++){xx=239+a*8;g.moveTo(xx,64);g.lineTo(xx+2,74);g.moveTo(xx-3,78);g.lineTo(xx-1,89);}
         // Small lawn marks and daisies stay away from the playable center.
         g=root.graphics;
         for(var tuft:int=0;tuft<38;tuft++)
         {
            xx=12+(tuft*79)%730;var yy:Number=420+(tuft*13)%55;
            if(xx>320&&xx<425)continue;
            g.lineStyle(1,0x5c8537,0.8);g.moveTo(xx-3,yy);g.lineTo(xx-5,yy-5);g.moveTo(xx,yy);g.lineTo(xx+2,yy-7);
         }
         return root;
      }

      public function moveCanvas(param1:int, param2:int) : void
      {
         this.m_canvasBitmap.x = param1;
         this.m_canvasBitmap.y = param2;
         this.m_environment.x = param1;
         this.m_environment.y = param2;
         Input.instance.activateWorldMouse(this.m_gameWorld,param1,param2);
      }
      
      override public function dispose() : void
      {
         this.m_renderSurface.removeChild(this.m_environment);
         this.m_environment = null;
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


