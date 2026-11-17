package com.getoffmyroof.weapons.projectile
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.rendering.SpriteRenderer;
   import flash.display.DisplayObjectContainer;
   
   public class BoomerangRenderer extends SpriteRenderer
   {
      
      public var spinSpeed:int = 30;
      
      public function BoomerangRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function draw() : void
      {
         _container.rotation += this.spinSpeed;
      }
   }
}

