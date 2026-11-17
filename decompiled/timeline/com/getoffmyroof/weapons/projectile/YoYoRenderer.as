package com.getoffmyroof.weapons.projectile
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.rendering.BitmapRenderer;
   import flash.display.DisplayObjectContainer;
   
   public class YoYoRenderer extends BitmapRenderer
   {
      
      public var yoYoLineColor:uint = 14540253;
      
      public var yoYoLineThickness:Number = 1.2;
      
      public var yoYoProjectile:YoYoProjectile;
      
      public var yoYoLineAlpha:Number = 0.5;
      
      public var yoYoOffset:Vector2D;
      
      public function YoYoRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object)
      {
         super(param1,param2,param3,param4);
         this.yoYoOffset = new Vector2D(12,-25);
         this.yoYoProjectile = param1 as YoYoProjectile;
      }
      
      override protected function draw() : void
      {
         super.draw();
         g.clear();
         g.lineStyle(this.yoYoLineThickness,this.yoYoLineColor,this.yoYoLineAlpha);
         g.moveTo(0,0);
         g.lineTo(this.yoYoProjectile.shooter.currentPos.x + this.yoYoOffset.x - this.yoYoProjectile.currentPos.x,this.yoYoProjectile.shooter.currentPos.y + this.yoYoOffset.y - this.yoYoProjectile.currentPos.y);
      }
   }
}

