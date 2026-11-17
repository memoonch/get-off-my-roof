package com.whatthefawk.rendering
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.math.Vector2D;
   import flash.display.DisplayObjectContainer;
   
   public class EntityRenderer extends ARenderer
   {
      
      protected var _heading:Vector2D;
      
      public var isHitAreaRadiusVisible:Boolean = false;
      
      public var boundsColor:uint = 0;
      
      public var radiusColor:uint = 0;
      
      public var isBoundsVisible:Boolean = false;
      
      public var isRadiusVisible:Boolean = true;
      
      public function EntityRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object)
      {
         super(param1,param2,param3);
         if(param4.radiusColor != null)
         {
            this.radiusColor = param4.radiusColor;
         }
         if(param4.boundsColor != null)
         {
            this.boundsColor = param4.boundsColor;
         }
         if(param4.isRadiusVisible != null)
         {
            this.isRadiusVisible = param4.isRadiusVisible;
         }
         if(param4.isBoundsVisible != null)
         {
            this.isBoundsVisible = param4.isBoundsVisible;
         }
         if(param4.isHitAreaRadiusVisible != null)
         {
            this.isHitAreaRadiusVisible = param4.isHitAreaRadiusVisible;
         }
         this._heading = new Vector2D();
         _viewBoxWidth = _entity.bounds.width;
         _viewBoxHeight = _entity.bounds.height;
      }
      
      override protected function draw() : void
      {
         g.clear();
         if(this.isRadiusVisible)
         {
            g.lineStyle(1,this.radiusColor);
            g.drawCircle(0,0,_entity.radius);
            this._heading.x = Math.cos(_entity.rotation);
            this._heading.y = Math.sin(_entity.rotation);
            g.moveTo(0,0);
            g.lineTo(this._heading.x * _entity.radius,this._heading.y * _entity.radius);
         }
         if(this.isHitAreaRadiusVisible)
         {
            g.lineStyle(2,this.radiusColor,0.5);
            g.drawCircle(_entity.hitAreaPosition.x,_entity.hitAreaPosition.y,_entity.hitAreaRadius);
         }
         if(this.isBoundsVisible)
         {
            g.lineStyle(1,this.boundsColor);
            g.drawRect(_entity.bounds.left - _entity.currentPos.x,_entity.bounds.top - _entity.currentPos.y,_entity.bounds.width,_entity.bounds.height);
         }
      }
      
      override protected function updateViewBox() : void
      {
         _viewBoxX = _entity.currentPos.x - _entity.radius;
         _viewBoxY = _entity.currentPos.y - _entity.radius;
      }
      
      override public function dispose() : void
      {
         this._heading = null;
         super.dispose();
      }
   }
}

