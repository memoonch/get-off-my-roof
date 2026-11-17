package com.whatthefawk.weapons.projectile
{
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.utils.Params;
   
   public class ProjectileFireParams extends Params
   {
      
      public var target:Vector2D;
      
      public var fireForce:Vector2D;
      
      public var shooter:MovingEntity;
      
      public var firePosition:Vector2D;
      
      public function ProjectileFireParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

