package com.whatthefawk.rendering
{
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.entity.Wall;
   import flash.display.DisplayObjectContainer;
   
   public class WallRenderer extends ARenderer
   {
      
      public var isNormalVisible:Boolean = true;
      
      public var showWall:Boolean = false;
      
      private var m_wall:Wall;
      
      public var wallColor:uint = 0;
      
      public var normalColor:uint = 0;
      
      public var isWallVisible:Boolean = true;
      
      public function WallRenderer(param1:Wall, param2:GameCamera, param3:DisplayObjectContainer, param4:Object)
      {
         super(param1,param2,param3);
         this.m_wall = param1;
         if(param4.showWall != null)
         {
            this.showWall = param4.showWall;
         }
         if(param4.wallColor != null)
         {
            this.wallColor = param4.wallColor;
         }
         if(param4.normalColor != null)
         {
            this.normalColor = param4.normalColor;
         }
         if(param4.isWallVisible != null)
         {
            this.isWallVisible = param4.isWallVisible;
         }
         if(param4.isNormalVisible != null)
         {
            this.isNormalVisible = param4.isNormalVisible;
         }
         _viewBoxWidth = _entity.radius * 2;
         _viewBoxHeight = _entity.radius * 2;
      }
      
      override protected function draw() : void
      {
         if(!this.showWall)
         {
            return;
         }
         g.clear();
         g.lineStyle(1,this.wallColor);
         g.moveTo(this.m_wall.fromPoint.x,this.m_wall.fromPoint.y);
         g.lineTo(this.m_wall.toPoint.x,this.m_wall.toPoint.y);
         g.lineStyle(1,this.normalColor);
         g.moveTo(this.m_wall.midPoint.x,this.m_wall.midPoint.y);
         g.lineTo(this.m_wall.midPoint.x + this.m_wall.normal.x * Wall.NORMAL_DRAW_LEN,this.m_wall.midPoint.y + this.m_wall.normal.y * Wall.NORMAL_DRAW_LEN);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.m_wall = null;
      }
      
      override protected function updateViewBox() : void
      {
         _viewBoxWidth = this.m_wall.width * 0.5;
         _viewBoxHeight = this.m_wall.height * 0.5;
         _viewBoxX = this.m_wall.midPoint.x;
         _viewBoxY = this.m_wall.midPoint.y;
      }
   }
}

