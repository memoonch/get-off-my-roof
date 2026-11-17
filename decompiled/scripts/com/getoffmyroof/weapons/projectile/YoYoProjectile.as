package com.getoffmyroof.weapons.projectile
{
   import com.whatthefawk.ai.steering.behaviors.Seek;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.weapons.projectile.Projectile;
   import com.whatthefawk.weapons.projectile.ProjectileParams;
   
   public class YoYoProjectile extends Projectile
   {
      
      protected var _maxFlightTime:int = 1500;
      
      protected var _maxStringLength:int = 320;
      
      protected var _returnSpeed:Number = 0.1;
      
      protected var _isReturning:Boolean = false;
      
      protected var _returnDistance:int = 25;
      
      protected var _stringLength:int = 0;
      
      protected var _flightTime:int = 0;
      
      public function YoYoProjectile(param1:ProjectileParams)
      {
         super(param1);
         this._returnDistance *= this._returnDistance;
         this._maxStringLength *= this._maxStringLength;
      }
      
      override public function update(param1:int) : void
      {
         var _loc2_:Vector2D = null;
         super.update(param1);
         this._flightTime += param1;
         this._stringLength = currentPos.distanceSqTo(shooter.currentPos);
         if(this._stringLength >= this._maxStringLength || this._flightTime >= this._maxFlightTime)
         {
            this._isReturning = true;
         }
         if(this._isReturning)
         {
            if(this._stringLength <= this._returnDistance)
            {
               die();
               return;
            }
            if(shooter)
            {
               _loc2_ = Seek.force(this,shooter.currentPos);
               if(this._stringLength > 14400)
               {
                  _loc2_.times(this._returnSpeed);
               }
               applyForce(_loc2_);
            }
         }
      }
   }
}

