package com.getoffmyroof.ai.states.conditions
{
   import com.getoffmyroof.entity.Player;
   import com.whatthefawk.ai.FSM.ACondition;
   import com.whatthefawk.ai.FSM.ICondition;
   import com.whatthefawk.weapons.projectile.Projectile;
   
   public class ProjectileInRangeCondition extends ACondition implements ICondition
   {
      
      private var m_panicDistance:int;
      
      public function ProjectileInRangeCondition(param1:int = 20)
      {
         super();
         this.m_panicDistance = param1;
      }
      
      public function set panicDistance(param1:int) : void
      {
         this.m_panicDistance = param1;
      }
      
      override public function test(param1:*) : Boolean
      {
         var _loc3_:Projectile = null;
         var _loc4_:Number = NaN;
         var _loc2_:Array = param1.parent.getChildren(Projectile);
         if(_loc2_.length <= 0)
         {
            return false;
         }
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.shooter is Player)
            {
               _loc4_ = Number(param1.currentPos.distanceTo(_loc3_.currentPos));
               if(_loc4_ - param1.radius <= this.m_panicDistance)
               {
                  return true;
               }
            }
         }
         return false;
      }
   }
}

