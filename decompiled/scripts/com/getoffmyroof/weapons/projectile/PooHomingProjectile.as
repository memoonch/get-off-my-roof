package com.getoffmyroof.weapons.projectile
{
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.weapons.projectile.ProjectileParams;
   
   public class PooHomingProjectile extends PooProjectile
   {
      
      private var m_isForceApplied:Boolean = false;
      
      private var m_homingForce:* = 120;
      
      public function PooHomingProjectile(param1:ProjectileParams)
      {
         super(param1);
      }
      
      override public function update(param1:int) : void
      {
         var _loc2_:Vector2D = null;
         super.update(param1);
         if(!this.m_isForceApplied)
         {
            this.m_isForceApplied = true;
            _loc2_ = target.subtractedBy(currentPos).normalize();
            _loc2_.x *= this.m_homingForce;
            applyForce(_loc2_);
         }
      }
      
      public function set homingForce(param1:int) : void
      {
         this.m_homingForce = param1;
      }
      
      public function get homingForce() : int
      {
         return this.m_homingForce;
      }
   }
}

