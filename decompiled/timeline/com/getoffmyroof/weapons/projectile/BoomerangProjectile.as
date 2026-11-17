package com.getoffmyroof.weapons.projectile
{
   import com.whatthefawk.ai.steering.behaviors.Pursuit;
   import com.whatthefawk.ai.steering.behaviors.Seek;
   import com.whatthefawk.weapons.projectile.Projectile;
   import com.whatthefawk.weapons.projectile.ProjectileParams;
   
   public class BoomerangProjectile extends Projectile
   {
      
      protected var _returnSeekSpeed:Number = 0.05;
      
      protected var _returnDistance:int = 30;
      
      protected var _isReturning:Boolean = false;
      
      protected var _currentDistance:int = 0;
      
      protected var _seekDistance:int = 150;
      
      protected var _maxThrowDistance:int = 350;
      
      protected var _returnSpeed:Number = 0.01;
      
      public function BoomerangProjectile(param1:ProjectileParams)
      {
         super(param1);
         this._returnDistance *= this._returnDistance;
         this._maxThrowDistance *= this._maxThrowDistance;
         this._seekDistance *= this._seekDistance;
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         this._currentDistance = currentPos.distanceSqTo(shooter.currentPos);
         if(this._currentDistance <= this._returnDistance && this._isReturning)
         {
            die();
            return;
         }
         if(this._currentDistance >= this._maxThrowDistance)
         {
            this._isReturning = true;
         }
         if(this._isReturning && Boolean(shooter))
         {
            if(this._currentDistance <= this._seekDistance)
            {
               applyForce(Seek.force(this,shooter.currentPos).times(this._returnSeekSpeed));
            }
            applyForce(Pursuit.force(this,shooter).times(this._returnSpeed));
         }
         if(shooter)
         {
            applyForce(Pursuit.force(this,shooter).times(this._returnSpeed));
         }
      }
   }
}

